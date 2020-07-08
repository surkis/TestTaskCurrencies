import Foundation

struct HistoricalRates {
    var base: String
    var startDate: Date
    var endDate: Date
    var rates: [HistoricalRateCurrency]
}

struct HistoricalRateCurrency {
    var date: Date
    var value: Double
}
