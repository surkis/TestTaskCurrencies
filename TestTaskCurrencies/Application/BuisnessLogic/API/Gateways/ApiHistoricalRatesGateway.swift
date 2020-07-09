import Foundation

protocol ApiHistoricalRatesGateway {
    func laod(by model: HistoricalRequestModel, completion: @escaping (Result<HistoricalRates, Error>) -> Void)
}

class ApiHistoricalRatesGatewayImpl: ApiHistoricalRatesGateway {
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClientImpl()) {
        self.apiClient = apiClient
    }
    
    func laod(by model: HistoricalRequestModel,
              completion: @escaping (Result<HistoricalRates, Error>) -> Void) {
        let reuquest = HistoricalRatesApiRequest(baseCurrency: model.base,
                                                 startDate: model.startDate,
                                                 endDate: model.endDate,
                                                 symbol: model.symbol)
        apiClient.execute(request: reuquest,
                          decoder: ApiJSONDecoder<ApiHistoricalRatesModel>(dateFormatter: .dateFormatterYYYYMMdd)) { (result) in
                            switch result {
                            case let .success(model):
                                completion(.success(model.asDomain()))
                            case let .failure(error):
                                completion(.failure(error))
                            }
        }
    }
}
