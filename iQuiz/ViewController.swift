//
//  ViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 4/29/25.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate {
    
    let myRefreshControl = UIRefreshControl()

    @IBOutlet weak var tblTable: UITableView!
    
//    let stringTableData = StringTableDataModel([
//        "Mathematics",
//        "Marvel Super Heroes",
//        "Science"
//    ])
    
    var indexPick : Int = 0
    var change = false
    var repository = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json", [])
    var urlString : String = UserDefaults.standard.string(forKey: "name_preference") ?? "https://tednewardsandbox.site44.com/questions.json"
    var reload = false
    var saved : [Quiz1] = []
    var url : URL?
    var quizzes : [Quiz1] = []
    
    var data = DataLoader("https://tednewardsandbox.site44.com/questions.json").quizzes
    
    let file = NSHomeDirectory() + "/Documents/archive.quizzes"
    
    var repo = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json", [])
    
    
    class DataTable : NSObject, UITableViewDataSource {
        
        var data : [String: String] = [:]
        var quiz1 : Quiz = Quiz(name: "Marvel Super Heroes", desc: "hero quiz", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde", "grass"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america", "Hulk"]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver", "wrench"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
        
        var names : [String] = []
        var detail : [String] = []
        var repo = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json", [])
        
        
        
        
        init(_ items : [String : String], quiz q : Quiz) {
            data = items
            quiz1 = q
            
            print(repo.quizzes2)
            
            for mapKey in Array(data.keys) {
                names.append(mapKey)
            }
            
        }
        
        init(_ names : [String], _ detail : [String]) {
            self.names = names
            self.detail = detail
            
            print(repo.quizzes2)

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
//            repo = QuizRepository(change, urlString, saved)
            self.tblTable.reloadData()
            change = true
        }
        
        saved = parseQuizTopics(data)
//        change = true
        myRefreshControl.addTarget(self, action: #selector(ViewController.Load), for: .valueChanged)
        tblTable.refreshControl = myRefreshControl
        
        
        repository = repo
        
        if change {
            repository = QuizRepository(true, "", saved)
              
        }
        
        var names = [repository.quizzes[0].name, repository.quizzes[1].name, repository.quizzes[2].name]
        var detail = [repository.quizzes[0].desc, repository.quizzes[1].desc, repository.quizzes[2].desc]
        stringTableData1 = DataTable(names, detail)
        
        tblTable.dataSource = stringTableData1
        tblTable.delegate = self
        print(names)
        print(repository.quizzes[0].name)
        print("saved : \(saved)")
        
    
        
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
    
    @IBAction func AppSettings(_ sender: Any) {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
    }
    
    @IBAction func Store(_ sender: Any) {
        
        // {{## BEGIN create-url ##}}
        // Set up the request before we do the off-UI thread work
        url = URL(string: UserDefaults.standard.string(forKey: "name_preference")!)
        if url == nil {
            // TODO: Need a better error message
            NSLog("Bad address")
            change = false
            return
        }
        // {{## END create-url ##}}
        //        repository.load = true
        // {{## BEGIN create-request ##}}
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        //        headersL/*abel.text! = "\(request.httpMethod!) \(url!.absoluteString) HTTP/1.1\n"*/
        let headerFields = request.allHTTPHeaderFields
        //        for (name, value) in headerFields! {
        //          headersLabel.text! = headersLabel.text! + "\(name) = \(value)\n"
        //        }
        // {{## END create-request ##}}
        
        change = true
        repository = QuizRepository(change, UserDefaults.standard.string(forKey: "name_preference")!, [])
        
        // Set up a spinner
        //        spinner.startAnimating()
        
        // {{## BEGIN start-task ##}}
        // Move to a background thread to do some long running work
        (URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            
            
            DispatchQueue.main.async {
                if error == nil {
//                    NSLog(response!.description)
                    
                    let response = response! as! HTTPURLResponse
                    
                    
                    var headers = ""
                    headers = "\(response.statusCode)\n"
                    for (name, value) in response.allHeaderFields {
                        headers += "\(name as! String) = \(value as! String)\n"
                    }
                    //              self.headersLabel.text! = headers
                    
                    
                    if data == nil {
                        //                self.bodyLabel.text! = "<Body is empty>"
                    }
                    else {
//                        NSLog(data!.description)
                        //                self.bodyLabel.text! = String(describing: data!)
                    }
                }
                else {
                    //              self.headersLabel.text! = error!.localizedDescription
                    
                }
                
                //            self.spinner.stopAnimating()
            }
            
        }).resume()
        
        
        quizzes = parseQuizTopics(DataLoader(UserDefaults.standard.string(forKey: "name_preference")!).quizzes)
//        print("Save pressed")
        NSKeyedArchiver.archiveRootObject(quizzes, toFile: file)
    }
    
    @IBAction func Load(_ sender: Any) {
        
        
        print("Load pressed")
        guard let loadedQuizzes =
                NSKeyedUnarchiver.unarchiveObject(withFile: file) as? [Quiz1] else {
            let alert = UIAlertController(title: "Error", message: "Quizzes failed to load", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        repository.quizzes2 = loadedQuizzes
        saved = loadedQuizzes
        print(loadedQuizzes[0].desc)
        change = true
        reload = true
        
        print("url: \(UserDefaults.standard.string(forKey: "name_preference")!)")
        repo = QuizRepository(true, UserDefaults.standard.string(forKey: "name_preference")!, saved)
        
        var names = [repository.quizzes[0].name, repository.quizzes[1].name, repository.quizzes[2].name]
        var detail = [repository.quizzes[0].desc, repository.quizzes[1].desc, repository.quizzes[2].desc]

        stringTableData1 = DataTable(names, detail)
        tblTable.dataSource = stringTableData1
        tblTable.reloadData()
        myRefreshControl.endRefreshing()
        
//        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
//            self.tblTable.reloadData()
//            self.myRefreshControl.endRefreshing()
//            print("booty cheeks")
//        }
        
//        DispatchQueue.main.async{
//            print(loadedQuizzes[0].desc)
//            self.tblTable.reloadData()
//            self.myRefreshControl.endRefreshing()
//            
//        }
        
//        self.view.layoutIfNeeded()
      
        print(saved)
        
        
                             
                             

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstViewController" {
            let controller = segue.destination as? Question1ViewController
            controller?.indexPick = indexPick
            controller?.repository = repository
            controller?.change = change
            controller?.urlString = urlString
            controller?.saved = saved
            print("Preparing for segue - indexPick: \(indexPick)")

            
            
        }
        
        if segue.identifier == "settings" {
            let controller = segue.destination as? SettingsViewController
            controller?.quizzes = saved
        }
    }
       
                                                

}
                        
                                                                                                                                                                                                                                                        
