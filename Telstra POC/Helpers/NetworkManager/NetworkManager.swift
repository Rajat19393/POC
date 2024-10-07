//
//  NetworkManager.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidData
}

class NetworkManager {
    /// A shared instance of the 'Network Manager that is initialized with a shared URLSession* .
    static let shared = NetworkManager ()
    private var session : URLSession!
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    typealias completionClosure = ((MyTableModel?, Error?) -> Void)
    
    public func fetchFacts(completion: completionClosure?) {
        let request = createFactsRequest()
        executeRequest(request: request, completion: completion)
    }
    
    private func createFactsRequest() -> URLRequest {
        let url = EndPoints.facts.url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            do {
//                Data recieved from this JSON is as per isoLatin1 encoding
                let factsData = try self.decodeJSON(data: data, encoding: .isoLatin1, type: T.self)
                completion?(factsData, nil)
            } catch {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}


extension NetworkManager {
    //    This method is used to Parse the data to the required Object , if encoding of data is not as per utf-8, then we need to send the parameter encoding.
    //    default value of encoding is seta as utf-8
    private func decodeJSON<DataType: Decodable>(data: Data, encoding: String.Encoding = .utf8, type: DataType.Type) throws -> DataType? {
        //        first we decode our data as string from encoding type used to encode it
        if let stringData = String(data: data, encoding: encoding) {
            //            Then we encode our string to utf-8 data
            if let jsonData = stringData.data(using: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let decodedObject = try decoder.decode(DataType.self, from: jsonData)
                    return decodedObject
                } catch {
                    throw NetworkError.invalidData
                }
            }
        }
        return nil
    }
}
