import Foundation

struct ApiLetestCurrenciesModel: Decodable {
    var base: String
    var rates: [String: Double]
}

extension ApiLetestCurrenciesModel: DomainConvertible {
    
    func asDomain() -> LetestCurrencies {
        let rateItems = rates.compactMap({(key,value) in return RateCurrency(name: key, value: value)})
        return LetestCurrencies(base: base,
                                rates: rateItems)
    }
}
