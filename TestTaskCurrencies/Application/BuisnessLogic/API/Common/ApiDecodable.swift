import Foundation

protocol ApiDecodable {
    associatedtype ValueType
    static func decode(data: Data) throws -> ValueType
}

class ApiJSONDecoder<ValueType>: ApiDecodable where ValueType: Decodable {
    
    static func decode(data: Data) throws -> ValueType {
        return try JSONDecoder().decode(ValueType.self, from: data)
    }
}
