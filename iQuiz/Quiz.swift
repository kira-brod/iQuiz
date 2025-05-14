//
//  Quiz.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import Foundation

class Question1 {
    
    var text :String
    var options : [String]
    var correctStr : String
    var correctIndex: Int
    
    init(text: String, options: [String], correctStr: String) {
        self.text = text
        self.options = options
        self.correctStr = correctStr
        self.correctIndex = Int(correctStr) ?? 0
    }
    
}

class Quiz1 {
    var title: String
    var description : String
    var imageName: String
    var questions: [Question1]
    
    init(title: String, description: String, imageName: String, questions: [Question1]) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.questions = questions
    }
}

class Quiz {
    
    
    var name : String = ""
    
    var correct = false
    
    var score : Int = 0
    
    var desc : String
    
    var questions : [[String : Any]]
    
    var question1 : [String: [String]] = [:]
    var question2 : [String: [String]] = [:]
    var question3 : [String: [String]] = [:]
    
    
    var correct1Index : Int = 0
    var correct2Index : Int = 0
    var correct3Index : Int = 0
    
    init(name: String, desc: String, score: Int, question1: [String : [String]], question2: [String : [String]], question3: [String : [String]], correct1Index: Int, correct2Index: Int, correct3Index: Int) {
        self.name = name
        self.score = score
        self.question1 = question1
        self.question2 = question2
        self.question3 = question3
        self.correct1Index = correct1Index
        self.correct2Index = correct2Index
        self.correct3Index = correct3Index
        self.correct = false
        self.desc = desc
        self.questions = []
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
        self.desc = ""
        self.questions = []
        
    }
}

class QuizRepository {
    
    let data = DataLoader().quizzes
    
    func parseQuizTopics(_ data: [QuizJSON]) -> [Quiz1] {

                var topics: [Quiz1] = []

     

                for item in data {

                    let title = item.title

                    let desc = item.desc

                    let questions = item.questions

     

                    let parsedQuestions = questions.compactMap { q -> Question1? in

                        let text = q.text

                        let options = q.answers

                        let correctStr = q.answer

                        let correctIndex = Int(correctStr)

                        return Question1(text: text, options: options, correctStr: correctStr)

                    }

     

                    let topic = Quiz1(title: title, description: desc, imageName: "default.icon", questions: parsedQuestions)

                    topics.append(topic)

                }

     

                return topics

            }
    
    var quiz1 : Quiz = Quiz(name: "Mathematics", desc: "", score: 0, question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    
    
    var quiz2 : Quiz = Quiz(name: "Marvel Super Heroes", desc: "", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america",]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
    
    var quiz3 : Quiz = Quiz(name: "Science", desc: "", score: 0, question1: ["What is the chemical formula of water?" : ["CHO4", "NaCl", "H2O"]], question2: ["What animal is the largest on earth?" : ["Giraffe", "Elephant", "Blue Whale"]], question3: ["What planet is known as the red planet?" : ["mars", "jupiter", "venus"]], correct1Index: 2, correct2Index: 2, correct3Index: 0)
    
    var quizzes : [Quiz] = []
    var quizzes2 : [Quiz1]  = []
    
    init () {
        quizzes = [quiz1, quiz2, quiz3]
        quizzes2 = parseQuizTopics(data)
        
        quizzes[0].name = quizzes2[0].title
        quizzes[1].name = quizzes2[1].title
        quizzes[2].name = quizzes2[2].title
        
        quizzes[0].desc = quizzes2[0].description
        quizzes[1].desc = quizzes2[1].description
        quizzes[2].desc = quizzes2[2].description
        
        quizzes[0].question1 = [quizzes2[0].questions[0].text: quizzes2[0].questions[0].options]
        quizzes[1].question1 = [quizzes2[1].questions[0].text: quizzes2[1].questions[0].options]
        quizzes[2].question1 = [quizzes2[2].questions[0].text: quizzes2[2].questions[0].options]
        
        quizzes[0].correct1Index = quizzes2[0].questions[0].correctIndex
        quizzes[1].correct1Index = quizzes2[1].questions[0].correctIndex
        quizzes[2].correct1Index = quizzes2[2].questions[0].correctIndex
        
        quizzes[1].question2 = [quizzes2[1].questions[1].text: quizzes2[1].questions[1].options]
        
        quizzes[1].correct2Index = quizzes2[1].questions[1].correctIndex
        
        quizzes[1].question3 = [quizzes2[1].questions[2].text: quizzes2[1].questions[2].options]
        
        quizzes[1].correct3Index = quizzes2[1].questions[2].correctIndex
        
        
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
