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

    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var des: UILabel!
    
    //    scoreLable.text = "\(score)"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(score)"
        
        if score == 1 {
            des.text = "Almost"
        } else if score == 2 {
            des.text = "You did it!"
        } else {
            des.text = "Not quite"
        }
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
