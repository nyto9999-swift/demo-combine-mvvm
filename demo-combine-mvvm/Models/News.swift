import Foundation

struct News: Codable {
  
  var status:String
  
  enum CodingKeys: String, CodingKey {
    case status
  }



  static let error = News(status: "error")

  public init(status: String) {
    self.status = status
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.status = try container.decode(String.self, forKey: .status)

  }
}

