//
//  Question1ViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/3/25.
//

import UIKit

class Question1ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tblTable: UITableView!
    
    var indexPick : Int = 0
    var score = 0
    var change = false
    var quiz = Quiz()
    var repository = QuizRepository()
    
    
    
    
    
    class StringTableData: NSObject, UITableViewDataSource {
        
        
        let league : [String: [String]] = [
            "AFC East" : [ "Buffalo Bills", "Miami Dolphins", "New England Patriots", "New York Jets" ],
            "AFC North": [ "Baltimore Ravens", "Cleveland Browns", "Cincinnati Bengals", "Pittsburgh Steelers" ],
            "AFC South": [ "Houston Texans", "Tennessee Titans", "Jacksonville Jaguars", "Indianapolis Colts" ],
            "AFC West" : [ "Los Angeles Chargers", "Las Vegas Raiders", "Kansas City Chiefs", "Denver Broncos" ],
            "NFC East" : [ "A", "B", "C", "D" ],
            "NFC North": [ "A", "B", "C", "D" ],
            "NFC South": [ "A", "B", "C", "D" ],
            "NFC West" : [ "A", "B", "C", "D" ]
        ]
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return league.keys.count
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return (Array(league.keys))[section]
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4  // Every division has four teams in it
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Question")!
            let division = (Array(league.keys))[indexPath.section]
            let team = league[division]?[indexPath.row]
            cell.textLabel?.text = team
            return cell
        }
    }
    
    let stringTableData = StringTableData()
    
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
            print(indexPath.row)
            print(quiz1.correct1Index)
            NSLog("hiii")
            if indexPath.row == quiz1.correct1Index {
                quiz1.score += 1
                quiz1.correct = true
            } else {
                quiz1.correct = false
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Question")!
            let division = (Array(data.keys))[indexPath.section]
            let team = data[division]?[indexPath.row]
            cell.textLabel?.text = team
            return cell
        }
    }
    
//    let quiz1 = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
    var stringTableData1 = DataTable(["hello" : ["efw", "wewe"]])
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tblTable.dataSource = stringTableData
//        tblTable.delegate = self
        
//        quiz = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
        let repository : QuizRepository = QuizRepository(change)

        
        stringTableData1 = DataTable(repository.quizzes[indexPick].question1, quiz: repository.quizzes[indexPick])
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("User selected \(indexPath)")
        
        if indexPath.row == repository.quizzes[indexPick].correct1Index  {
            quiz.score += 1
            score += 1
            NSLog("score: \(quiz.score)")
            quiz.correct = true
        } else {
            quiz.correct = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstViewAnswer" {
            let controller = segue.destination as? Question2ViewController
            controller?.quiz = quiz
            controller?.repository = repository
            controller?.correct = quiz.correct
            controller?.indexPick = indexPick
            controller?.score = score
            controller?.change = change
            print("Preparing for segue - indexPick: \(indexPick) and score: \(score)")

            
            
        }
        
        if segue.identifier == "back" {
            let controller = segue.destination as? ViewController
            controller?.change = change
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
