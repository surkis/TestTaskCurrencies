import Foundation

struct LetestApiRequest: ApiRequest {
    private var baseCurrency: String
    
    init(baseCurrency: String) {
        self.baseCurrency = baseCurrency
    }
    
    var urlRequest: URLRequest {
        let url = Constants.API.baseURL.appendingPathComponent("latest")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "base", value: baseCurrency)
        ]
        var request = URLRequest(url: components.url!)
        
        request.httpMethod = "GET"
        
        return request
    }
}
