import Foundation

protocol DetailPresenter: PresenterProtocol {
    
}

class DetailPresenterImpl: DetailPresenter {
    
    private weak var view: DetailView?
    private var loadGateway: HistoricalRatesGateway
    private var baseCurrencyCode: String {
        return Constants.Value.baseCurrency
    }
    private var selectCurrency: String
    private var ratesData: HistoricalRates!
    
    init(selectCurrency: String, view: DetailView, loadGateway: HistoricalRatesGateway) {
        self.selectCurrency = selectCurrency
        self.view = view
        self.loadGateway = loadGateway
    }
    
    func needLoadContent() {
        loadContent()
    }
    
    private func loadContent() {
        let endDate = Date()
        let startDate = endDate.getChangeDays(by: Constants.Value.historicalDays)
        let model = HistoricalRequestModel(base: baseCurrencyCode,
                                           startDate: startDate,
                                           endDate: endDate,
                                           symbol: selectCurrency)
        loadGateway.laod(by: model) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(model):
                print(model)
                self.ratesData = model
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayError(messsage: error.localizedDescription)
                }
            }
        }
    }
}
