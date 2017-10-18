//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport
import UIKit

var str = "Hello, playground"

let googleUrl = "https://www.googleapis.com/customsearch/v1?key=AIzaSyCle3vkXuwf0ET-UgCqAWz8NlojY_WV-NE&cx=014498682126902798498:sqnzmufwthi&q=potato"
let url = URL(string: googleUrl)!

// let peopleNamedTom = arrayOfPeople.filter { $0["Name"] == "Tom" }

URLSession.shared.dataTask(with: url) { (data, response, error) in
  if let data = data {
    if let json = try? JSONSerialization.jsonObject(with: data) {
      if let dictionary = json as? [String: Any] {
        if let items = dictionary["items"] as? NSArray {
          items.map { print($0) }
        }
      }
    }
  }
  PlaygroundPage.current.finishExecution()
}.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
