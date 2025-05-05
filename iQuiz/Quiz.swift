//
//  Quiz.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import Foundation

class Quiz {
    
    var name : String = ""
    
    var question1 : [String: [String]] = [:]
    var question2 : [String: [String]] = [:]
    var question3 : [String: [String]] = [:]
    
    
    var correct1Index : Int = 0
    var correct2Index : Int = 0
    var correct3Index : Int = 0
}

class QuizRepository {
    
    var quizzes : [Quiz] = []
    
    func createQuiz(name : String, question1: [String: [String]], question2: [String: [String]], question3: [String: [String]], correct1Index: Int, correct2Index: Int, correct3Index: Int) -> Quiz {
        
        let quiz = Quiz()
        
        quiz.name = name
        
        quiz.question1 = question1
        quiz.question2 = question2
        quiz.question3 = question3
        
        
        quiz.correct1Index = correct1Index
        quiz.correct2Index = correct2Index
        quiz.correct3Index = correct3Index
        
        quizzes.append(quiz)
        
        return quiz
        
    }
    
    func findQuiz(_ name: String) -> Quiz? {
        
        for quiz in quizzes {
            
            if quiz.name == name {
                
                return quiz
                
            }
        }
        
        return nil
    }
        
    
}
