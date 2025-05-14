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
    
    class StringTableData: NSObject, UITableViewDataSource {
        
    
        let data : [String] = [
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
            return data.count
        }
        

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StringCell")!
            cell.textLabel?.text = data[indexPath.row]
            cell.detailTextLabel?.text = subtitles[indexPath.row]
            return cell
        }
    }
    
    let stringTableData = StringTableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tblTable.dataSource = stringTableData
        tblTable.delegate = self
        
        let data = DataLoader().quizzes
        print(data)
        
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
            print("Preparing for segue - indexPick: \(indexPick)")

            
            
        }
    }
       
                                                

}
                        
                                                                                                                                                                                                                                                        
