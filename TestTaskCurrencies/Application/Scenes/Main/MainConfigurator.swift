import Foundation

protocol MainConfigurator: ConfiguratorProtocol {
    func configure(view: MainViewController) -> MainPresenter
}


class MainConfiguratorImpl: MainConfigurator {
    
    func configure(view: MainViewController) -> MainPresenter {
        let router = MainViewRouterImpl(viewController: view)
        
        return MainPresenterImpl(router: router,
                                 view: view)
    }
}
