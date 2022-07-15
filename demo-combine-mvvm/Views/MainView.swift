 import UIKit
import Combine

class MainView: UIViewController {
//  
//  let publisher = NewsService()
  var subscription = Set<AnyCancellable>()
  let viewModel = NewsViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.fetchNews().sink { completion in
      print(completion)
    } receiveValue: { news in
      print(news)
    }.store(in: &subscription)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }


}

