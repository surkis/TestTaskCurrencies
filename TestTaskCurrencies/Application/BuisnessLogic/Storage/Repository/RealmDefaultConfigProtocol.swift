import Foundation
import Realm
import RealmSwift


protocol RealmDefaultConfigProtocol {
    static var defaultConfiguration: Realm.Configuration { get }
}

extension RealmDefaultConfigProtocol {
    static var defaultConfiguration: Realm.Configuration {
        var config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { (migration, oldSchemaVersion) in
        })
        
        config.fileURL = URL(fileURLWithPath: RLMRealmPathForFile("\(Constants.Value.appName).realm"))
        return config
    }
}
