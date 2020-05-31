//
//  PokedexAPI.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 29/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

typealias ResultConnection<RequestType> = Result<RequestType, PokedexAPI.NetworkError>

class PokedexAPI {
    
    // MARK: - Enums

    /**
     ## Manages the path component to complete the URL.
     Makes use of associated values for such purpose
     */
    enum Endpoints {
        static let base = "https://pokeapi.co/api/v2"
        static let imagesBase = "https://pokeres.bastionbot.org/images/pokemon"

        case getPokemonList(Int)
        case getPokemon(String)
        case getPokemonLargeImage(String)
        case getPredominantColor(String)
        case getStats(String)
        case getEvolutions(String)
        case getMoves(String)

        var stringURL: String {
            switch self {
            case .getPokemonList(let limit):
                return "\(Endpoints.base)/pokemon?limit=\(limit)"
            case .getPokemon(let id):
                return "\(Endpoints.base)/pokemon/\(id)/"
            case .getPokemonLargeImage(let id):
                return "\(Endpoints.imagesBase)/\(id).png"
            case .getPredominantColor(let id):
                return "\(Endpoints.base)/pokemon-color/\(id)/"
            case .getStats(let id):
                return "\(Endpoints.base)/stat/\(id)/"
            case .getEvolutions(let id):
                return "\(Endpoints.base)/evolution-chain/\(id)/"
            case .getMoves(let id):
                return "\(Endpoints.base)/move/\(id)/"
            }
        }

        var url: URL? { URL(string: stringURL) }
    }

    /// NetworkError
    enum NetworkError: Error {
        case urlNil
        case requestError(String?)
        case internalServerError
        case decodeError(String)
        case unknown
    }

    private enum HTTPStatusCode: Int, Error {
        case ok = 200
        case notFound = 404
        case internalServerError = 500
        case unknown

        init(code: Int) {
            switch code {
            case 200...299: self = .ok
            case 400...499: self = .notFound
            case 500...599: self = .internalServerError
            default: self = .unknown
            }
        }
    }

    // MARK: - Functions
    @discardableResult class func taskForGETRequest<RequestType: Decodable>(in url: URL,
                                                                            response: RequestType.Type,
                                                                            completion: @escaping (ResultConnection<RequestType>) -> Void) -> URLSessionTask {
        let dataTask = URLSession.shared.dataTask(with: url) { data, urlResponse, requestError in

            if let error = requestError {
                callInMainThread {
                    completion(.failure(.requestError(error.localizedDescription)))
                }
                return
            } else {
                guard let data = data else {
                    callInMainThread {
                        completion(.failure(.requestError(nil)))
                    }
                    return
                }
                let statusCode = HTTPStatusCode(code: (urlResponse as? HTTPURLResponse)?.statusCode ?? 0)
                switch statusCode {
                case .ok:
                    let decoder = JSONDecoder()
                    do {
                        let responseDecoded = try decoder.decode(RequestType.self, from: data)
                        callInMainThread {
                            completion(.success(responseDecoded))
                        }
                    } catch (let error) {
                        callInMainThread {
                            completion(.failure(.decodeError(error.localizedDescription)))
                        }
                    }
                case .notFound:
                    callInMainThread {
                        completion(.failure(.requestError(nil)))
                    }
                case .internalServerError:
                    callInMainThread {
                        completion(.failure(.internalServerError))
                    }
                case .unknown:
                    callInMainThread {
                        completion(.failure(.unknown))
                    }
                }
            }
        }
        dataTask.resume()
        return dataTask
    }

    private class func callInMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
