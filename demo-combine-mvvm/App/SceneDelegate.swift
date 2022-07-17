import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let _ = (scene as? UIWindowScene) else { return }
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "NewsView")
//    
//    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//    window?.windowScene = windowScene
//    window?.makeKeyAndVisible()
//    window?.rootViewController = vc
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    CoreDataStack.save()
  }
  
  private enum CoreDataStack {
    static var viewContext: NSManagedObjectContext = {
      let container = NSPersistentContainer(name: "ChuckNorrisJokes")

      container.loadPersistentStores { _, error in
        guard error == nil else {
          fatalError("\(#file), \(#function), \(error!.localizedDescription)")
        }
      }
      return container.viewContext
    }()

    static func save() {
      guard viewContext.hasChanges else { return }
      do {
        try viewContext.save()
      } catch {
        fatalError("\(#file), \(#function), \(error.localizedDescription)")
      }
    }
  }

  

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }


}

