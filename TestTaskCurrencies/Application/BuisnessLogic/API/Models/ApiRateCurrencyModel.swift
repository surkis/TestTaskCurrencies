import Foundation

struct ApiRateCurrencyModel: Decodable {
    var date: Date
    var value: Double
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.singleValueContainer()
        let dict = try conteiner.decode(Dictionary<Date, [String: Double]>.self)
        if let date = dict.keys.first {
            self.date = date
        } else {
            throw ApiError.dataNotParse
        }
        
        if let dicVal = dict.values.first, let value = dicVal.first?.value {
            self.value = value
        } else {
            throw ApiError.dataNotParse
        }
    }
}

extension ApiRateCurrencyModel: DomainConvertible {
    
    func asDomain() -> HistoricalRateCurrency {
        return HistoricalRateCurrency(date: date, value: value)
    }
}
