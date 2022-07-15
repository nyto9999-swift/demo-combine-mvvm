import Foundation
import Combine

public struct NewsAPI {
  let urlComponents:URLComponents

  public init(urlQueries: [String:String] = [:]) {
    let apiKey = "402d3a3e2bb44751b9d8b9618c6a6fca"
    var components = URLComponents()
    components.scheme = "https"
    components.host   = "newsapi.org"
    components.path   = "/v2/top-headlines"
    
    urlQueries.isEmpty ?
    components.queryItems = [URLQueryItem(name: "country", value: "us")]:
    components.setQueryItems(with: urlQueries)
    
    components.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
    self.urlComponents = components
  }
}
extension NewsAPI: NewsDataPublisher {
  
  func publisher() -> AnyPublisher<Data, URLError> {
    URLSession.shared
      .dataTaskPublisher(for: urlComponents.url!)
      .print()
      .map( \.data )
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  
}
