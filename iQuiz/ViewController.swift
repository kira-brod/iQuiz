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
    }
    
    @IBAction func Settings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Close the alert"),style: .default, handler: { _ in
              alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
                                                

}
                        
                                                                                                                                                                                                                                                        
