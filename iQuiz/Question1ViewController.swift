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
    
    let repository = QuizRepository()
    
    
    
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
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Question")!
            let division = (Array(data.keys))[indexPath.section]
            let team = data[division]?[indexPath.row]
            cell.textLabel?.text = team
            return cell
        }
    }
    
    var stringTableData1 = DataTable(["hello" : ["efw", "wewe"]])
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tblTable.dataSource = stringTableData
//        tblTable.delegate = self
        
        let quiz = repository.createQuiz(name: "Mathematics", question1: ["2 * 6?" : ["4", "8", "12"]], question2: ["4 + 12?" : ["16", "20", "24"]], question3: ["5 - 4?" : ["9", "1", "17"]], correct1Index: 2, correct2Index: 0, correct3Index: 1)
        
        stringTableData1 = DataTable(quiz.question1)
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self

        // Do any additional setup after loading the view.
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
