//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let apiKey = "AIzaSyCle3vkXuwf0ET-UgCqAWz8NlojY_WV-NE"
let cx = "014498682126902798498:sqnzmufwthi"
let query = "potato"
let start = 10
let googleUrl = "https://www.googleapis.com/customsearch/v1?key=\(apiKey)&cx=\(cx)&q=\(query)&start=\(start)"
let url = URL(string: googleUrl)!

struct Response: Decodable {
  let items: [Item]
}

struct Item: Decodable {
  let pageMap: PageMap

  enum CodingKeys: String, CodingKey {
    case pageMap = "pagemap"
  }
}

struct PageMap: Decodable {
  let image: [Image]

  enum CodingKeys: String, CodingKey {
    case image = "cse_image"
  }
}

struct Image: Decodable {
  let url: URL

  enum CodingKeys: String, CodingKey {
    case url = "src"
  }
}

URLSession.shared.dataTask(with: url) { (data, response, error) in
  if let data = data {
    do {
      let response: Response = try JSONDecoder().decode(Response.self, from: data)
      let urls = response.items
        .map { $0.pageMap.image }
        .map { $0.first!.url }

      print(urls)

    } catch(let error) {
      print(error)
    }
  }

  PlaygroundPage.current.finishExecution()
}.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
