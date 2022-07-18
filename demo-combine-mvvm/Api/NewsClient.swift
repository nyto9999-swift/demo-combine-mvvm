import Foundation
import Combine

public struct NewsClient {
  var config = ApiConfig()
  public init(){}
}

extension NewsClient: NewsClientProtocol {
  
  func publishingNews() -> AnyPublisher<News, NewsError> {
    URLSession.shared
      .dataTaskPublisher(for: config.url())
      .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: News.self, decoder: JSONDecoder())
      .mapError { error -> NewsError in
        switch error {
          case is Swift.DecodingError:
            return .decodingFailed
          default:
            return .other(error)
        }
      }
      .eraseToAnyPublisher()
  }
  
  func publishingNews(by keywords: [String : String]) -> AnyPublisher<News, NewsError> {
    
    URLSession.shared
      .dataTaskPublisher(for: config.url(keywords: keywords))
      .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: News.self, decoder: JSONDecoder())
      .mapError { error -> NewsError in
        switch error {
          case is Swift.DecodingError:
            return .decodingFailed
          default:
            return .other(error)
        }
      }
      .eraseToAnyPublisher()
  }
}



