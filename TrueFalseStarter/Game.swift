//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Bradley White on 9/1/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

//This class controls the logic for the game.

import GameKit

class Game
{
    //Set during init()
    var questionsPerRound = 0
    
    //Incremented each time a question is answered
    var questionsAsked = 0
    
    //Incremented each time a question is answered correctly
    var correctQuestions = 0
    
    //Changes each time a question is asked and
    //used to inform the game which question to remove from the questions array
    var selectedIndex: Int = 0
    
    //Set each time a question is asked and
    //used to determine the correct answer by comparing this string to the pushed button's title
    var correctAnswer: String = ""
    
    //Holds all questions in an array and questions are randomly selected
    //and questions are removed as the game progresses using the selectedIndex property
    var questions : [TriviaQuestion] = []
    
    //Set each time a qustion is asked and used in the ViewController in
    //various functions to pull properties back of the currently asked question
    var questionToDisplay : TriviaQuestion
    
    //Holds Ints that are randomly selected so that a questions answer choices
    //can be randomly added to the button titles. Each Int in the array is
    //removed when looping through the button title assignments.
    var consumedIndexes: [Int] = []
    
    //Create the all the question data using the TriviaQuestion init()
    
    let questionOne = TriviaQuestion(withQuestion: "Who is the last character to join the team?",
                                     correctAnswer: "Poo",
                                     answerChoices: ["Poo", "Ness", "Paula", "Jeff"])
    
    let questionTwo = TriviaQuestion(withQuestion: "Which team member equips baseball bats for weapons?",
                                     correctAnswer: "Ness",
                                     answerChoices: ["Ness", "Paula", "Jeff", "Poo"])
    
    let questionThree = TriviaQuestion(withQuestion: "Which team member uses yo-yos as their weapon?",
                                       correctAnswer: "Paula",
                                       answerChoices: ["Paula", "Ness", "Jeff", "Poo"])
    
    let questionFour = TriviaQuestion(withQuestion: "Which team member only uses one weapon and is difficult to obtain?",
                                      correctAnswer: "Poo",
                                      answerChoices: ["Poo", "Pokey", "Pickey", "Paula"])
    
    let questionFive = TriviaQuestion(withQuestion: "In which town do you initially meet the Runaway Five band?",
                                      correctAnswer: "Twoson",
                                      answerChoices: ["Twoson", "Onett", "Threed", "Fourside"])
    
    let questionSix = TriviaQuestion(withQuestion: "Which of the following is the hometown of Ness?",
                                     correctAnswer: "Onett",
                                     answerChoices: ["Onett", "Twoson", "Threed", "Fourside"])
    
    let questionSeven = TriviaQuestion(withQuestion: "Which of the following is the hometown of Paula?",
                                       correctAnswer: "Twoson",
                                       answerChoices: ["Twoson", "Threed", "Onett", "Fourside"])
    
    let questionEight = TriviaQuestion(withQuestion: "Which of the following is the hometown of Jeff?",
                                       correctAnswer: "Winters",
                                       answerChoices: ["Winters", "Summers", "Fourside", "Dalaam"])
    
    let questionNine = TriviaQuestion(withQuestion: "Which of the following is the hometown of Poo?",
                                      correctAnswer: "Dalaam",
                                      answerChoices: ["Dalaam", "Winters", "Summers", "Fourside"])
    
    let questionTen = TriviaQuestion(withQuestion: "Which team member uses laser beam type of weapons?",
                                     correctAnswer: "Jeff",
                                     answerChoices: ["Jeff",  "Poo", "Ness", "Paula"])
    let questionEleven = TriviaQuestion(withQuestion: "Who is the star of Earthbound?",
                                        correctAnswer: "Ness",
                                        answerChoices: ["Ness", "Paula", "Jeff", "Poo"])
    let questionTwelve = TriviaQuestion(withQuestion: "Which was the first Earthbound game to be translated and released to the USA", correctAnswer: "Earthbound", answerChoices: ["Earthbound Beginnings", "Earthbound", "Mother 3"])
    let questionThirteen = TriviaQuestion(withQuestion: "Who do you call in order to save your game progress?", correctAnswer: "Dad", answerChoices: ["Dad", "Mom", "Sister", "Brother"])
    let questionFourteen = TriviaQuestion(withQuestion: "How many melodies must be collected in order to approach the game boss?", correctAnswer: "8", answerChoices: ["8", "10", "12"])
    let questionFifteen = TriviaQuestion(withQuestion: "Paula is able to use bottle rockets", correctAnswer: "False", answerChoices: ["True", "False"])
    let questionSixteen = TriviaQuestion(withQuestion: "Buzzbuzz is a talking alien bee in the game?", correctAnswer: "True", answerChoices: ["False", "True"])
    let questionSeventeen = TriviaQuestion(withQuestion: "Magicant is a dream-like world area of the the game", correctAnswer: "True", answerChoices: ["True", "False"])
    let questionEighteen = TriviaQuestion(withQuestion: "The game starts in Summers", correctAnswer: "False", answerChoices: ["False", "True"])
    let questionNinteen = TriviaQuestion(withQuestion: "How many players do you control when Poo joins the team?", correctAnswer: "3", answerChoices: ["1", "2", "3"])
    let questionTwenty = TriviaQuestion(withQuestion: "The battle against Giygas takes place in which of the following time periods?", correctAnswer: "Past", answerChoices: ["Past", "Present", "Future"])
    
    init()
    {
        //Add all questions to the questions array
        questions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight, questionNine, questionTen, questionEleven, questionTwelve, questionThirteen, questionFourteen, questionFifteen, questionSixteen, questionSeven, questionEighteen, questionNinteen, questionTwenty]
        
        //Determine how many rounds will be in the game
        questionsPerRound = questions.count
        
        //Initialize the questionToDisplay property just to make the compiler happy
        questionToDisplay = questionOne
    }
    
    //Pick a random int that is within the total count of the objects in the questions array
    //Use the selectedIndex to grab a question from the questions array
    //Assign the question to a property for the ViewController functions to utilize
    public func pickQuestion()
    {
        selectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        correctAnswer = questions[selectedIndex].correctAnswer
        questionToDisplay = questions[selectedIndex]
    }
    
    //Assign random and non-repeatings Ints to the consumedIndexes array so that a question's
    //answer choices are alway random when assigned to button titles
    public func randomizeOrderOfAnswers()
    {
        let numberOfChoices = questionToDisplay.answerChoices.count
        
        //Add an equal amount of random Ints that equals how many choices a question has available
        while consumedIndexes.count < numberOfChoices {
            
            //Create a random Int
            let index = GKRandomSource.sharedRandom().nextInt(upperBound: numberOfChoices)
            
            //Prevent repeated Ints
            if !consumedIndexes.contains(index)
            {
                consumedIndexes.append(index)
            }
        }
        
        
    }
}
