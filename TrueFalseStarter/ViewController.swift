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
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        playAgainButton.isHidden = true
    }
    
    func displayScore()
    {
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        game = Game()
        
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
    }
    
    @IBAction func checkAnswer(_ sender: UIButton)
    {
        let correctAnswer = game.currentAnswer
        
        if sender.currentTitle == correctAnswer {
            game.correctQuestions += 1
            questionField.text = "Correct!"
        }
        else
        {
            questionField.text = "Sorry, wrong answer!"
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
        trueButton.isHidden = false
        falseButton.isHidden = false
        
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

