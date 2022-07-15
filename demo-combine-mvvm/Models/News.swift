import Foundation

struct Article: Codable {
  var title: String
}

struct News: Codable {
  var status:String
  var totalResults: Int
  var articles: [Article] = [Article]()
  
   enum NewsCodingKeys: String, CodingKey { //news
    case status, totalResults, articles
  }
   
  static let error = News(status: "error", totalResults: 0)
  
 
  
  public init(status:String = "", totalResults:Int = 0) {
    self.status = status
    self.totalResults = totalResults
    self.articles = [Article]()
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: NewsCodingKeys.self)
    self.status = try container.decode(String.self, forKey: .status)
    self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    self.articles = try container.decode([Article].self, forKey: NewsCodingKeys.articles)
  }
  
  enum DecodeError: Error {
    case fail
  }
}


