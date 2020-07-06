import Foundation

protocol MainViewRouter {
    
}

class MainViewRouterImpl: MainViewRouter {
    
    private weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
}
