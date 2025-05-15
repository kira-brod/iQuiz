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
    var repository = QuizRepository()
    var urlString : String = ""
    
    
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
        var quiz1 : Quiz = Quiz()
        
        var names : [String] = []
        var repo = QuizRepository()
        

        
        
        
        
        
        init(_ items : [String : String], quiz q : Quiz) {
            data = items
            quiz1 = q
            
            for mapKey in Array(data.keys) {
                names.append(mapKey)
            }
            
        }
        
        init(_ items : [String : String]) {
            data = items
            
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
            
            
            cell.textLabel?.text = (Array(data.keys))[indexPath.row]
            cell.detailTextLabel?.text = (Array(data.values))[indexPath.row]
            return cell
        }

    }
    
    var stringTableData1 = DataTable(["hello" : "bye"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        var repository = QuizRepository(change, urlString)

        
        var names = [repository.quizzes[0].name : repository.quizzes[0].desc, repository.quizzes[1].name : repository.quizzes[1].desc, repository.quizzes[2].name : repository.quizzes[2].desc]
        stringTableData1 = DataTable(names)
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self
        print("hello")
        print(repository.quizzes2)
        
    
        
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
    }
       
                                                

}
                        
                                                                                                                                                                                                                                                        
