import Foundation

protocol ApiLatestCurrencyGateway {
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void)
}

class ApiLatestCurrencyGatewayImpl: ApiLatestCurrencyGateway {
    
    var apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClientImpl()) {
        self.apiClient = apiClient
    }
    
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        let reuquest = LetestApiRequest(baseCurrency: baseCurrency)
        apiClient.execute(request: reuquest,
                          decoder: ApiJSONDecoder<ApiLetestCurrenciesModel>.self) { (result) in
            switch result {
            case let .success(model):
                completion(.success(model.asDomain()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
