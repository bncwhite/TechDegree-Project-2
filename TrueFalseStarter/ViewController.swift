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
    //Sounds for the game
    var gameSound: SystemSoundID = 0
    var cheerSound: SystemSoundID = 0
    var booSound: SystemSoundID = 0
    
    //Timer properties
    var timer: Timer = Timer()
    var seconds = 15
    
    //Property that holds all the properties of the current game being played
    var game: Game = Game()
    
    //Array to store all answer buttons for loop purposes
    var answerButtons: [UIButton] = []
    
    //Colors used on buttons during different events
    var defaultButtonColor : UIColor = UIColor(colorLiteralRed: 12 / 255.0, green: 121 / 255.0, blue: 150 / 255.0, alpha: 1.0)
    let correctColor = UIColor(colorLiteralRed: 63 / 255.0, green: 148 / 255.0, blue: 135 / 255.0, alpha: 1.0)
    let inCorrectColor = UIColor(colorLiteralRed: 244 / 255.0, green: 160 / 255.0, blue: 97 / 255.0, alpha: 1.0)
    
    //IBOutlet Labels
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    //IBOutlet Buttons
    @IBOutlet weak var optionButtonOne: UIButton!
    @IBOutlet weak var optionButtonTwo: UIButton!
    @IBOutlet weak var optionButtonThree: UIButton!
    @IBOutlet weak var optionButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    //Start of the app
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Add all answer buttons to the answerButton array
        answerButtons = [optionButtonOne, optionButtonTwo, optionButtonThree, optionButtonFour]
        
        //Prepare all sounds for the game to use
        loadGameSounds()
        
        // Start game
        playGameStartSound()
        
        //Display a question
        displayQuestion()
        
        //Stylize each button's border
        for button in answerButtons
        {
            button.layer.cornerRadius = 5.0
        }
    }
    
    //Tell the game class to load a randomly selected question
    func displayQuestion()
    {
        game.pickQuestion()
        
        //Display the question
        questionField.text = game.questionToDisplay.question
        
        //Stylize each answer button and enable them
        for button in answerButtons
        {
            button.backgroundColor = defaultButtonColor
            button.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
            button.isEnabled = true
        }
        
        //Assign choices to the button titles
        assignButtonTitles()
        
        //Set/Reset the timerLabel properties when each time a question is displayed
        seconds = 15
        timerLabel.text = "\(seconds)"
        timerLabel.font = timerLabel.font.withSize(22.5)
        
        //Hide a few objects on the screen
        answerLabel.isHidden = true
        playAgainButton.isHidden = true
        timerLabel.isHidden = false
        
        //Start the 15 second timer
        startTimer()
        
    }
    
    //Start the 15 second timer
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //Update the timer label every second
    func updateTimer()
    {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        
        //If the timer has reached zero then end the round as if the question was answered incorrectly
        if seconds == 0
        {
            //Create a dummy button with a title that won't match any answers so that the question is answered wrong
            let button = UIButton(type: .system)
            button.setTitle("Time Expired", for: .normal)
            
            //Force the round to end with an incorrect answer
            checkAnswer(button)
            
            //Stop the timer
            timer.invalidate()
        }
            //If the remaining seconds are 8 or less, start flashing the answer buttons to stress the player
        else if seconds <= 8
        {
            //Execute the regular button flash if the remaining seconds is not an even number
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
                    //If the timer has less than 5 seconds left, make the buttons flash red to stress the player more
                    //Also increase the size of the timer font as another warning to the player
                    if seconds < 5
                    {
                        timerLabel.font = timerLabel.font.withSize(45.0)
                    button.backgroundColor = UIColor(colorLiteralRed: 22 / 255.0, green: 71 / 255.0, blue: 95 / 255.0, alpha: 1.0)
                    }
                    else
                    {
                        button.backgroundColor = .red
                    }
                }
            }
        }
    }
    
    //Assign question answers to button titles
    func assignButtonTitles()
    {
        //Grab a copy of the current question on the screen
        let triviaQuestion = game.questionToDisplay
        
        //Count how many answers are available for a question
        let numberOfChoices: Int = triviaQuestion.answerChoices.count
        
        //Create a random order of the avaiable answers
        game.randomizeOrderOfAnswers()
        
        //For each answer button, assign titles using random Ints in the consumedIndexes array
        //Delete the consumed random Int after applying the button title
        for buttonIndex in 0..<numberOfChoices
        {
            var consumedIndexes = game.consumedIndexes
            let randomIndex = consumedIndexes[0]
            answerButtons[buttonIndex].setTitle(triviaQuestion.answerChoices[randomIndex], for: .normal)
            game.consumedIndexes.remove(at: 0)
        }
        
        //If the count of question answers is less than the total count of buttons,
        //then disable unused buttons
        if numberOfChoices < answerButtons.count
        {
            disableButtons(usingIndexes: numberOfChoices)
        }
    }
    
    //Disable unused buttons
    func disableButtons(usingIndexes numberOfChoices: Int)
    {
        if numberOfChoices < answerButtons.count
        {
            for index in numberOfChoices..<answerButtons.count
            {
                //Disable the button and change the button title
                let button = answerButtons[index]
                button.setTitle("N/A", for: .normal)
                button.isEnabled = false
            }
        }
    }
    
    //The game ended. Show how many questions the player successfully answered.
    func displayScore()
    {
        questionField.text = "Way to go!\nYou got \(game.correctQuestions) out of \(game.questionsPerRound) correct!"
        
        //Create a new game
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
        //If the timer is still counting down when an answer is selected, kill the timer
        if timer.isValid
        {
            timer.invalidate()
        }
        
        //Hide the timer label so that the answer text can be displayed
        timerLabel.isHidden = true
        
        //Assign the correct answer to this varible to check if the correct answer was selected
        let correctAnswer = game.correctAnswer

        //Disable all buttons, change the background color and the title color
        for button in answerButtons
        {
            button.isEnabled = false
            button.backgroundColor = UIColor(colorLiteralRed: 22 / 255.0, green: 71 / 255.0, blue: 95 / 255.0, alpha: 1.0)
            let dimWhite = UIColor(white: 0.5, alpha: 0.25)
            button.setTitleColor(dimWhite, for: UIControlState.disabled)
        }
        
        //If the correct answer was selected, play a sound, increase the number of questions answered correctly,
        //and stylize the button to visually show the correct answer
        if sender.currentTitle == correctAnswer {
            playCorrectAnswerSound()
            game.correctQuestions += 1
            
            answerLabel.textColor = correctColor
            answerLabel.text = "Correct!"
            sender.setTitleColor(UIColor.white, for: UIControlState.disabled)
        }
        else
        {
            //The wrong answer was selected, notify the player by changing the incorrect answer's button
            //to the same color as the answer label text
            playInCorrectAnswerSound()
            answerLabel.textColor = inCorrectColor
            answerLabel.text = "Sorry, that's not it."
            sender.backgroundColor = inCorrectColor
            
            //Find the button with the correct answer and set its color to the same color as the answer label text
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
        
        //Display the label
        answerLabel.isHidden = false
        
        // Increment the questions asked counter
        game.questionsAsked += 1
        
        //Wait 2 seconds then call nextRound() from within the method below
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound()
    {
        //If the total questions asked equals how many available questions exist
        //then end the game and display the score
        if game.questionsAsked == game.questionsPerRound
        {
            // Game is over
            displayScore()
        }
        else
        {
            //Remove the current question from the available questions if at least one question has been asked
            
            if game.questionsAsked != 0
            {
                game.questions.remove(at: game.selectedIndex)
            }
            // Continue game or display the first question of a new game
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
        
        //Start a new game
        nextRound()
    }
    
    // MARK: Helper Methods
    
    //boilerplate code only
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    //Load each sound file into memory for quick access when buttons are pressed or game loads
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
    
    //Play the correct answer sound
    func playCorrectAnswerSound()
    {
        AudioServicesPlaySystemSound(cheerSound)
    }
    
    //Play the incorrect answer sound
    func playInCorrectAnswerSound()
    {
        AudioServicesPlaySystemSound(booSound)
    }
    
    //Play the game-loaded sound
    func playGameStartSound()
    {
        AudioServicesPlaySystemSound(gameSound)
    }
}
