import Foundation

struct ApiRateCurrencyModel: Decodable {
    var date: Date
    var value: Double
    var symbol: String
    
    init(date: Date, values: [String: Double]) throws {
        self.date = date
        
        if let value = values.values.first {
            self.value = value
        } else {
            throw ApiError.dataNotParse
        }
        
        if let key = values.keys.first {
            symbol = key
        } else {
            throw ApiError.dataNotParse
        }
    }
    
    init(dictionary: [Date: [String: Double]]) throws {
        if let date = dictionary.keys.first {
            self.date = date
        } else {
            throw ApiError.dataNotParse
        }
        
        if let dicVal = dictionary.values.first, let value = dicVal.first?.value {
            self.value = value
        } else {
            throw ApiError.dataNotParse
        }
        
        if let dicVal = dictionary.values.first, let key = dicVal.first?.key {
            symbol = key
        } else {
            throw ApiError.dataNotParse
        }
    }
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.singleValueContainer()
        let dict = try conteiner.decode(Dictionary<Date, [String: Double]>.self)
        try self.init(dictionary: dict)
    }
}

extension ApiRateCurrencyModel: DomainConvertible {
    
    func asDomain() -> HistoricalRateCurrency {
        return HistoricalRateCurrency(date: date, value: value)
    }
}
