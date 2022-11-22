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

struct Token: Codable {
	let token: String?
}

class NetworkService {
	
	static let shared = NetworkService()
	private init() {}
	
	let api = K.api
	let scheme = K.scheme
	let path = K.path
	let uid = K.uid
	let secret = K.secret
	lazy var url = URL(string: scheme + api + path + uid + secret)
	
	
	func createURL() {
		var urlComponents = URLComponents()
		urlComponents.scheme = K.scheme
		urlComponents.host = K.api
		urlComponents.path = K.path
		urlComponents.queryItems = [
			URLQueryItem(name: "UID", value: K.uid),
			URLQueryItem(name: "SECRET", value: K.secret)
		]
		print(urlComponents.url?.absoluteString)
	}
	
	
	
	
	private static func getToken() {
		
		
		
		
	}
	
	
	
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

