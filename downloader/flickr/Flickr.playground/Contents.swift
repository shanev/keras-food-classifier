//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let apiKey = "397f6cb2fa4e293b76420bf51bc822fc"
let escapedSearchText = "potato"
let flickrUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(escapedSearchText)&per_page=25&format=json&nojsoncallback=1"
let url = URL(string: flickrUrl)!

URLSession.shared.dataTask(with: url) { (data, response, error) in
  if let data = data {
    if let json = try? JSONSerialization.jsonObject(with: data) {
      if let dictionary = json as? [String: Any] {
        print(dictionary)
      }
    }
  }
  PlaygroundPage.current.finishExecution()
  }.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
