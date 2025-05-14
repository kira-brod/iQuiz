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
    
    init() {
        load()
    }
    
    func load() {
        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")!
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            quizzes = try decoder.decode([QuizJSON].self, from: data)
           
        } catch {
            print(error)
        }
    }
    
    func sort() {
        quizzes.sort { $0.title < $1.title }
    }
}


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var headersLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var headerString : String = ""
    var bodyString : String = ""


        
    @IBAction func goPushed(_ sender: Any) {
      headersLabel.text! = ""
      bodyLabel.text! = "Sending request \nto \(addressField.text!)..."

      // {{## BEGIN create-url ##}}
      // Set up the request before we do the off-UI thread work
      let url = URL(string: self.addressField.text!)
      if url == nil {
        // TODO: Need a better error message
        NSLog("Bad address")
        return
      }
      // {{## END create-url ##}}

      // {{## BEGIN create-request ##}}
      var request = URLRequest(url: url!)
      request.httpMethod = "GET"
      
      headersLabel.text! = "\(request.httpMethod!) \(url!.absoluteString) HTTP/1.1\n"
      let headerFields = request.allHTTPHeaderFields
      for (name, value) in headerFields! {
        headersLabel.text! = headersLabel.text! + "\(name) = \(value)\n"
      }
      // {{## END create-request ##}}
        
        
      
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

    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
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
