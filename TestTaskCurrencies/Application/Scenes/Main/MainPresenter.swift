import Foundation

protocol MainPresenter: PresenterProtocol {
    var router: MainViewRouter { get }
}

class MainPresenterImpl: MainPresenter {
    var router: MainViewRouter
    private weak var view: MainView?
    private var gateway: LetestCurrrenciesGateway
    
    init(router: MainViewRouter,
         view: MainView,
         gateway: LetestCurrrenciesGateway) {
        self.router = router
        self.view = view
        self.gateway = gateway
    }
    
    
}
