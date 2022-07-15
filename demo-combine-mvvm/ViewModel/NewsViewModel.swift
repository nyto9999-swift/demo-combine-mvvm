import Foundation
import Combine

final class NewsViewModel: ObservableObject {
  
  @Published var news = News()
  private static let decoder = JSONDecoder()
  private let newsPublisher: NewsDataPublisher
  
  public init(newsDataPublisher: NewsDataPublisher = NewsAPI()) {
    self.newsPublisher = newsDataPublisher
  }
  
  public func fetchNews() -> AnyPublisher<News, Never> {
    
    newsPublisher.publisher()
      .retry(1)
      .decode(type: News.self, decoder: Self.decoder)
      .replaceError(with: News.error)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  
  
}
