import Foundation
import RealmSwift

class StorageRateCurrency: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var value: Double = 0
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

extension StorageRateCurrency: DomainConvertible {
    
    func asDomain() -> RateCurrency {
        return RateCurrency(name: name, value: value)
    }
}

extension RateCurrency: StorageRepresentable {
    
    var identifier: String {
        return name
    }

    func asStorageObject() -> StorageRateCurrency {
        let item = StorageRateCurrency()
        item.name = name
        item.value = value
        return item
    }
}
