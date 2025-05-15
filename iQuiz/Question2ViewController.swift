//
//  Question2ViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import UIKit

class Question2ViewController: UIViewController, UITableViewDelegate {
    
    var quiz = Quiz()
    var correct = false
    var indexPick : Int = 0
    var score = 0
    var change = false
    var repository = QuizRepository()
    var urlString : String = ""
    
    
    @IBOutlet weak var check: UIButton!
    
    @IBOutlet weak var tblTable: UITableView!
    
    @IBOutlet weak var CheckAnswer: UILabel!
    
    @IBOutlet weak var finish: UIButton!
    
    class DataTable : NSObject, UITableViewDataSource {
        
        var data : [String: [String]] = [:]
        var quiz1 : Quiz = Quiz()
        
        init(_ items : [String : [String]], quiz q : Quiz) {
            data = items
            quiz1 = q
            
        }
        
        init(_ items : [String : [String]]) {
            data = items
            
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return data.keys.count
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return (Array(data.keys))[section]
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == quiz1.correct1Index {
                quiz1.score += 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Question")!
            let division = (Array(data.keys))[indexPath.section]
            let team = data[division]?[indexPath.row]
            
            if indexPath.row == quiz1.correct1Index {
                cell.backgroundColor = UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.2)
            }
            cell.textLabel?.text = team
            return cell
        }

    }
    
//    let quiz1 = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    var stringTableData1 = DataTable(["hello" : ["efw", "wewe"]])
    
    var data: [Question1] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data1 = DataLoader(urlString).quizzes[indexPick].questions
        
        let repository = QuizRepository(change, urlString)


        
        if correct {
            CheckAnswer.text = "Correct!"
        }
        
        finish.isHidden = true
        
        if data1.count == 1 {
            finish.isHidden = false
            check.isEnabled = false
        }
        

        
        stringTableData1 = DataTable(repository.quizzes[indexPick].question1, quiz: repository.quizzes[indexPick])
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("User selected \(indexPath)")
        
//        if indexPath.row == 2 {
//            quiz1.score += 1
//            NSLog("score: \(quiz1.score)")
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
            if segue.identifier == "nextQuestion" {
                let controller = segue.destination as? ActualQuestion2ViewController
                controller?.quiz = quiz
                controller?.repository = repository
                //            controller?.correct = quiz.correct
                controller?.indexPick = indexPick
                controller?.score = score
                controller?.change = change
                controller?.urlString = urlString

                print("Preparing for segue - change: \(change) and score: \(score) hiii")
            }

        if segue.identifier == "back" {
            let controller = segue.destination as? ViewController
            controller?.change = change
            controller?.urlString = urlString
            print("Preparing for segue - indexPick: \(indexPick) and score: \(score)")

            
            
        }
        
        if segue.identifier == "finish" {
            let controller = segue.destination as? FinishedViewController
            controller?.quiz = quiz
            controller?.score = score
            controller?.repository = repository
            controller?.correct = quiz.correct
            controller?.indexPick = indexPick
            controller?.change = change
            controller?.urlString = urlString

            print("Preparing for segue - indexPick: \(indexPick) and score: \(score)")
            print("Preparing for segue - indexPick: \(indexPick) and score: \(score)")

            
            
        }
            
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "FirstViewAnswer" {
//            let controller = segue.destination as? Question2ViewController
//            controller?.quiz = quiz
//            print("Preparing for segue - indexPick: \(quiz)")
//
//            
//            
//        }
//    }

}
