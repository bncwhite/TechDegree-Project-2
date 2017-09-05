//
//  TriviaQuestion.swift
//  TrueFalseStarter
//
//  Created by Bradley White on 9/1/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

struct TriviaQuestion {
    let question : String
    let correctAnswer : String
    var answerChoices : [String]
    
    init(withQuestion question: String, correctAnswer: String, answerChoices: [String])
    {
        self.question = question
        self.correctAnswer = correctAnswer
        self.answerChoices = answerChoices
    }
}


