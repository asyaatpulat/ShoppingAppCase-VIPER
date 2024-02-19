//
//  NetworkManager.swift
//
//  Created by Asya Atpulat on 24.10.2023.
//

import Foundation

enum Path {
    case login
    case discoverFirstHorizontalList
    case discoverSecondHorizontalList
    case discoverThirdTwoColumnList
    
    var baseURL: String {
        return ""
    }
    
    var httpMethod: String {
        switch self {
        case .login:
            return "POST"
        default:
            return "GET"
        }
    }
    
    var path: URL {
        switch self {
        case .login:
            return URL(string: "\(baseURL)/login")!
        case .discoverFirstHorizontalList:
            return URL(string: "\(baseURL)/discoverFirstHorizontalList")!
        case .discoverSecondHorizontalList:
            return URL(string: "\(baseURL)/discoverSecondHorizontalList")!
        case .discoverThirdTwoColumnList:
            return URL(string: "\(baseURL)/discoverThirthTwoColumnList")!
        }
    }
}

struct Resource<T: Decodable> {
    var url: Path
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func login(email: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> ()) {
        let resource = Path.login.path
        var request = URLRequest(url: resource)
        request.httpMethod = Path.login.httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginRequest = LoginRequest(email: email, password: password)
        do {
            let requestData = try JSONEncoder().encode(loginRequest)
            request.httpBody = requestData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(TokenResponse.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NSError(domain: "Decode Error", code: 0)))
            }
        }.resume()
    }
    
    func fetch<T: Decodable>(_ endpoint: Path, token: String, completion: @escaping (Result<T, Error>) -> Void) {
        let apiURL = endpoint.path
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data error", code: 0)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure((NSError(domain: "decode error", code: 0))))
            }
        }.resume()
    }
}
