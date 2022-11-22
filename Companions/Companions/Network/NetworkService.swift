//
//  NetworkService.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit
import AuthenticationServices

enum NetworkError: Error {
	case invalidURL, noData, noToken, decodingError
}

class NetworkService {
	
	static let shared = NetworkService()
	private init() {}
	
	private let UID = K.uid
	private let SECRET = K.secret
	
	private let scheme = "https"
	private let host = "api.intra.42.fr"
	private let path = "/oauth/token"
	
	private let url = "https://api.intra.42.fr/v2/me"
	
	
   func loadJson(completion: @escaping (Result<ModelData, Error>) -> Void) {
		if let url = URL(string: path) {
			let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
				if let error = error {
					completion(.failure(error))
				}
				if let data = data {
					do {
						let decodedData = try JSONDecoder().decode(ModelData.self, from: data)
						completion(.success(decodedData))
					} catch {
						completion(.failure(error))
					}
				}
			}
			urlSession.resume()
		}
	}
	
	
}

