//
//  ViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 4/29/25.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tblTable: UITableView!
    
//    let stringTableData = StringTableDataModel([
//        "Mathematics",
//        "Marvel Super Heroes",
//        "Science"
//    ])
    
    var indexPick : Int = 0
    var change = false
    var repository = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json")
    var urlString : String = ""
    var reload = false
    var saved : [Quiz1] = []
    
    
    class StringTableData: NSObject, UITableViewDataSource {
        
        
        
    
        let data1 : [String] = [
            "Mathematics",
            "Marvel Super Heroes",
            "Science"
        ]
        
        let subtitles : [String] = [
            "Take a quiz about mathematics",
            "Take a quiz about Marvel Super Heroes",
            "Take a quiz about Science"
        ]
        
//        init(_ items : [String]) {
//            data = items
//        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data1.count
        }
        

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StringCell")!
            cell.textLabel?.text = data1[indexPath.row]
            cell.detailTextLabel?.text = subtitles[indexPath.row]
            return cell
        }
    }
    
    let stringTableData = StringTableData()
    
    class DataTable : NSObject, UITableViewDataSource {
        
        var data : [String: String] = [:]
        var quiz1 : Quiz = Quiz(name: "Marvel Super Heroes", desc: "hero quiz", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde", "grass"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america", "Hulk"]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver", "wrench"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
        
        var names : [String] = []
        var detail : [String] = []
        var repo = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json")
        

        
        
        
        
        
        init(_ items : [String : String], quiz q : Quiz) {
            data = items
            quiz1 = q
            
            for mapKey in Array(data.keys) {
                names.append(mapKey)
            }
            
        }
        
        init(_ names : [String], _ detail : [String]) {
            self.names = names
            self.detail = detail
        }
        
        
        
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return data.keys.count
//        }
//        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            return (Array(data.keys))[section]
//        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == quiz1.correct1Index {
                quiz1.score += 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StringCell")!
            
            cell.textLabel?.text = (names)[indexPath.row]
            cell.detailTextLabel?.text = (detail)[indexPath.row]
            return cell
        }

    }
    
    var stringTableData1 = DataTable(["hello"], ["bye"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if reload {
            tblTable.reloadData()
        }
        
        var repository = QuizRepository(change, urlString)

        
        var names = [repository.quizzes[0].name, repository.quizzes[1].name, repository.quizzes[2].name]
        var detail = [repository.quizzes[0].desc, repository.quizzes[1].desc, repository.quizzes[2].desc]
        stringTableData1 = DataTable(names, detail)
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self
        print(names)
        print(repository.quizzes[0].name)
        
    
        
    }
    
//    @IBAction func Settings(_ sender: Any) {
//        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Close the alert"),style: .default, handler: { _ in
//              alert.dismiss(animated: true)
//        }))
//        self.present(alert, animated: true)
//    }
    
//    func tableView (_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
//        NSLog("You selected cell \(indexPath.row)")
//    }
    
    func tableView (_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        NSLog("hello")
        if indexPath.row == 0 {
            indexPick = 0
            performSegue(withIdentifier: "FirstViewController", sender: nil)
        } else if indexPath.row == 1 {
            indexPick = 1
            performSegue(withIdentifier: "FirstViewController", sender: nil)
        } else {
            indexPick = 2
            performSegue(withIdentifier: "FirstViewController", sender: nil)
        }
    }
    
//    func tableView (_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Question1ViewController") as? Question1ViewController {
//            
//            self.navigationController?.pushViewController(vc, animated: true)
//            
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstViewController" {
            let controller = segue.destination as? Question1ViewController
            controller?.indexPick = indexPick
            controller?.repository = repository
            controller?.change = change
            controller?.urlString = urlString
            print("Preparing for segue - indexPick: \(indexPick)")

            
            
        }
        
        if segue.identifier == "settings" {
            let controller = segue.destination as? SettingsViewController
            controller?.quizzes = saved
        }
    }
       
                                                

}
                        
                                                                                                                                                                                                                                                        
