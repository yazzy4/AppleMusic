//
//  APIClient.swift
//  iTunesSearchAPI
//
//  Created by Yaz Burrell on 11/2/22.
//

import UIKit

extension API {
    
    class Client {
        
        static let shared = Client()
        private let encoder = JSONEncoder()
        private let decoder = JSONDecoder()
        
        func fetch<Request, Response>( _ endpoint: Types.Endpoint,
                    method: Types.Method = .get,
                    body: Request? = nil,
                    then callback:((Result<Response, Types.Error>) -> Void)? = nil
        ) where Request: Encodable, Response: Decodable {
            var urlRequest = URLRequest(url: endpoint.url)
            urlRequest.httpMethod = method.rawValue
            if let body = body {
                do {
                    urlRequest.httpBody = try encoder.encode(body)
                } catch {
                    callback?(.failure(.internal(reason: "Could not encode body")))
                    return
                }
            }
            
            let dataTask = URLSession.shared
                .dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        print("DEBUG: Fetch error: \(error)")
                        callback?(.failure(.generic(reason: "Could not fetch data: \(error.localizedDescription)")))
                    } else {
                        if let data = data {
                            do {
                                let result = try self.decoder.decode(Response.self, from: data)
                                callback?(.success(result))
                            } catch {
                                print("DEBUG: Decoding error: \(error)")
                                callback?(.failure(.generic(reason: "DEBUG: Could not decode data \(error.localizedDescription)")))
                            }
                        }
                    }
                }
            dataTask.resume()
        }
        
        func get<Response>(_ endpoint: Types.Endpoint,
                           then callback:((Result<Response, Types.Error>) -> Void)? = nil)
        where Response: Decodable {
            let body: Types.Request.Empty? = nil
            fetch(endpoint, method: .get, body: body) { result in
                callback?(result)
            }
        }
    }
}
