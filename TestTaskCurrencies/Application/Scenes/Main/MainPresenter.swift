import Foundation

protocol MainPresenter: PresenterProtocol {
    var router: MainViewRouter { get }
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath)
}

class MainPresenterImpl: MainPresenter {
    var router: MainViewRouter
    private weak var view: MainView?
    private var gateway: LetestCurrrenciesGateway
    private var baseCurrencyCode: String {
        return Constants.Value.baseCurrency
    }
    private var letestCurrencies: LetestCurrencies?
    
    init(router: MainViewRouter,
         view: MainView,
         gateway: LetestCurrrenciesGateway) {
        self.router = router
        self.view = view
        self.gateway = gateway
    }
    
    func needLoadContent() {
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        gateway.laodLetest(by: baseCurrencyCode) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(item):
                self.letestCurrencies = item
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayError(messsage: error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return 0
    }
    
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath) {
        
    }
}
