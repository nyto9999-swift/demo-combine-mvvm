import Foundation
import Combine

public struct NewsClient {
  public init() {}
}

extension NewsClient: NewsClientProtocol {
  
  func publisher() -> AnyPublisher<Data, URLError> {
    let urlComponents = NetworkConfiguration().urlComponents!
    
    return URLSession.shared
      .dataTaskPublisher(for: (urlComponents.url!))
      .print()
      .map( \.data )
      .receive(on: DispatchQueue.global(qos: .background))
      .eraseToAnyPublisher()
  }
  
  func publisherWith(queries: [String : String]) -> AnyPublisher<Data, URLError> {
    let urlComponents = NetworkConfiguration(with: queries).urlComponents!
    
    return URLSession.shared
      .dataTaskPublisher(for: (urlComponents.url!))
      .print()
      .map( \.data )
      .receive(on: DispatchQueue.global(qos: .background))
      .eraseToAnyPublisher()
  }
}
