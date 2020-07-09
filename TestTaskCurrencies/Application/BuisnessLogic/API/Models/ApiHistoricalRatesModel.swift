import Foundation

struct ApiHistoricalRatesModel: Decodable {
    var base: String
    var startDate: Date
    var endDate: Date
    var rates: [ApiRateCurrencyModel]
    
    enum CodingKeys: String, CodingKey {
        case base
        case startDate = "start_at"
        case endDate = "end_at"
        case rates = "rates"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        base = try values.decode(String.self, forKey: .base)
        startDate = try values.decode(Date.self, forKey: .startDate)
        endDate = try values.decode(Date.self, forKey: .endDate)
        let ratesDic = try values.decode([String: [String: Double]].self, forKey: .rates)
        
        let formatter = DateFormatter.dateFormatterYYYYMMdd
        rates = try ratesDic.compactMap({ (key, values) in
            if let date = formatter.date(from: key) {
                return try ApiRateCurrencyModel(date: date, values: values)
            }
            return nil
        })
    }
}

extension ApiHistoricalRatesModel: DomainConvertible {
    
    func asDomain() -> HistoricalRates {
        return HistoricalRates(base: base,
                               startDate: startDate,
                               endDate: endDate,
                               rates: rates.map({$0.asDomain()}))
    }
}
