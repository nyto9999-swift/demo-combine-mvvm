import Foundation
import Combine

public struct NewsAPI {
  let urlComponents:URLComponents
  
  enum Error: LocalizedError {
    case addressUnreachable(URL)
    case invalidResponse
    
    var errorDescription: String? {
      switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
      }
    }
  }
  public init(querys: [String:String] = [:]) {
    let apiKey = "402d3a3e2bb44751b9d8b9618c6a6fca"
    var components = URLComponents()
    components.scheme = "https"
    components.host   = "newsapi.org"
    components.path   = "/v2/top-headlines"
    
    querys.isEmpty ?
    components.queryItems = [URLQueryItem(name: "country", value: "us")]:
    components.setQueryItems(with: querys)
    
    components.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
    self.urlComponents = components
     
  }
}
extension NewsAPI: NewsDataPublisher {
  
  func publisher() -> AnyPublisher<Data, URLError> {
    URLSession.shared
      .dataTaskPublisher(for: urlComponents.url!)
      .map(\.data)
      .eraseToAnyPublisher()
  }
  
  
}
