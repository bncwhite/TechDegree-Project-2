//
//  Trivia.swift
//  TrueFalseStarter
//
//  Created by Bradley White on 9/1/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

class Trivia {
    let question : String
    let answer : String
    let firstFalseAnswer : String
    let secondFalseAnswer : String
    let thirdFalseAnswer : String
    
    let questionOne = Trivia(with: "This was the only US President to serve more than two consecutive terms.", answer: "Franklin D. Roosevelt", firstFalseAnswer: "George Washington", secondFalseAnswer: "Woodrow Wilson", thirdFalseAnswer: "Andrew Jackson")
    let questionTwo = Trivia(with: "Which of the following countries has the most residents?", answer: "Nigeria", firstFalseAnswer: "Russia", secondFalseAnswer: "Iran", thirdFalseAnswer: "Vietnam")
    let questionThree = Trivia(with: "In what year was the United Nations founded?", answer: "1945", firstFalseAnswer: "1918", secondFalseAnswer: "1919", thirdFalseAnswer: "1954")
    let questionFour = Trivia(with: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answer: "New York City", firstFalseAnswer: "Paris", secondFalseAnswer: "Washington D.C.", thirdFalseAnswer: "Boston")
    let questionFive = Trivia(with: "Which nation produces the most oil?", answer: "Canada", firstFalseAnswer: "Iran", secondFalseAnswer: "Iraq", thirdFalseAnswer: "Brazil")
    let questionSix = Trivia(with: "Which country has most recently won consecutive World Cups in Soccer?", answer: "Brazil", firstFalseAnswer: "Italy", secondFalseAnswer: "Argetina", thirdFalseAnswer: "Spain")
    let questionSeven = Trivia(with: "Which of the following rivers is longest?", answer: "Mississippi", firstFalseAnswer: "Yangtze", secondFalseAnswer: "Congo", thirdFalseAnswer: "Mekong")
    let questionEight = Trivia(with: "Which city is the oldest?", answer: "Mexico City", firstFalseAnswer: "Cape Town", secondFalseAnswer: "San Juan", thirdFalseAnswer: "Sydney")
    let questionNine = Trivia(with: "Which country was the first to allow women to vote in national elections?", answer: "Poland", firstFalseAnswer: "United States", secondFalseAnswer: "Sweden", thirdFalseAnswer: "Senegal")
    let questionTen = Trivia(with: "Which of these countries won the most medals in the 2012 Summer Games?", answer: "Great Britian", firstFalseAnswer: "France", secondFalseAnswer: "Germany", thirdFalseAnswer: "Japan")
    
    init(with question: String, answer: String, firstFalseAnswer: String, secondFalseAnswer: String, thirdFalseAnswer: String)
    {
        self.question = question
        self.answer = answer
        self.firstFalseAnswer = firstFalseAnswer
        self.secondFalseAnswer = secondFalseAnswer
        self.thirdFalseAnswer = thirdFalseAnswer
        
    }
}


