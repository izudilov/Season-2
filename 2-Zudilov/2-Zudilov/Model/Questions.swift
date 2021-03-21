//
//  Questions.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import Foundation

struct Questions {
    
    var question: String
    var a: String
    var b: String
    var c: String
    var d: String
    var rightAnswer: String
    
    init(question: String, a: String, b: String, c: String, d: String, rightAnswer: String)
    
    {
        self.question = question
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.rightAnswer = rightAnswer

    }
}


