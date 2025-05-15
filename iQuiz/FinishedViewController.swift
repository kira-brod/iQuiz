//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/6/25.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var quiz = Quiz()
    var repository = QuizRepository()
    var correct = false
    var indexPick : Int = 0
    var score : Int = 0
    var change = false

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
        
        if score == 2 {
            des.text = "Almost"
        } else if score == 3 {
            des.text = "Perfect!"
        } else if score == 1 {
            des.text = "Good try"
        }else {
            des.text = "Not quite"
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let controller = segue.destination as? ViewController
            controller?.change = change
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
