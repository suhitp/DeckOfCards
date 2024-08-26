import Foundation


public protocol NetworkService: AnyObject {
    func dataRequest<Response: Decodable>(for endpoint: any Endpoint,
                                          responseType: Response.Type) async throws -> Response
}

public class NetworkClient: NetworkService {
    
    public static let shared = NetworkClient()
    
    private let session: URLSession
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private init() {
        session = URLSession(configuration: .default)
    }
    
    public func dataRequest<Response: Decodable>(for endpoint: any Endpoint,
                                                 responseType: Response.Type) async throws -> Response {
        let request = try endpoint.makeURLRequest()
        let (data, response) = try await session.data(for: request)
        try validate(response, data)
        do {
            let jsonResponse = try jsonDecoder.decode(responseType.self, from: data)
            return jsonResponse
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch {
            throw NetworkError.unexpectedError(error)
        }
    }
    
    func validate(_ response: URLResponse, _ data: Data) throws {
        guard !data.isEmpty else {
            throw NetworkError.emptyResponseData
        }
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(statusCode: URLError.badServerResponse.rawValue, payload: data)
        }
        guard httpURLResponse.statusCode == 200 else {
            throw NetworkError.serverError(statusCode: httpURLResponse.statusCode, payload: data)
        }
    }
}
