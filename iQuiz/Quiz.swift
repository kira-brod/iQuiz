//
//  Quiz.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import Foundation

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

                let topic = Quiz1(title: title, desc: desc, imageName: "def", questions: parsedQuestions)

                topics.append(topic)

            }

            return topics

}

class Question1: NSObject, NSCoding {
    
    var text :String
    var options : [String]
    var correctStr : String
    var correctIndex: Int
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.text, forKey: "text")
        coder.encode(self.options, forKey: "options")
        coder.encodeCInt(Int32(self.correctIndex), forKey: "correctIndex")
        coder.encode(self.correctStr, forKey: "correctStr")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String,
              let options = decoder.decodeObject(forKey: "options") as? [String],
              let correctStr = decoder.decodeObject(forKey: "correctStr") as? String
            else { return nil }
        
        self.init(
            text: text,
            options: options,
            correctStr: correctStr
        )
    }
    
    
    
    init(text: String, options: [String], correctStr: String) {
        self.text = text
        self.options = options
        self.correctStr = correctStr
        self.correctIndex = Int(correctStr) ?? 0
    }
    
}

class Quiz1: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.desc, forKey: "desc")
        coder.encode(self.imageName, forKey: "imageName")
        coder.encode(self.questions, forKey: "questions")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObject(forKey: "title") as? String,
              let questions = decoder.decodeObject(forKey: "questions") as? [Question1],
              let imageName = decoder.decodeObject(forKey: "imageName") as? String,
              let desc = decoder.decodeObject(forKey: "desc") as? String

            else { return nil }
        
        self.init(
            title: title,
            desc: desc,
            imageName: imageName,
            questions: questions
        )
    }
    
    var title: String
    var desc : String
    var imageName: String
    var questions: [Question1]
    
    init(title: String, desc: String, imageName: String, questions: [Question1]) {
        self.title = title
        self.desc = desc
        self.imageName = imageName
        self.questions = questions
    }
}

class Quiz: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.correct, forKey: "correct")
        coder.encodeCInt(Int32(self.score), forKey: "score")
        coder.encode(self.desc, forKey: "desc")
        
        coder.encode(self.question1, forKey: "question1")
        coder.encode(self.question2, forKey: "question2")
        coder.encode(self.question3, forKey: "question3")
        
        coder.encodeCInt(Int32(self.correct1Index), forKey: "correct1Index")
        coder.encodeCInt(Int32(self.correct2Index), forKey: "correct2Index")
        coder.encodeCInt(Int32(self.correct3Index), forKey: "correct3Index")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name")  as? String else {return nil}
        guard let desc = decoder.decodeObject(forKey: "desc")  as? String else {return nil}
        guard let correct = decoder.decodeBool(forKey: "correct") as? Bool else {return nil}
        guard let question1 = decoder.decodeObject(forKey: "question1")  as? [String: [String]] else {return nil}
        guard let question2 = decoder.decodeObject(forKey: "question2")  as? [String: [String]] else {return nil}
        guard let question3 = decoder.decodeObject(forKey: "question3")  as? [String: [String]] else {return nil}
        guard let score = decoder.decodeInteger(forKey: "score") as Int? else {return nil}
        guard let correct1Index = decoder.decodeInteger(forKey: "correct1Index") as Int? else {return nil}
        guard let correct2Index = decoder.decodeInteger(forKey: "correct2Index") as Int? else {return nil}
        guard let correct3Index = decoder.decodeInteger(forKey: "correct3Index") as Int? else {return nil}


        
        self.init(
            name: name,
            desc: desc,
            score: score,
            question1: question1,
            question2: question2,
            question3: question3,
            correct1Index: correct1Index,
            correct2Index: correct2Index,
            correct3Index: correct3Index,
        )
    }
    
    
    
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
    
//    init() {
//        self.name = "name"
//        self.score = 0
//        self.question1 = ["question1" : ["answers", "answers"]]
//        self.question2 = ["question1" : ["answers", "answers"]]
//        self.question3 = ["question1" : ["answers", "answers"]]
//        self.correct1Index = 0
//        self.correct2Index = 0
//        self.correct3Index = 0
//        self.correct = false
//        self.desc = ""
//        self.questions = []
//        
//    }
}

