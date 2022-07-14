import Foundation
import Combine

protocol NewsDataPublisher {
  func publisher() -> AnyPublisher<Data, URLError>
}
