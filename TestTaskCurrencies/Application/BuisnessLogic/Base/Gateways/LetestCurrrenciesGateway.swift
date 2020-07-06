import Foundation

protocol LetestCurrrenciesGateway {
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void)
}

class LetestCurrrenciesGatewayImpl: LetestCurrrenciesGateway {
    private var api: ApiLatestCurrencyGateway
    
    init(api: ApiLatestCurrencyGateway) {
        self.api = api
    }
    
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        api.laodLetest(by: baseCurrency, completion: completion)
    }
}
