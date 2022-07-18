import Foundation
import Combine

final class NewsViewModel: ObservableObject {
  
  @Published var news = News()
  private static let decoder = JSONDecoder()
  private let newsClient:NewsClientProtocol
  
  public init(newsClient: NewsClientProtocol = NewsClient()){
    self.newsClient = newsClient
  }
}

///MARK: News Publishers
extension NewsViewModel {
  
  func publishNews() -> AnyPublisher<News, NewsError> {
    newsClient.publishingNews()
  }
  func publishNews(by keywords: [String:String]) -> AnyPublisher<News, NewsError> {
    newsClient.publishingNews(by: keywords)
  }
}
