import UIKit
import Combine

class NewsView: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  var subscriptions = Set<AnyCancellable>()
  
  let viewModel = NewsViewModel()
  var news = News() {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
//    viewModel.fetchNews()
//      .receive(on: DispatchQueue.main)
//      .sink { completion in
//      print(completion)
//    } receiveValue: { news in
//      self.news = news
//      self.tableView.reloadData()
//    }.store(in: &subscription)
//    viewModel.fetchNews()
      
    
    viewModel.fetchNews(with: ["q":"apple"])
      .receive(on: DispatchQueue.main)
      .assign(to:\.news, on: self)
      .store(in: &subscriptions)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
}

extension NewsView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.articles.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = news.articles[indexPath.row].title
    content.secondaryText = news.articles[indexPath.row].author
    content.image = UIImage(systemName: "circle")
    cell.contentConfiguration = content
    return cell
  }
  
 
  
  
}



 

