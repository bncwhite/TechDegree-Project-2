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
    
    let questionOne = Trivia(question: "This was the only US President to serve more than two consecutive terms.",
                             correctAnswer: "Franklin D. Roosevelt",
                             answerChoices: ["Franklin D. Roosevelt", "George Washington", "Woodrow Wilson", "Andrew Jackson"])
    
    let questionTwo = Trivia(question: "Which of the following countries has the most residents?",
                             correctAnswer: "Nigeria",
                             answerChoices: ["Nigeria", "Russia", "Iran", "Vietnam"])
    
    let questionThree = Trivia(question: "In what year was the United Nations founded?",
                               correctAnswer: "1945",
                               answerChoices: ["1945", "1918", "1919", "1954"])
    
    let questionFour = Trivia(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                              correctAnswer: "New York City",
                              answerChoices: ["New York City", "Paris", "Washington D.C.", "Boston"])
    
    let questionFive = Trivia(question: "Which nation produces the most oil?",
                              correctAnswer: "Canada",
                              answerChoices: ["Canada", "Iran", "Iraq", "Brazil"])
    
    let questionSix = Trivia(question: "Which country has most recently won consecutive World Cups in Soccer?",
                             correctAnswer: "Brazil",
                             answerChoices: ["Brazil", "Italy", "Argetina", "Spain"])
    
    let questionSeven = Trivia(question: "Which of the following rivers is longest?",
                               correctAnswer: "Mississippi",
                               answerChoices: ["Mississippi", "Yangtze", "Congo", "Mekong"])
    
    let questionEight = Trivia(question: "Which city is the oldest?",
                               correctAnswer: "Mexico City",
                               answerChoices: ["Mexico City", "Cape Town", "San Juan", "Sydney"])
    
    let questionNine = Trivia(question: "Which country was the first to allow women to vote in national elections?",
                              correctAnswer: "Poland",
                              answerChoices: ["Poland", "United States", "Sweden", "Senegal"])
    
    let questionTen = Trivia(question: "Which of these countries won the most medals in the 2012 Summer Games?",
                             correctAnswer: "Great Britian",
                             answerChoices: ["Great Britian",  "France", "Germany", "Japan"])

    var questions : [Trivia] = []
    
    init()
    {
        questions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight, questionNine, questionTen]
        questionsPerRound = questions.count
        
    }
    
    public func pickQuestion() -> Trivia
    {
        selectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        correctAnswer = questions[selectedIndex].correctAnswer
        return questions[selectedIndex]
    }
}
