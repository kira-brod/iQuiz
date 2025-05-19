//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Kira Brodsky on 5/12/25.
//

import UIKit

struct QuizJSON: Codable {
    let title, desc: String
    let questions: [Question]
}

struct Question: Codable {
    let text, answer: String
    let answers: [String]
}



public class DataLoader {
    @Published var quizzes = [QuizJSON]()
    var urlString: String = "https://tednewardsandbox.site44.com/questions.json"
    
    init(_ url1 : String) {
        
        if url1 != "" {
            load(url1)
        } else {
            load("https://tednewardsandbox.site44.com/questions.json")
        }
    }
    
    func load( _ url1 : String) {
        let url = URL(string: url1)!
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            quizzes = try decoder.decode([QuizJSON].self, from: data)
           
        } catch {
            print(error)
        }
    }
    
//    func sort() {
//        quizzes.sort { $0.title < $1.title }
//    }
}

var repository = QuizRepository(false, "https://tednewardsandbox.site44.com/questions.json")


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var headersLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var headerString : String = ""
    var bodyString : String = ""
    var change = false
    var url : URL?
    var data = DataLoader("https://tednewardsandbox.site44.com/questions.json").quizzes
    
    let file = NSHomeDirectory() + "/Documents/archive.quizzes"


    var quizzes : [Quiz1] = []
    
    var reload = false
    
    


        
    @IBAction func goPushed(_ sender: Any) {
      headersLabel.text! = ""
      bodyLabel.text! = "Sending request \nto \(addressField.text!)..."
        

      // {{## BEGIN create-url ##}}
      // Set up the request before we do the off-UI thread work
      url = URL(string: self.addressField.text!)
      if url == nil {
        // TODO: Need a better error message
        NSLog("Bad address")
        return
      }
      // {{## END create-url ##}}
//        repository.load = true
      // {{## BEGIN create-request ##}}
      var request = URLRequest(url: url!)
      request.httpMethod = "GET"
      
      headersLabel.text! = "\(request.httpMethod!) \(url!.absoluteString) HTTP/1.1\n"
      let headerFields = request.allHTTPHeaderFields
      for (name, value) in headerFields! {
        headersLabel.text! = headersLabel.text! + "\(name) = \(value)\n"
      }
      // {{## END create-request ##}}
        
      change = true
      repository = QuizRepository(change, self.addressField.text!)
      
      // Set up a spinner
      spinner.startAnimating()

      // {{## BEGIN start-task ##}}
      // Move to a background thread to do some long running work
      (URLSession.shared.dataTask(with: url!) {
        data, response, error in
          
          
        
        DispatchQueue.main.async {
          if error == nil {
            NSLog(response!.description)
            
            let response = response! as! HTTPURLResponse
            
            var headers = ""
            headers = "\(response.statusCode)\n"
            for (name, value) in response.allHeaderFields {
              headers += "\(name as! String) = \(value as! String)\n"
            }
            self.headersLabel.text! = headers
              
            
            if data == nil {
              self.bodyLabel.text! = "<Body is empty>"
            }
            else {
              NSLog(data!.description)
              self.bodyLabel.text! = String(describing: data!)
            }
          }
          else {
            self.headersLabel.text! = error!.localizedDescription
              
          }
          
          self.spinner.stopAnimating()
        }
          
    }).resume()
      // {{## END start-task ##}}
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        data = DataLoader(addressField.text!).quizzes
        repository.data = data
      
    }
    
    @IBAction func storeData(_ sender: Any) {
        
        quizzes = parseQuizTopics(data)
        print("Save pressed")
        NSKeyedArchiver.archiveRootObject(quizzes, toFile: file)
        
        let defaults = UserDefaults.standard
        
        let string = "https://tednewardsandbox.site44.com/questions.json"
        
        defaults.set("\(self.addressField.text ?? string)", forKey: "name_preference")
        
    }
    
    @IBAction func Test(_ sender: Any) {
        print(quizzes[0].desc)
    }
    
    
    @IBAction func loadData(_ sender: Any) {
       
        print("Load pressed")
        guard let loadedQuizzes =
                NSKeyedUnarchiver.unarchiveObject(withFile: file) as? [Quiz1] else {
            let alert = UIAlertController(title: "Error", message: "Quizzes failed to load", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        repository.quizzes2 = loadedQuizzes
        print(loadedQuizzes[0].desc)
        change = true
        reload = true
    }
    
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backHome" {
            let controller = segue.destination as? ViewController
//            controller?.quiz = quiz
            controller?.repository = repository
            //            controller?.correct = quiz.correct
//            controller?.indexPick = indexPick
//            controller?.score = score
              controller?.change = change
            controller?.urlString = "https://tednewardsandbox.site44.com/questions.json"
            controller?.reload = reload
            controller?.saved = quizzes
            print("Preparing for segue - repo: \(repository.quizzes2)")
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
