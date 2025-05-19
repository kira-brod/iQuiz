//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/6/25.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var quiz = Quiz(name: "Marvel Super Heroes", desc: "hero quiz", score: 0, question1: ["What is the name of the green guy?" : ["Greenie", "Hulk", "Verde", "grass"]], question2: ["Who shoots webs?" : ["spider man", "iron man", "captain america", "Hulk"]], question3: ["What tool does Thor have?" : ["sword", "hammer", "screw driver", "wrench"]], correct1Index: 1, correct2Index: 0, correct3Index: 1)
    var repository = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json", [])
    var correct = false
    var indexPick : Int = 0
    var score : Int = 0
    var change = false
    var urlString : String = ""

    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var des: UILabel!
    
    //    scoreLable.text = "\(score)"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var total = 0
        
        if indexPick == 1 {
            total = 3
        } else {
            total = 1
        }
        
        scoreLabel.text = "\(score) out of \(total)"
        
        if total == 3 {
            if score == 2 {
                des.text = "Almost"
            } else if score == 3 {
                des.text = "Perfect!"
            } else if score == 1 {
                des.text = "Good try"
            }else {
                des.text = "Not quite"
            }
        } else {
            if score == 1 {
                des.text = "Perfect!"
            } else {
                des.text = "Not quite"
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let controller = segue.destination as? ViewController
            controller?.change = change
            controller?.urlString = urlString

            print("Preparing for segue - indexPick: \(indexPick) and score: \(score) hiii")
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
