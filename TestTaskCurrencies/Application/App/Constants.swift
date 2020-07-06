import Foundation

struct Constants {
    
    enum API {
        static var baseURL: URL = URL(string: "https://api.exchangeratesapi.io/")!
    }
    
    enum Value {
        static var baseCurrency: String = "USD"
    }
}
