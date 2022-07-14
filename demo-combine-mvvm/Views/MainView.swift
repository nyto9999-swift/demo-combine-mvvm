 import UIKit
import Combine

class MainView: UIViewController {
  
//  
//  let publisher = NewsService()
  var subscription = Set<AnyCancellable>()
  let viewModel = NewsViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let api = NewsAPI()
    print(api.urlComponents)
    
    viewModel.fetchNews()
    
    viewModel.$news.sink { new in
      print(new)
    }.store(in: &subscription)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
//    let sub = publisher.publisher()
//      .receive(on: DispatchQueue.main)
//      .sink(receiveCompletion: {print("completion: \($0)")},
//            receiveValue: {print("values: \($0)")})
//      .store(in: &subscription)
  }


}

