import Foundation

protocol MainPresenter: PresenterProtocol {
    var router: MainViewRouter { get }
}

class MainPresenterImpl: MainPresenter {
    var router: MainViewRouter
    private weak var view: MainView?
    
    init(router: MainViewRouter, view: MainView) {
        self.router = router
        self.view = view
    }
}
