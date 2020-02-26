//
//  ViewController.swift
//  TweetSentiment
//
//  Created by Abdul Diallo on 2/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    private let swifter = Swifter(consumerKey: "4KEjNbACHcM1lKTqojq4PeoE6", consumerSecret: "aguhLFBeJd7mbbUAJ2vvXDCASBAqjZwdwuCRNzkreDtPI4Go9T")
    
    private let model = sentimentClassifier()
    
    private let max = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkSentiment(_ sender: UIButton) {
        
        if let inputed = sentimentLabel.text {
            fetch(with: inputed)
        }
        
    }
    
    //MARK: - <#section heading#>
    
    func fetch(with inputed : String) {
        
            swifter.searchTweet(using: "\(inputed)", lang: "en", count: max, tweetMode: .extended, success: { (results, metadata) in
                var tweets = [sentimentClassifierInput]()
                for i in 0...self.max-1 {
                    if let tweet = results[i]["full_text"].string {
                        tweets.append(sentimentClassifierInput(text: tweet))
                    }
                }
                self.predictSentiment(with : tweets)
            }) { (error) in
                print("error - \(error)")
            }
        
        }
    
    
    func predictSentiment(with tweets : [sentimentClassifierInput]) {
        
        do {
            var score = 0
            let predictions = try self.model.predictions(inputs: tweets)
            for pd in predictions {
                if pd.label == "Pos" {
                    score += 1
                } else if pd.label == "Neg" {
                    score -= 1
                }
            }
            self.updateUI(with : score)
        } catch {
            print("Error predicting")
        }
        
    }
    
    
    func updateUI(with score : Int) {
        
        if score > 15 {
            self.sentimentLabel.text = "🤩"
        } else if score > 10 {
            self.sentimentLabel.text = "😄"
        } else if score > 5 {
            self.sentimentLabel.text = "🙂"
        } else if score == 0 {
            self.sentimentLabel.text = "🙄"
        } else if score > -5 {
            self.sentimentLabel.text = "😬"
        } else if score > -10 {
            self.sentimentLabel.text = "😰"
        } else if score > -15 {
            self.sentimentLabel.text = "🤮"
        } else {
            self.sentimentLabel.text = "💩"
        }
        
    }
}

