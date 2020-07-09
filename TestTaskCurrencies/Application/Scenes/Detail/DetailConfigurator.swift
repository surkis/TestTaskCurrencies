import Foundation

protocol DetailConfigurator {
    func configure(view: DetailViewController) -> DetailPresenter
}

class DetailConfiguratorImpl: DetailConfigurator {
    
    private let selectCurrency: String
    
    init(selectCurrency: String) {
        self.selectCurrency = selectCurrency
    }
    
    func configure(view: DetailViewController) -> DetailPresenter {
        let loadGateway = HistoricalRatesGatewayImpl(api: ApiHistoricalRatesGatewayImpl())
        let manager = CurrencyFormatManagar()
        return DetailPresenterImpl(selectCurrency: selectCurrency,
                                   view: view,
                                   loadGateway: loadGateway,
                                   manager: manager)
    }
}
