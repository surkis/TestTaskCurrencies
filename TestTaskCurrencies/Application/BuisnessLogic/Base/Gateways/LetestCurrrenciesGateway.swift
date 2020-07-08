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
        storage.laodLetest(by: baseCurrency) { [weak self] (result) in
            guard let `self` = self else { return }
            if let item = try? result.get() {
                if self.checkIsTimeUpdate(date: item.createdAt) {
                    self.apiLoad(baseCurrency: baseCurrency, completion: completion)
                } else {
                    completion(.success(item))
                }
            } else {
                self.apiLoad(baseCurrency: baseCurrency, completion: completion)
            }
        }
        
      
    }
    
    private func apiLoad(baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        api.laodLetest(by: baseCurrency) { [weak self] (result) in
            guard let `self` = self else { return }
            do {
                let item = try result.get()
                self.update(model: item, completion: completion)
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func checkIsTimeUpdate(date: Date) -> Bool {
        let elapsed = Date().timeIntervalSince(date)
        return elapsed >= Constants.Value.minTimeUpdate
    }
    
    private func update(model: LetestCurrencies, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        storage.updateLetest(model) { [model] (_) in
            completion(.success(model))
        }
    }
}
