//
//  Constants.swift
//  TweetSentiment
//
//  Created by Abdul Diallo on 2/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

struct Constants {
    
    let consumerKey = "4KEjNbACHcM1lKTqojq4PeoE6"
    private let consumerSecret = "aguhLFBeJd7mbbUAJ2vvXDCASBAqjZwdwuCRNzkreDtPI4Go9T"
    private let max = 100
    
    
    func getConsumerKey() -> String {
        return consumerKey
    }
    
    func getConsumerSecret() -> String {
        return consumerSecret
    }
    
    func getMax() {
        return max
    }
    
}
