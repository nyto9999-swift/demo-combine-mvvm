import UIKit
import Combine

class NewsView: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  
  var subscriptions = Set<AnyCancellable>()
  let viewModel = NewsViewModel()
  var news = News()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //default
//    viewModel.publishNews()
//      .receive(on: DispatchQueue.main)
//      .sink(
//        receiveCompletion: {
//          print("completion: \($0)")
//          self.tableView.reloadData()
//        }, receiveValue: {
//          self.news = $0
//        })
//      .store(in: &subscriptions)
    
    //keywords
    viewModel.publishNews(by: ["q": "trump"])
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {
          print("completion: \($0)")
          self.tableView.reloadData()
        }, receiveValue: {
          self.news = $0
        })
      .store(in: &subscriptions)  
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





