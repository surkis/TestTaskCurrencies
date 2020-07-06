import Foundation

struct ApiLetestCurrenciesModel: Decodable {
    var base: String
    var rates: [String: Double]
}

extension ApiLetestCurrenciesModel: DomainConvertible {
    
    func asDomain() -> LetestCurrencies {
        return LetestCurrencies(base: base,
                                   rates: rates)
    }
}
