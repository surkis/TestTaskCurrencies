import Foundation

struct ApiResponse<Decoder: ApiDecodable> {
    let entity: Decoder.ValueType
    let urlResponse: URLResponse
    let data: Data?
    
    init(data: Data?, urlResponse: URLResponse) throws {
        self.data = data
        self.urlResponse = urlResponse
        guard let data = data else {
            throw ApiError.dataNotFound
        }
        do {
            self.entity = try Decoder.decode(data: data)
        } catch {
            throw ApiParseError(error: error, urlResponse: urlResponse, data: data)
        }
    }
}
