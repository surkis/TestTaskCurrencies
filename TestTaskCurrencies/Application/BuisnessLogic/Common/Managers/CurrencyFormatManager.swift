import Foundation

protocol CurrencyFormatProtocol {
    func getCurrencyLocale(by code: String) -> Locale?
    func getFormattedPrice(price: Double, currencyCode: String) -> String?
}

class CurrencyFormatManagar: CurrencyFormatProtocol {
    
    func getCurrencyLocale(by code: String) -> Locale? {
        let result = Locale.availableIdentifiers
            .map { Locale(identifier: $0) }
            .first { $0.currencyCode == code }
        return result
    }
    
    func getFormattedPrice(price: Double, currencyCode: String) -> String? {
        let locale = getCurrencyLocale(by: currencyCode)
        return price.getFullPrice(locale: locale)
    }
}
