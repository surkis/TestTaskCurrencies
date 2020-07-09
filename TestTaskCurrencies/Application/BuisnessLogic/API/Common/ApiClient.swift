import Foundation

protocol ApiClient {
    func execute<Decoder: ApiDecodable>(request: ApiRequest,
                                        decoder: Decoder,
                                        completionHandler: @escaping (_ result: Result<Decoder.ValueType, Error>) -> Void)
}

class ApiClientImpl: ApiClient {
    
    let urlSession: URLSessionProtocol
    
    #if DEBUG
    let isDebugMode = true
    #else
    let isDebugMode = false
    #endif
    private let logName: String = "\n*** [ApiClientImpl] "
    
    init(urlSessionConfiguration: URLSessionConfiguration = .default,
         completionHandlerQueue: OperationQueue = .main) {
        urlSession = URLSession(configuration: urlSessionConfiguration,
                                delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func execute<Decoder: ApiDecodable>(request: ApiRequest,
                                        decoder: Decoder,
                                        completionHandler: @escaping (_ result: Result<Decoder.ValueType, Error>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            
            if self.isDebugMode {
                if let data = data {
                    print("request responce body \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
                    print("=============\n")
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            guard let urlResponse = response else {
                completionHandler(.failure(ApiError.networkRequestError(error)))
                return
            }
            do {
                let apiResponse = try ApiResponse(data: data, urlResponse: urlResponse, decoder: decoder)
                completionHandler(.success(apiResponse.entity))
            } catch {
                completionHandler(.failure(error))
            }
        }
        if isDebugMode {
            print("\(logName) request request \(request.urlRequest.description)")
            debugPrint(request)
        }
        
        dataTask.resume()
    }
}
