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
    var cheerSound: SystemSoundID = 0
    var booSound: SystemSoundID = 0
    
    var timer: Timer = Timer()
    var seconds = 15
    
    var game: Game = Game()
    
    var answerButtons: [UIButton] = []
    
    var defaultButtonColor : UIColor = UIColor(colorLiteralRed: 12 / 255.0, green: 121 / 255.0, blue: 150 / 255.0, alpha: 1.0)
    let correctColor = UIColor(colorLiteralRed: 63 / 255.0, green: 148 / 255.0, blue: 135 / 255.0, alpha: 1.0)
    let inCorrectColor = UIColor(colorLiteralRed: 244 / 255.0, green: 160 / 255.0, blue: 97 / 255.0, alpha: 1.0)
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var optionButtonOne: UIButton!
    @IBOutlet weak var optionButtonTwo: UIButton!
    @IBOutlet weak var optionButtonThree: UIButton!
    @IBOutlet weak var optionButtonFour: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        answerButtons = [optionButtonOne, optionButtonTwo, optionButtonThree, optionButtonFour]
        loadGameSounds()
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
        seconds = 15
        timerLabel.text = "\(seconds)"
        timerLabel.font = timerLabel.font.withSize(22.5)
        timerLabel.isHidden = false
        startTimer()
        
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer()
    {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        if seconds == 0
        {
            let button = UIButton(type: .system)
            button.setTitle("Time Expired", for: .normal)
            checkAnswer(button)
            timer.invalidate()
        }
        else if seconds <= 8
        {
            let modulo: Bool = seconds % 2 == 0
            switch modulo {
            case false:
                for button in answerButtons
                {
                    button.backgroundColor = defaultButtonColor
                }
            default:
                for button in answerButtons
                {
                    if seconds < 5
                    {
                        timerLabel.font = timerLabel.font.withSize(45.0)
                    button.backgroundColor = UIColor(colorLiteralRed: 22 / 255.0, green: 71 / 255.0, blue: 95 / 255.0, alpha: 1.0)
                    }
                    else
                    {
                        //timerLabel.font = timerLabel.font.withSize(45.0)
                        button.backgroundColor = .red
                    }
                }
            }
        }
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
        if timer.isValid
        {
            timer.invalidate()
        }
        timerLabel.isHidden = true
        
        let correctAnswer = game.correctAnswer

        for button in answerButtons
        {
            button.isEnabled = false
            button.backgroundColor = UIColor(colorLiteralRed: 22 / 255.0, green: 71 / 255.0, blue: 95 / 255.0, alpha: 1.0)
            let dimWhite = UIColor(white: 0.5, alpha: 0.25)
            button.setTitleColor(dimWhite, for: UIControlState.disabled)
        }
        
        if sender.currentTitle == correctAnswer {
            playCorrectAnswerSound()
            game.correctQuestions += 1
            
            answerLabel.textColor = correctColor
            answerLabel.text = "Correct!"
            sender.setTitleColor(UIColor.white, for: UIControlState.disabled)
        }
        else
        {
            playInCorrectAnswerSound()
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
    
    func loadGameSounds()
    {
        let pathToGameFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToGameFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        
        let pathToCheerFile = Bundle.main.path(forResource: "Cheer", ofType: "wav")
        let cheerSoundURL = URL(fileURLWithPath: pathToCheerFile!)
        AudioServicesCreateSystemSoundID(cheerSoundURL as CFURL, &cheerSound)
        
        let pathToBooFile = Bundle.main.path(forResource: "Boo", ofType: "wav")
        let booSoundURL = URL(fileURLWithPath: pathToBooFile!)
        AudioServicesCreateSystemSoundID(booSoundURL as CFURL, &booSound)
    }
    
    func playCorrectAnswerSound()
    {
        AudioServicesPlaySystemSound(cheerSound)
    }
    
    func playInCorrectAnswerSound()
    {
        AudioServicesPlaySystemSound(booSound)
    }
    
    func playGameStartSound()
    {
        AudioServicesPlaySystemSound(gameSound)
    }
}
