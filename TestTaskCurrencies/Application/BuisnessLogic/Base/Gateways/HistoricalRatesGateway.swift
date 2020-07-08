import Foundation

protocol HistoricalRatesGateway {
    func laod(by model: HistoricalRequestModel, completion: @escaping (Result<HistoricalRates, Error>) -> Void)
}

class HistoricalRatesGatewayImpl: HistoricalRatesGateway {
    
    private var api: ApiHistoricalRatesGateway
    
    init(api: ApiHistoricalRatesGateway) {
        self.api = api
    }
    
    func laod(by model: HistoricalRequestModel, completion: @escaping (Result<HistoricalRates, Error>) -> Void) {
        api.laod(by: model, completion: completion)
    }
}
