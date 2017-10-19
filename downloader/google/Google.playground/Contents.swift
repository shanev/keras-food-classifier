//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let googleUrl = "https://www.googleapis.com/customsearch/v1?key=AIzaSyCle3vkXuwf0ET-UgCqAWz8NlojY_WV-NE&cx=014498682126902798498:sqnzmufwthi&q=potato"
let url = URL(string: googleUrl)!

URLSession.shared.dataTask(with: url) { (data, response, error) in
  if let data = data {
    if let json = try? JSONSerialization.jsonObject(with: data) {
      if let dictionary = json as? [String: Any] {
        if let items = dictionary["items"] as? NSArray {
          for item in items {
            if let dict = item as? [String: Any] {
              if let pagemap = dict["pagemap"] as? [String: Any] {
                if let images = pagemap["cse_image"] as? NSArray {
                  for image in images {
                    if let imageUrl = image as? [String: Any] {
                      print(imageUrl["src"]!)
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  PlaygroundPage.current.finishExecution()
}.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
