import Foundation
import Combine

protocol NewsClientProtocol {
  func publisher() -> AnyPublisher<Data, URLError>
  
  func publisherWith(queries: [String:String]) -> AnyPublisher<Data, URLError>
}
