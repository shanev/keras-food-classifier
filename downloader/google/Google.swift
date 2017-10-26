import Foundation

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

func downloadFile(at url:URL) {
  let filename = url.lastPathComponent

  URLSession.shared.downloadTask(with: url) { (url, response, error) in
    do {
      let fileUrl = URL(fileURLWithPath:"./images").appendingPathComponent(filename)
      try FileManager.default.copyItem(at: url!, to: fileUrl)
      print("Downloaded \(filename)...")
    } catch (let error) {
      print(error)
    }
  }.resume()
}

// TODO
// create all the google urls for start 1, 11, etc..
// create all data tasks
// start all

URLSession.shared.dataTask(with: url) { (data, response, _) in
  if let response = response as? HTTPURLResponse {
    if response.statusCode == 403 {
      print("Reached API limit")
    }
  }

  if let data = data {
    do {
      let response: Response = try JSONDecoder().decode(Response.self, from: data)
      let urls = response.items
        .map { $0.pageMap.images }
        .map { $0.first!.url }

      for url in urls {
        downloadFile(at: url)
      }
      print("Done downloading files.")

    } catch(let error) {
      print(error)
    }
  }
}.resume()

RunLoop.current.run()
