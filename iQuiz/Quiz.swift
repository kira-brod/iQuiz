//
//  Quiz.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import Foundation

class Quiz {
    
    var name : String = ""
    
    var correct = false
    
    var score : Int = 0
    
    var question1 : [String: [String]] = [:]
    var question2 : [String: [String]] = [:]
    var question3 : [String: [String]] = [:]
    
    
    var correct1Index : Int = 0
    var correct2Index : Int = 0
    var correct3Index : Int = 0
    
    init(name: String, score: Int, question1: [String : [String]], question2: [String : [String]], question3: [String : [String]], correct1Index: Int, correct2Index: Int, correct3Index: Int) {
        self.name = name
        self.score = score
        self.question1 = question1
        self.question2 = question2
        self.question3 = question3
        self.correct1Index = correct1Index
        self.correct2Index = correct2Index
        self.correct3Index = correct3Index
        self.correct = false
    }
    
    init() {
        self.name = "name"
        self.score = 0
        self.question1 = ["question1" : ["answers", "answers"]]
        self.question2 = ["question1" : ["answers", "answers"]]
        self.question3 = ["question1" : ["answers", "answers"]]
        self.correct1Index = 0
        self.correct2Index = 0
        self.correct3Index = 0
        self.correct = false
        
    }
}

class QuizRepository {
    
    
    
    var quiz1 : Quiz = Quiz(name: "Mathematics", score: 0, question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    
    var quiz2 : Quiz = Quiz(name: "Marvel Super Heroes", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america",]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
    
    var quiz3 : Quiz = Quiz(name: "Science", score: 0, question1: ["What is the chemical formula of water?" : ["CHO4", "NaCl", "H2O"]], question2: ["What animal is the largest on earth?" : ["Giraffe", "Elephant", "Blue Whale"]], question3: ["What planet is known as the red planet?" : ["mars", "jupiter", "venus"]], correct1Index: 2, correct2Index: 2, correct3Index: 0)
    
    var quizzes : [Quiz] = []
    
    init () {
        quizzes = [quiz1, quiz2, quiz3]
    }
    
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
