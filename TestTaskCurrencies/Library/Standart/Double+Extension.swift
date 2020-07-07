import Foundation

extension Double {
    
    func getFullPrice(locale: Locale? = nil) -> String? {
        return Formatter.getFullPriceFormatter(locale: locale).string(for: self)
    }
}

extension Formatter {
    
    static func getFullPriceFormatter(locale: Locale? = nil) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.locale = locale ?? Locale.current
        return formatter
    }
}
