import Foundation

protocol StorageRepresentable {
    associatedtype StorageType: DomainConvertible
    
    var identifier: String { get }
    
    func asStorageObject() -> StorageType
}
