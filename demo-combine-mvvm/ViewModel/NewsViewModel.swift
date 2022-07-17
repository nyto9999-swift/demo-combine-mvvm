import Foundation
import Combine

final class NewsViewModel: ObservableObject {
  
  @Published var news = News()
  private static let decoder = JSONDecoder()
  private let newsClient: NewsClientProtocol
  
  public init(newsClient: NewsClientProtocol = NewsClient()) {
    self.newsClient = newsClient
  }
  
  ///MARK: Fetching news
  public func fetchNews() -> AnyPublisher<News, Never> {
    newsClient.publisher()
      .retry(1)
      .decode(type: News.self, decoder: Self.decoder)
      .replaceError(with: News.error)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  public func fetchNews(with queries: [String:String]) -> AnyPublisher<News, Never> {
    
    newsClient.publisherWith(queries: queries)
      .retry(1)
      .decode(type: News.self, decoder: Self.decoder)
      .replaceError(with: News.error)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