class QuizRepository: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(self.load, forKey: "load")
        coder.encode(self.url, forKey: "url")
        coder.encode(self.data, forKey: "data")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let data = decoder.decodeObject(forKey: "data") as? [QuizJSON],
              let load = decoder.decodeBool(forKey: "load") as? Bool,
              let url = decoder.decodeObject(forKey: "url") as? String,
              let saved = decoder.decodeObject(forKey: "saved") as? [Quiz1]
            else { return nil }
        
        self.init(
            load,
            url,
            saved
        )
    }
    
    
    var data = DataLoader("https://tednewardsandbox.site44.com/questions.json").quizzes
    var load = false
    var url : String
    
    
    var quiz1 : Quiz = Quiz(name: "Mathematics", desc: "math quiz", score: 0, question1: ["2 * 6?" : ["4", "8", "12", "3"]], question2: ["4 + 12?" : ["16", "20", "24", "8"]], question3: ["5 - 4?" : ["9", "1", "17", "2"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    
    
    var quiz2 : Quiz = Quiz(name: "Marvel Super Heroes", desc: "hero quiz", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde", "grass"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america", "Hulk"]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver", "wrench"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
    
    var quiz3 : Quiz = Quiz(name: "Science", desc: "yay science", score: 0, question1: ["What is the chemical formula of water?" : ["CHO4", "NaCl", "H2O", "CO2"]], question2: ["What animal is the largest on earth?" : ["Giraffe", "Elephant", "Blue Whale", "Dino"]], question3: ["What planet is known as the red planet?" : ["mars", "jupiter", "venus", "neptune"]], correct1Index: 2, correct2Index: 2, correct3Index: 0)
    
    var quizzes : [Quiz] = []
    var quizzes2 : [Quiz1]  = []
    
//    init () {
//        quizzes = [quiz1, quiz2, quiz3]
//        self.url = "https://tednewardsandbox.site44.com/questions.json"
//        self.data = DataLoader("https://tednewardsandbox.site44.com/questions.json").quizzes
//    }
    

    
    init (_ load : Bool, _ url : String, _ saved : [Quiz1] ) {
        
        self.url = url
        self.data = DataLoader(url).quizzes
        
        if load {
            
            if saved.isEmpty {
                
                quizzes = [quiz1, quiz2, quiz3]
                quizzes2 = parseQuizTopics(data)
                
//                print("quizzes2: \(quizzes2)")
                
                quizzes[0].name = quizzes2[0].title
                quizzes[1].name = quizzes2[1].title
                quizzes[2].name = quizzes2[2].title
                
                
                
                quizzes[0].desc = quizzes2[0].desc
                quizzes[1].desc = quizzes2[1].desc
                quizzes[2].desc = quizzes2[2].desc
                
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
            } else {
                quizzes = [quiz1, quiz2, quiz3]
                quizzes2 = saved
                
//                print("quizzes2: \(quizzes2)")
                
                quizzes[0].name = quizzes2[0].title
                quizzes[1].name = quizzes2[1].title
                quizzes[2].name = quizzes2[2].title
                
                
                
                quizzes[0].desc = quizzes2[0].desc
                quizzes[1].desc = quizzes2[1].desc
                quizzes[2].desc = quizzes2[2].desc
                
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
        } else {
            quizzes = [quiz1, quiz2, quiz3]
        }
        
//        print(quizzes[0].name)
//        print(quizzes[1].name)
//        print(quizzes[2].name)
        
        
    }
    
  
    
    func createQuiz(name : String, question1: [String: [String]], question2: [String: [String]], question3: [String: [String]], correct1Index: Int, correct2Index: Int, correct3Index: Int) -> Quiz {
        
        let quiz = Quiz(name: name, desc: "", score: 0, question1: question1, question2: question2, question3: question3, correct1Index: correct1Index, correct2Index: correct2Index, correct3Index: correct3Index)
        
//        quiz.name = name
//        
//        quiz.question1 = question1
//        quiz.question2 = question2
//        quiz.question3 = question3
//        
//        
//        quiz.correct1Index = correct1Index
//        quiz.correct2Index = correct2Index
//        quiz.correct3Index = correct3Index
        
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
