//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let apiKey = "AIzaSyCle3vkXuwf0ET-UgCqAWz8NlojY_WV-NE"
let cx = "014498682126902798498:sqnzmufwthi"
let query = "potato"
let start = 1
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
  let images: [Image]

  enum CodingKeys: String, CodingKey {
    case images = "cse_image"
  }
}

struct Image: Decodable {
  let url: URL

  enum CodingKeys: String, CodingKey {
    case url = "src"
  }
}

//URLSession.shared.dataTask(with: url) { (data, response, _) in
//  if let response = response as? HTTPURLResponse {
//    if response.statusCode == 403 {
//      print("Reached API limit")
//      PlaygroundPage.current.finishExecution()
//    }
//  }
//
//  if let data = data {
//    do {
//      let response: Response = try JSONDecoder().decode(Response.self, from: data)
//      let urls = response.items
//        .map { $0.pageMap.images }
//        .map { $0.first!.url }
//      print(urls)
//    } catch(let error) {
//      print(error)
//    }
//  }
//
//  PlaygroundPage.current.finishExecution()
//}.resume()

//func downloadFile(at url:URL) {
//  let filename = url.lastPathComponent
//
//  URLSession.shared.downloadTask(with: url) { (url, response, error) in
//    do {
//      let fileUrl = playgroundSharedDataDirectory.appendingPathComponent(filename)
//      try FileManager.default.copyItem(at: url!, to: fileUrl)
//
//      PlaygroundPage.current.finishExecution()
//    } catch (let error) {
//      print(error)
//    }
//  }.resume()
//}
//
//let imageUrl = URL(string: "https://www.potatogoodness.com/wp-content/uploads/2016/06/Asian-Potato-Salad-e1485804077924.jpg")!
//downloadFile(at: imageUrl)

//let numPics = 1000
//let pageSize = 10
//let urls = (0 ..< numPics / pageSize)
//  .map { "https://www.googleapis.com/customsearch/v1?key=\(apiKey)&cx=\(cx)&q=\(query)&start=\($0 * pageSize + 1)" }
//print(urls)
//
//func fetchImageUrls(forQueryUrl url:URL) {
//
//}

let s = "Hello"


//PlaygroundPage.current.needsIndefiniteExecution = true

