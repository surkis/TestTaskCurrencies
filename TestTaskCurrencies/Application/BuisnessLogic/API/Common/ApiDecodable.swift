import Foundation

protocol ApiDecodable {
    associatedtype ValueType
    func decode(data: Data) throws -> ValueType
}

class ApiJSONDecoder<ValueType>: ApiDecodable where ValueType: Decodable {
    
    private var dateFormatter: DateFormatter?
    
    init(dateFormatter: DateFormatter? = nil) {
        self.dateFormatter = dateFormatter
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        if let formatter = dateFormatter {
            decoder.dateDecodingStrategy = .formatted(formatter)
        }
        return decoder
    }
    
    func decode(data: Data) throws -> ValueType {
        return try decoder.decode(ValueType.self, from: data)
    }
}
