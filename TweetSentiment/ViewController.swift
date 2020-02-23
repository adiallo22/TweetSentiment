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
    
    let swifter = Swifter(consumerKey: "4KEjNbACHcM1lKTqojq4PeoE6", consumerSecret: "aguhLFBeJd7mbbUAJ2vvXDCASBAqjZwdwuCRNzkreDtPI4Go9T")
    
    let model = sentimentClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkSentiment(_ sender: UIButton) {
        
        if let inputed = sentimentLabel.text {
            swifter.searchTweet(using: inputed, lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
                var tweets = [sentimentClassifierInput]()
                for i in 0...99 {
                    if let tweet = results[i]["full_text"].string {
                        tweets.append(sentimentClassifierInput(text: tweet))
                    }
                }
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
                } catch {
                    print("Error predicting")
                }
            }) { (error) in
                print("error - \(error)")
            }
        }
    }  //MARK: - <#section heading#>
    
    func fetch() {
        
    }
    
}

