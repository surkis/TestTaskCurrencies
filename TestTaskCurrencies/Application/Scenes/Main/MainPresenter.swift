import Foundation

protocol MainPresenter: PresenterProtocol {
    var router: MainViewRouter { get }
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath)
    func didSelectRow(at indexPath: IndexPath)
}

class MainPresenterImpl: MainPresenter {
    var router: MainViewRouter
    private weak var view: MainView?
    private var gateway: LetestCurrrenciesGateway
    private var baseCurrencyCode: String {
        return Constants.Value.baseCurrency
    }
    private var letestCurrencies: LetestCurrencies?
    private var formatManager: CurrencyFormatProtocol
    
    init(router: MainViewRouter,
         view: MainView,
         gateway: LetestCurrrenciesGateway,
         formatManager: CurrencyFormatProtocol) {
        self.router = router
        self.view = view
        self.gateway = gateway
        self.formatManager = formatManager
    }
    
    func needLoadContent() {
        view?.displayPage(title: R.string.localizable.main_page_title())
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        view?.displayLoading(isShow: true)
        gateway.laodLetest(by: baseCurrencyCode) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(item):
                self.letestCurrencies = item
                DispatchQueue.main.async {
                    self.view?.displayLoading(isShow: false)
                    self.view?.displayUpdateContent()
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayLoading(isShow: false)
                    self.view?.displayError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return letestCurrencies?.rates.count ?? 0
    }
    
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath) {
        guard let rates = letestCurrencies?.rates,
            rates.count > indexPath.row else { return }
        
        let item = rates[indexPath.row]
        let value = formatManager.getFormattedPrice(price: item.value, currencyCode: baseCurrencyCode)
        let viewModel = ItemCurrencyModelView(name: item.name, value: value)
        cellView.setup(viewModel: viewModel)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let rates = letestCurrencies?.rates,
            rates.count > indexPath.row else { return }
        let item = rates[indexPath.row]
        router.showDetailRate(currency: item.name)
    }
}
