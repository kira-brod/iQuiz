//
//  ActualQuestion2AnswerViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/11/25.
//

import UIKit

class ActualQuestion2AnswerViewController: UIViewController, UITableViewDelegate {

    var quiz = Quiz()
    var repository = QuizRepository()
    var correct = false
    var indexPick : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var tblTable: UITableView!
    
    @IBOutlet weak var CheckAnswer: UILabel!
    
    
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
            return 3
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == quiz1.correct2Index {
                quiz1.score += 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answer")!
            let division = (Array(data.keys))[indexPath.section]
            let team = data[division]?[indexPath.row]
            cell.textLabel?.text = team
            
            if indexPath.row == quiz1.correct2Index {
                cell.backgroundColor = UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.2)
            }
            
            return cell
        }
    }
    
//    let quiz1 = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    var stringTableData1 = DataTable(["hello" : ["efw", "wewe"]])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if correct {
            CheckAnswer.text = "Correct!"
        }
        
        
//        tblTable.dataSource = stringTableData
//        tblTable.delegate = self
        
//        quiz = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
        
        stringTableData1 = DataTable(repository.quizzes[indexPick].question2, quiz: repository.quizzes[indexPick])
                
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
        
        NSLog("\(score)")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finish" {
            let controller = segue.destination as? FinishedViewController
            controller?.quiz = quiz
            controller?.score = score
            controller?.repository = repository
            controller?.correct = quiz.correct
            controller?.indexPick = indexPick
            print("Preparing for segue - indexPick: \(indexPick) and score: \(score)")

            
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
