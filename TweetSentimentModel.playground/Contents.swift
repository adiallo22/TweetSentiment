import Cocoa
import CreateML


let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/abduldiallo/Documents/LAB/TweetSentiment/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = (data.randomSplit(by: 0.80, seed: 5))

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetric = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let accuracy = (1.0 - evaluationMetric.classificationError)*100

let metaData = MLModelMetadata(author: "Abdul Diallo", shortDescription: "The model predict the overall sentiment of a subject on twitter", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/abduldiallo/Documents/LAB/TweetSentiment/sentimentClassifier.mlmodel"))

try sentimentClassifier.prediction(from: "@msft is a company that i like for real")





