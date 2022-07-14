import Foundation
import Combine

final class NewsViewModel: ObservableObject {
  
  @Published public var status = ""
  @Published public var news = News(status: "")
  
  private static let decoder = JSONDecoder()
  
  private let newsPublisher: NewsDataPublisher
  
  public init(newsDataPublisher: NewsDataPublisher = NewsAPI()) {
    
    self.newsPublisher = newsDataPublisher
    
  }
  
  public func fetchNews() {

    newsPublisher.publisher()
      .print()
      .retry(1)
      .decode(type: News.self, decoder: Self.decoder)
      .replaceError(with: News.error)
      .receive(on: DispatchQueue.main)
      .assign(to: &$news)
  }
  
}
