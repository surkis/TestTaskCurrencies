import Foundation

protocol DetailPresenter: PresenterProtocol {
    func getYLineLabel(by value: Double) -> String
    func getXLineLabel(by value: Double) -> String
    func getPointLabel(by value: Double, index: Int) -> String
}

class DetailPresenterImpl: DetailPresenter {
    
    private weak var view: DetailView?
    private var loadGateway: HistoricalRatesGateway
    private var manager: CurrencyFormatProtocol
    private var baseCurrencyCode: String {
        return Constants.Value.baseCurrency
    }
    private var selectCurrency: String
    private var ratesData: HistoricalRates!
    private let dateFormatter: DateFormatter = .dateFormatterYYYYMMdd
    
    init(selectCurrency: String,
         view: DetailView,
         loadGateway: HistoricalRatesGateway,
         manager: CurrencyFormatProtocol) {
        self.selectCurrency = selectCurrency
        self.view = view
        self.loadGateway = loadGateway
        self.manager = manager
    }
    
    func needLoadContent() {
        let text = R.string.localizable.detail_page_title(selectCurrency)
        view?.displayPage(title: text)
        loadContent()
    }
    
    private func loadContent() {
        let endDate = Date()
        let startDate = endDate.getChangeDays(by: Constants.Value.historicalDays)
        let model = HistoricalRequestModel(base: baseCurrencyCode,
                                           startDate: startDate,
                                           endDate: endDate,
                                           symbol: selectCurrency)
        self.view?.displayLoading(isShow: true)
        loadGateway.laod(by: model) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(model):
                self.ratesData = model
                self.presentCharts()
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayLoading(isShow: false)
                    self.view?.displayError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func presentCharts() {
        guard let ratesData = ratesData, !ratesData.rates.isEmpty else {
            presetExchangeMessage()
            return
        }
    
        let datas = ratesData.rates
            .sorted(by: {$0.date<$1.date}).enumerated()
            .map { (index, item) in ItemChartModelView(yValue: item.value, xValue: Double(index))}
        let dates = ratesData.rates.map({$0.date})
        let minDate = dates.min() ?? Date()
        let maxDate = dates.max() ?? Date()
        let model = ChartCurrencyModelView(
            datas: datas,
            label: R.string.localizable.detail_chart_label(selectCurrency,
                                                           dateFormatter.string(from: minDate),
                                                           dateFormatter.string(from: maxDate))
        )
        
        DispatchQueue.main.async {
            self.view?.displayLoading(isShow: false)
            self.view?.displayUpdateContent(model: model)
        }
    }
    
    private func presetExchangeMessage() {
        let model = AlertModelView(title: R.string.localizable.detail_exchange_rate_alert_title(),
                                   message: R.string.localizable.detail_exchange_rate_alert_message(),
                                   style: .alert,
                                   actions: [
            AlertActionModelView(title: R.string.localizable.alert_button_ok(), style: .cancel, completion: { [weak self] in
                self?.view?.closeView()
            })
        ])
        DispatchQueue.main.async {
            self.view?.displayLoading(isShow: false)
            self.view?.displayAlert(model)
        }
    }
    
    func getYLineLabel(by value: Double) -> String {
        return ""
    }
    
    func getXLineLabel(by value: Double) -> String {
        guard let dates = ratesData?.rates.sorted(by: {$0.date<$1.date}) else { return "" }
        let index = Int(value)
        if dates.count > index {
            return DateFormatter.dateFormatterddMMM.string(from: dates[index].date)
        }
        return ""
    }
    
    func getPointLabel(by value: Double, index: Int) -> String {
        guard let rate = ratesData else { return "" }
        return manager.getFormattedPrice(price: value, currencyCode: rate.base) ?? ""
    }
}
