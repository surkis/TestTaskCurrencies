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

class ApiHistoricalJSONDecoder<ValueType>: ApiDecodable where ValueType: Decodable {

    static func decode(data: Data) throws -> ValueType {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(ValueType.self, from: data)
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
