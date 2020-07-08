import Foundation
import Realm
import RealmSwift

private var isShowFile: Bool = false

// MARK: swiftlint:disable force_try
class RealmRepository<ObjectType: StorageRepresentable>: RealmDefaultConfigProtocol, StorageRepositoryProtocol
where ObjectType == ObjectType.StorageType.DomainType, ObjectType.StorageType: Object {
    
    private let configuration: Realm.Configuration
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration = defaultConfiguration) {
        self.configuration = configuration
        #if DEBUG
        if !isShowFile {
            isShowFile = true
            let url = configuration.fileURL?.absoluteString ?? ""
            print("Realm file 📁 url: \(url)")
            if let key = configuration.encryptionKey, let ketStr = String(bytes: key, encoding: .utf8) {
               print("Configuration key: ", ketStr)
            }
        }
        #endif
    }
    
    func get(by identifire: String, completion: @escaping (Result<ObjectType, Error>) -> Void) {
        if let object = realm.object(ofType: ObjectType.StorageType.self, forPrimaryKey: identifire) {
            completion(.success(object.asDomain()))
            return
        }
        completion(.failure(StorageError.notFound))
    }
    
    func getAll(complation: @escaping (Result<[ObjectType], Error>) -> Void) {
        let objects = realm.objects(ObjectType.StorageType.self)
        complation(.success(objects.map({$0.asDomain()})))
    }
    
    func get(predicate: NSPredicate, sort: [NSSortDescriptor], complation: @escaping (Result<[ObjectType], Error>) -> Void) {
        let objects = realm.objects(ObjectType.StorageType.self)
            .filter(predicate)
            .sorted(by: sort.map(SortDescriptor.init))
        complation(.success(objects.map({$0.asDomain()})))
    }
    
    func save(entity: ObjectType, update: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(entity.asStorageObject(), update: update ? .modified : .all)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func save<S>(entities: S, update: Bool, completion: @escaping (Result<Void, Error>) -> Void)
        where S: Sequence, ObjectType == S.Element {
            do {
                try realm.write {
                    realm.add(entities.map({$0.asStorageObject()}), update: update ? .modified : .all)
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
    }
    
    func delete(entity: ObjectType, completion: @escaping (Result<Void, Error>) -> Void) {
        if let object = realm.object(ofType: ObjectType.StorageType.self,
                                     forPrimaryKey: entity.identifier) {
            do {
                try realm.write {
                    realm.delete(object)
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(StorageError.notFound))
        }
    }
    
    func delete<S>(entities: S, completion: @escaping (Result<Void, Error>) -> Void)
        where S: Sequence, ObjectType == S.Element {
            do {
                try realm.write {
                    realm.delete(entities.map({$0.asStorageObject()}))
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
    }
}
