 import Foundation

public class ApiConfig {
  public init(){}
  
  public func url (keywords: [String:String] = [:]) -> URL {
    let apiKey = "402d3a3e2bb44751b9d8b9618c6a6fca"
    var components = URLComponents()
    components.scheme = "https"
    components.host   = "newsapi.org"
    components.path   = "/v2/top-headlines"
    
    keywords.isEmpty ?
    components.queryItems = [URLQueryItem(name: "country", value: "us")]:
    components.setQueryItems(with: keywords)
    
    components.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
    return components.url!
  }
}
