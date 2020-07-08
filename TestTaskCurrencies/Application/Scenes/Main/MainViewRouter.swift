import Foundation

protocol MainViewRouter {
    func showDetailRate(currency: String)
}

class MainViewRouterImpl: MainViewRouter {
    
    private weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showDetailRate(currency: String) {
        let configure = DetailConfiguratorImpl(selectCurrency: currency)
        let vc = DetailViewController.make(configure: configure)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
