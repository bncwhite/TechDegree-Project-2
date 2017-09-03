//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController
{
    var gameSound: SystemSoundID = 0
    var game: Game = Game()
    var answerButtons: [UIButton] = []
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var optionButtonOne: UIButton!
    @IBOutlet weak var optionButtonTwo: UIButton!
    @IBOutlet weak var optionButtonThree: UIButton!
    @IBOutlet weak var optionButtonFour: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        answerButtons = [optionButtonOne, optionButtonTwo, optionButtonThree, optionButtonFour]
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion()
    {
        let triviaQuestion = game.pickQuestion()
        questionField.text = triviaQuestion.question
        
        var randomIndexes: [Int] = []
        
        while randomIndexes.count != answerButtons.count {
            let index = GKRandomSource.sharedRandom().nextInt(upperBound: answerButtons.count)
            if !randomIndexes.contains(index)
            {
                randomIndexes.append(index)
            }
        }
        
        for button in answerButtons
        {
            button.isEnabled = true
            button.alpha = 1.0
            button.backgroundColor?.withAlphaComponent(1.0)
        }
        
        for button in answerButtons
        {
            switch randomIndexes[0]
            {
                case 0:
                    button.setTitle(triviaQuestion.answer, for: UIControlState.normal)
                case 1:
                    button.setTitle(triviaQuestion.firstFalseAnswer, for: UIControlState.normal)
                case 2:
                    button.setTitle(triviaQuestion.secondFalseAnswer, for: UIControlState.normal)
                case 3:
                    button.setTitle(triviaQuestion.thirdFalseAnswer, for: UIControlState.normal)
                    //let isDisabledButton = GKRandomSource.sharedRandom().nextBool()
                    //if isDisabledButton
                    //{
                    //    button.setTitle("N/A", for: UIControlState.normal)
                    //    button.isEnabled = false
                    //}
                default: button.titleLabel?.text = "Out of available options for this question"
            }
            randomIndexes.remove(at: 0)
        }
        
        answerLabel.isHidden = true
        playAgainButton.isHidden = true
    }
    
    func displayScore()
    {
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        game = Game()
        
        // Hide the answer buttons
        for button in answerButtons
        {
            button.isHidden = true
        }
        
        // Display play again button
        playAgainButton.isHidden = false
    }
    
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        let correctAnswer = game.currentAnswer
        
        if sender.currentTitle == correctAnswer {
            game.correctQuestions += 1
            let correctColor = UIColor(colorLiteralRed: 63 / 255.0, green: 148 / 255.0, blue: 135 / 255.0, alpha: 1.0)
            answerLabel.textColor = correctColor
            answerLabel.text = "Correct!"
        }
        else
        {
            let inCorrectColor = UIColor(colorLiteralRed: 244 / 255.0, green: 160 / 255.0, blue: 97 / 255.0, alpha: 1.0)
            answerLabel.textColor = inCorrectColor
            answerLabel.text = "Sorry, that's not it."
        }
        answerLabel.isHidden = false
        
        for button in answerButtons
        {
            button.alpha = 0.34
            button.isEnabled = false
            
            if button.currentTitle == correctAnswer
            {
                let whiteColor = UIColor(white: 1.0, alpha: 1.0)
                //button.setTitleColor(whiteColor, for: UIControlState.disabled)
                button.tintColor = whiteColor
                //button.isOpaque = false
            }
            
        }
        
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        //Wait 2 seconds then call nextRound() from within the method below
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound()
    {
        if game.questionsAsked == game.questionsPerRound
        {
            // Game is over
            displayScore()
        }
        else
        {
            //Remove the current question from the available questions if at least one question has been asked
            // Continue game
            if game.questionsAsked != 0
            {
                game.questions.remove(at: game.selectedIndex)
            }
            displayQuestion()
        }
    }
    
    @IBAction func playAgain()
    {
        // Show the answer buttons
        for button in answerButtons
        {
            button.isHidden = false
        }
        
        nextRound()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int)
    {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.answerLabel.isHidden = true
            self.nextRound()
        }
    }
    
    func loadGameStartSound()
    {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound()
    {
        AudioServicesPlaySystemSound(gameSound)
    }
}

