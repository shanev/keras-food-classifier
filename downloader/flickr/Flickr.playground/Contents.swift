//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

struct FlickrPhoto {
  let photoId: String
  let farm: Int
  let secret: String
  let server: String
  let title: String
  var photoUrl: URL {
    return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg")!
  }
}

let apiKey = "397f6cb2fa4e293b76420bf51bc822fc"
let escapedSearchText = "potato"
let flickrUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedSearchText)&sort=relevance&safe_search=1&per_page=25&format=json&nojsoncallback=1"
let url = URL(string: flickrUrl)!

URLSession.shared.dataTask(with: url) { (data, response, error) in
  if let data = data {
    if let json = try? JSONSerialization.jsonObject(with: data) {
      if let resultsDictionary = json as? [String: Any] {
        guard let photosContainer = resultsDictionary["photos"] as? NSDictionary else { return }
        guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }

        let flickrPhotos: [FlickrPhoto] = photosArray.map { photoDictionary in

          let photoId = photoDictionary["id"] as? String ?? ""
          let farm = photoDictionary["farm"] as? Int ?? 0
          let secret = photoDictionary["secret"] as? String ?? ""
          let server = photoDictionary["server"] as? String ?? ""
          let title = photoDictionary["title"] as? String ?? ""

          let flickrPhoto = FlickrPhoto(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
          return flickrPhoto
        }

        flickrPhotos.map { print( $0.photoUrl) }
      }
    }
  }
  PlaygroundPage.current.finishExecution()
  }.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
