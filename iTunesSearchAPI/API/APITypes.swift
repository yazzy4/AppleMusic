//
//  APITypes.swift
//  iTunesSearchAPI
//
//  Created by Yaz Burrell on 11/2/22.
//

import UIKit

extension API {
    
    enum Types {
        
        enum Response {
            
            struct ArtistSearch: Decodable {
                var resultCount: Int
                var results: [Result]
                
                struct Result {
                    var artistID: Int
                    var trackName: String
                    var artworkUrl100: String
                }
            }
        }
        
        enum Request {
            
            struct Empty: Encodable {}
            
        }
        
        enum Error: LocalizedError {
            case generic(reason: String)
            case `internal`(reason: String)
            
            var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "DEBUG: Internal Error: \(reason)"
                }
            }
        }
        
        enum Endpoint {
            case search(query: String)
            case lookup(id: Int)
            
            var url: URL {
                var components = URLComponents()
                components.host = "itunes.apple.com"
                components.scheme = "https"
                switch self {
                case .search(let query):
                    components.path = "/search"
                    components.queryItems = [
                        URLQueryItem(name: "term", value: query),
                        URLQueryItem(name: "media", value: query),
                        URLQueryItem(name: "attribute", value: query)
                    ]
                case .lookup(let id):
                    components.path = "/lookup"
                }
                return components.url!
            }
        }
    }
    
}
