import Foundation


public protocol NetworkService: AnyObject {
    func dataRequest<Response: Decodable>(for endpoint: any Endpoint,
                                          responseType: Response.Type) async throws -> Response
}

public class NetworkClient: NetworkService {
    
    public static let shared = NetworkClient()
    
    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    public func dataRequest<Response: Decodable>(for endpoint: any Endpoint,
                                                 responseType: Response.Type) async throws -> Response {
        throw NetworkError.invalidURL
    }
    
    func validate(_ response: URLResponse, _ data: Data?) throws {
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(statusCode: URLError.badServerResponse.rawValue, payload: data)
        }
        guard httpURLResponse.statusCode == 200 else {
            throw NetworkError.serverError(statusCode: httpURLResponse.statusCode, payload: data)
        }
    }
    
}
