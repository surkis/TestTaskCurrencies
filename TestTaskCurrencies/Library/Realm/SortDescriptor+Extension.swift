import Foundation
import Realm
import RealmSwift

extension SortDescriptor {
  init(sortDescriptor: NSSortDescriptor) {
    self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
  }
}
