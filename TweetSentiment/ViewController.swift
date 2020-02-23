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
        let output = try! model.prediction(text: "@google is a nice place to work")
        sentimentLabel.text = output.label
    }

    @IBAction func checkSentiment(_ sender: UIButton) {
        if let inputed = sentimentLabel.text {
            swifter.searchTweet(using: "\(inputed)", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
                var tweets = [String]()
                for i in 0...99 {
                    if let tweet = results[i]["full_text"].string {
                        tweets.append(tweet)
                    }
                }
                print(tweets)
            }) { (error) in
                print("error - \(error)")
            }
        }
    }
    
}

