import Foundation

protocol StorageRepositoryProtocol {
    associatedtype ObjectType
    
    func get(by identifire: String, completion: @escaping (Result<ObjectType, Error>) -> Void)
    func getAll(complation: @escaping  (Result<[ObjectType], Error>) -> Void)
    func get(predicate: NSPredicate, sort: [NSSortDescriptor],
             complation: @escaping (Result<[ObjectType], Error>) -> Void)
    func save(entity: ObjectType, update: Bool,
              completion: @escaping (Result<Void, Error>) -> Void)
    func save<S: Sequence>(entities: S, update: Bool,
                           completion: @escaping (Result<Void, Error>) -> Void) where S.Element == ObjectType
    func delete(entity: ObjectType, completion: @escaping (Result<Void, Error>) -> Void)
    func delete<S: Sequence>(entities: S,
                             completion: @escaping (Result<Void, Error>) -> Void) where S.Element == ObjectType
}
