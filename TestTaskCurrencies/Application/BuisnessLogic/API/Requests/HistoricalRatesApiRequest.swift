import Foundation

struct HistoricalRatesApiRequest: ApiRequest {
    private var baseCurrency: String
    private var startDate: Date
    private var endDate: Date
    private var symbol: String
    
    init(baseCurrency: String, startDate: Date, endDate: Date, symbol: String) {
        self.baseCurrency = baseCurrency
        self.startDate = startDate
        self.endDate = endDate
        self.symbol = symbol
    }
    
    var urlRequest: URLRequest {
        let url = Constants.API.baseURL.appendingPathComponent("history")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        components.queryItems = [
            URLQueryItem(name: "base", value: baseCurrency),
            URLQueryItem(name: "start_at", value: dateFormatter.string(from: startDate)),
            URLQueryItem(name: "end_at", value: dateFormatter.string(from: endDate)),
            URLQueryItem(name: "symbols", value: symbol)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
