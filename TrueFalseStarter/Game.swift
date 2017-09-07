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
    
    let questionOne = TriviaQuestion(withQuestion: "This was the only US President to serve more than two consecutive terms.",
                                     correctAnswer: "Franklin D. Roosevelt",
                                     answerChoices: ["Franklin D. Roosevelt", "George Washington", "Woodrow Wilson", "Andrew Jackson"])
    
    let questionTwo = TriviaQuestion(withQuestion: "Which of the following countries has the most residents?",
                                     correctAnswer: "Nigeria",
                                     answerChoices: ["Nigeria", "Russia", "Iran", "Vietnam"])
    
    let questionThree = TriviaQuestion(withQuestion: "In what year was the United Nations founded?",
                                       correctAnswer: "1945",
                                       answerChoices: ["1945", "1918", "1919", "1954"])
    
    let questionFour = TriviaQuestion(withQuestion: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                                      correctAnswer: "New York City",
                                      answerChoices: ["New York City", "Paris", "Washington D.C.", "Boston"])
    
    let questionFive = TriviaQuestion(withQuestion: "Which nation produces the most oil?",
                                      correctAnswer: "Canada",
                                      answerChoices: ["Canada", "Iran", "Iraq", "Brazil"])
    
    let questionSix = TriviaQuestion(withQuestion: "Which country has most recently won consecutive World Cups in Soccer?",
                                     correctAnswer: "Brazil",
                                     answerChoices: ["Brazil", "Italy", "Argetina", "Spain"])
    
    let questionSeven = TriviaQuestion(withQuestion: "Which of the following rivers is longest?",
                                       correctAnswer: "Mississippi",
                                       answerChoices: ["Mississippi", "Yangtze", "Congo", "Mekong"])
    
    let questionEight = TriviaQuestion(withQuestion: "Which city is the oldest?",
                                       correctAnswer: "Mexico City",
                                       answerChoices: ["Mexico City", "Cape Town", "San Juan", "Sydney"])
    
    let questionNine = TriviaQuestion(withQuestion: "Which country was the first to allow women to vote in national elections?",
                                      correctAnswer: "Poland",
                                      answerChoices: ["Poland", "United States", "Sweden", "Senegal"])
    
    let questionTen = TriviaQuestion(withQuestion: "Which of these countries won the most medals in the 2012 Summer Games?",
                                     correctAnswer: "Great Britian",
                                     answerChoices: ["Great Britian",  "France", "Germany", "Japan"])
    let questionEleven = TriviaQuestion(withQuestion: "Brad is awesome!",
                                        correctAnswer: "True",
                                        answerChoices: ["True", "False"])
    let questionTwelve = TriviaQuestion(withQuestion: "Which was the first Earthbound game to be translated and released to the USA", correctAnswer: "Earthbound", answerChoices: ["Earthbound Beginnings", "Earthbound", "Mother 3"])
    
    init()
    {
        //Add all questions to the questions array
        questions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight, questionNine, questionTen, questionEleven, questionTwelve]
        
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
