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
    var defaultButtonColor : UIColor = UIColor(colorLiteralRed: 12 / 255.0, green: 121 / 255.0, blue: 150 / 255.0, alpha: 1.0)
    let correctColor = UIColor(colorLiteralRed: 63 / 255.0, green: 148 / 255.0, blue: 135 / 255.0, alpha: 1.0)
    let inCorrectColor = UIColor(colorLiteralRed: 244 / 255.0, green: 160 / 255.0, blue: 97 / 255.0, alpha: 1.0)
    //var defaultDisabledTextColor = UIColor.lightGray
    
    
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
        for button in answerButtons
        {
            button.layer.cornerRadius = 5.0
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion()
    {
        game.pickQuestion()
        questionField.text = game.questionToDisplay.question
        
        for button in answerButtons
        {
            button.backgroundColor = defaultButtonColor
            button.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
            button.isEnabled = true
        }
        
        assignButtonTitles()
        
        answerLabel.isHidden = true
        playAgainButton.isHidden = true
    }
    
    func assignButtonTitles()
    {
        let triviaQuestion = game.questionToDisplay
        let numberOfChoices: Int = triviaQuestion.answerChoices.count
        
        //randomizeAnswerLocations(for: triviaQuestion, with: numberOfChoices)
        game.randomizeOrderOfAnswers()
        
        for buttonIndex in 0..<numberOfChoices
        {
            var consumedIndexes = game.consumedIndexes
            let randomIndex = consumedIndexes[0]
            answerButtons[buttonIndex].setTitle(triviaQuestion.answerChoices[randomIndex], for: .normal)
            game.consumedIndexes.remove(at: 0)
        }
        
        if numberOfChoices < answerButtons.count
        {
            disableButtons(usingIndexes: numberOfChoices)
        }
    }
    
//    func randomizeAnswerLocations(for triviaQuestion: TriviaQuestion, with numberOfChoices: Int)
//    {
//        var consumedIndexes: [Int] = []
//        
//        while consumedIndexes.count < numberOfChoices {
//            let index = GKRandomSource.sharedRandom().nextInt(upperBound: numberOfChoices)
//            if !consumedIndexes.contains(index)
//            {
//                consumedIndexes.append(index)
//            }
//        }
//        
//        for buttonIndex in 0..<triviaQuestion.answerChoices.count
//        {
//            let randomIndex = consumedIndexes[0]
//            answerButtons[buttonIndex].setTitle(triviaQuestion.answerChoices[randomIndex], for: .normal)
//            consumedIndexes.remove(at: 0)
//        }
//    }
    
    func disableButtons(usingIndexes numberOfChoices: Int)
    {
        if numberOfChoices < answerButtons.count
        {
            for index in numberOfChoices..<answerButtons.count
            {
                let button = answerButtons[index]
                button.setTitle("N/A", for: .normal)
                button.isEnabled = false
            }
        }
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
        let correctAnswer = game.correctAnswer
        
        for button in answerButtons
        {
            button.isEnabled = false
            button.backgroundColor = UIColor(colorLiteralRed: 22 / 255.0, green: 71 / 255.0, blue: 95 / 255.0, alpha: 1.0)
            let dimWhite = UIColor(white: 0.5, alpha: 0.25)
            button.setTitleColor(dimWhite, for: UIControlState.disabled)
        }
        
        if sender.currentTitle == correctAnswer {
            game.correctQuestions += 1
            
            answerLabel.textColor = correctColor
            answerLabel.text = "Correct!"
            sender.setTitleColor(UIColor.white, for: UIControlState.disabled)
        }
        else
        {
            answerLabel.textColor = inCorrectColor
            answerLabel.text = "Sorry, that's not it."
            sender.backgroundColor = inCorrectColor
            
            for button in answerButtons
            {
                if button.currentTitle == correctAnswer
                {
                    button.backgroundColor = correctColor
                    let brightWhite = UIColor(white: 1.0, alpha: 1.0)
                    button.setTitleColor(brightWhite, for: UIControlState.disabled)
                }
            }
        }
        
        answerLabel.isHidden = false
        
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

