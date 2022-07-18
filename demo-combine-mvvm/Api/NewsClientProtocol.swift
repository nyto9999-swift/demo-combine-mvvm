import Foundation
import Combine

protocol NewsClientProtocol {
  func publishingNews() -> AnyPublisher<News, NewsError>

  func publishingNews(by keywords: [String:String]) -> AnyPublisher<News, NewsError>
}


enum NewsError: Error {
  case decodingFailed
  case other(Error)
}
