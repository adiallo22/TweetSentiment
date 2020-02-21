//
//  ViewController.swift
//  TweetSentiment
//
//  Created by Abdul Diallo on 2/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    
    let swifter = Swifter(consumerKey: "4KEjNbACHcM1lKTqojq4PeoE6", consumerSecret: "aguhLFBeJd7mbbUAJ2vvXDCASBAqjZwdwuCRNzkreDtPI4Go9T")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkSentiment(_ sender: UIButton) {
    }
    
}

