import UIKit

protocol ApplicationProtocol: AnyObject {
    func initScreen(in window: UIWindow?)
}


class Application: ApplicationProtocol {
    
    weak var window: UIWindow?
    static var shared: Application = Application()
    
    init() {
        
    }
    
    func initScreen(in window: UIWindow?) {
        guard let window = window else { return }
        self.window = window
        let navigation = R.storyboard.navigation.instantiateInitialViewController()
        let mainViewController = MainViewController.make(configure: MainConfiguratorImpl())
        navigation?.setViewControllers([mainViewController], animated: false)
        navigation?.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
    }
}
