import Foundation

protocol LetestCurrrenciesGateway {
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void)
}

class LetestCurrrenciesGatewayImpl: LetestCurrrenciesGateway {
    private var api: ApiLatestCurrencyGateway
    private var storage: StorageLetestCurrenciesGateway
    
    init(api: ApiLatestCurrencyGateway, storage: StorageLetestCurrenciesGateway) {
        self.api = api
        self.storage = storage
    }
    
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        storage.laodLetest(by: baseCurrency) { (result) in
            if let item = try? result.get() {
//                if checkIsTimeUpdate(date: item.createdAt) {
//                    apiLoad(baseCurrency: baseCurrency) {
//                        
//                    }
//                }
            }
        }
        
      
    }
    
    private func apiLoad(baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
          api.laodLetest(by: baseCurrency, completion: completion)
    }
    
    private func checkIsTimeUpdate(date: Date) -> Bool {
        let diff = Date().timeIntervalSince1970 - date.timeIntervalSince1970
        return diff >= Constants.Value.minTimeUpdate
    }
}
