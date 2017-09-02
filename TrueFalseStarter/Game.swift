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
    var currentAnswer: String = ""
    
    let questionOne = Trivia(question: "This was the only US President to serve more than two consecutive terms.", answer: "Franklin D. Roosevelt", firstFalseAnswer: "George Washington", secondFalseAnswer: "Woodrow Wilson", thirdFalseAnswer: "Andrew Jackson")
    let questionTwo = Trivia(question: "Which of the following countries has the most residents?", answer: "Nigeria", firstFalseAnswer: "Russia", secondFalseAnswer: "Iran", thirdFalseAnswer: "Vietnam")
    let questionThree = Trivia(question: "In what year was the United Nations founded?", answer: "1945", firstFalseAnswer: "1918", secondFalseAnswer: "1919", thirdFalseAnswer: "1954")
    let questionFour = Trivia(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answer: "New York City", firstFalseAnswer: "Paris", secondFalseAnswer: "Washington D.C.", thirdFalseAnswer: "Boston")
    let questionFive = Trivia(question: "Which nation produces the most oil?", answer: "Canada", firstFalseAnswer: "Iran", secondFalseAnswer: "Iraq", thirdFalseAnswer: "Brazil")
    let questionSix = Trivia(question: "Which country has most recently won consecutive World Cups in Soccer?", answer: "Brazil", firstFalseAnswer: "Italy", secondFalseAnswer: "Argetina", thirdFalseAnswer: "Spain")
    let questionSeven = Trivia(question: "Which of the following rivers is longest?", answer: "Mississippi", firstFalseAnswer: "Yangtze", secondFalseAnswer: "Congo", thirdFalseAnswer: "Mekong")
    let questionEight = Trivia(question: "Which city is the oldest?", answer: "Mexico City", firstFalseAnswer: "Cape Town", secondFalseAnswer: "San Juan", thirdFalseAnswer: "Sydney")
    let questionNine = Trivia(question: "Which country was the first to allow women to vote in national elections?", answer: "Poland", firstFalseAnswer: "United States", secondFalseAnswer: "Sweden", thirdFalseAnswer: "Senegal")
    let questionTen = Trivia(question: "Which of these countries won the most medals in the 2012 Summer Games?", answer: "Great Britian", firstFalseAnswer: "France", secondFalseAnswer: "Germany", thirdFalseAnswer: "Japan")

    var questions : [Trivia] = []
    
    init()
    {
        questions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight, questionNine, questionTen]
        questionsPerRound = questions.count
    }
    
    public func pickQuestion() -> Trivia
    {
        selectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        currentAnswer = questions[selectedIndex].answer
        return questions[selectedIndex]
    }
}
