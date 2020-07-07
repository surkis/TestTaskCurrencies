import Foundation
import RealmSwift

class StorageLetestCurrencies: Object {
    @objc dynamic var base: String = ""
    var rates = List<StorageRateCurrency>()
    @objc dynamic var createdAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "base"
    }
}

extension StorageLetestCurrencies: DomainConvertible {
    
    func asDomain() -> LetestCurrencies {
        return LetestCurrencies(base: base,
                                rates: rates.map({$0.asDomain()}),
                                createdAt: createdAt)
    }
}

extension LetestCurrencies: StorageRepresentable {
    
    var identifier: String {
        return base
    }
    
    
    func asStorageObject() -> StorageLetestCurrencies {
        let item = StorageLetestCurrencies()
        item.base = base
        item.createdAt = createdAt
        let list = List<StorageRateCurrency>()
        list.append(objectsIn: rates.map({$0.asStorageObject()}))
        item.rates = list
        return item
    }
}
