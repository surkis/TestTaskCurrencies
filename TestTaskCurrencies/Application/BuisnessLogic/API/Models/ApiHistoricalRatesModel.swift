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
        rates = try values.decode([ApiRateCurrencyModel].self, forKey: .rates)
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
