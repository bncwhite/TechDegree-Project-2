//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Bradley White on 9/1/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

class Game
{
    var questionsPerRound = 0
    var questionsAsked = 0
    var correctQuestions = 0
    var selectedIndex: Int = 0
    var correctAnswer: String = ""
    var questions : [TriviaQuestion] = []
    var questionToDisplay : TriviaQuestion
    var consumedIndexes: [Int] = []
    
    
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
        questions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight, questionNine, questionTen, questionEleven, questionTwelve]
        questionsPerRound = questions.count
        questionToDisplay = questionOne
    }
    
    public func pickQuestion()
    {
        selectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        correctAnswer = questions[selectedIndex].correctAnswer
        questionToDisplay = questions[selectedIndex]
    }
    
    public func randomizeOrderOfAnswers()
    {
        let numberOfChoices = questionToDisplay.answerChoices.count
        
        while consumedIndexes.count < numberOfChoices {
            let index = GKRandomSource.sharedRandom().nextInt(upperBound: numberOfChoices)
            if !consumedIndexes.contains(index)
            {
                consumedIndexes.append(index)
            }
        }
        
        
    }
}
