import Foundation

protocol StorageLetestCurrenciesGateway {
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void)
    func updateLetest(_ model: LetestCurrencies, completion: @escaping (Result<Void, Error>) -> Void)
}

class StorageLetestCurrenciesGatewayImpl: StorageLetestCurrenciesGateway {
    
    private var repository: RealmRepository<LetestCurrencies>
    
    init(repository: RealmRepository<LetestCurrencies> = RealmRepository()) {
        self.repository = repository
    }
    
    func laodLetest(by baseCurrency: String, completion: @escaping (Result<LetestCurrencies, Error>) -> Void) {
        repository.get(by: baseCurrency, completion: completion)
    }
    
    func updateLetest(_ model: LetestCurrencies, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.get(by: model.base) { [weak self] (result) in
            guard let `self` = self else { return }
            if let item = try? result.get() {
                self.repository.delete(entity: item) { (_) in
                    self.update(model, completion: completion)
                }
            } else {
                self.update(model, completion: completion)
            }
        }
    }
    
    private func update(_ model: LetestCurrencies, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.save(entity: model, update: true, completion: completion)
    }
}
