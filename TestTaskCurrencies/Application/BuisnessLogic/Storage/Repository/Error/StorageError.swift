import Foundation

enum StorageError: Error {
    case notFound
}


extension StorageError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return R.string.localizable.errorStorageDataNotFound()
        }
    }
}
