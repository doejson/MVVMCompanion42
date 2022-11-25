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
	let access_token: String?
	let token_type: String?
}

struct CheckToken: Codable {
	
	var expires_in_seconds: Int
	
	var expires_type: String {
		switch expires_in_seconds {
		case 3000...7200: return "okay"
		case 1000...3000: return "medium"
		case 50...1000: return "weak"
		default: return "expired"
		}
	}
}

class NetworkService {
	
	static let shared = NetworkService()
	private init() {}
	var token: String?
	var tokenType: String?
	
	let api = Web.api
	let scheme = Web.scheme
	let path = Web.path
	let uid = Web.uid
	let secret = Web.secret
	
	//MARK: - Creating URL's
	var urlToken: URL = {
		var urlComponents = URLComponents()
		urlComponents.scheme = Web.scheme
		urlComponents.host = Web.api
		urlComponents.path = Web.path
		urlComponents.queryItems = [
			URLQueryItem(name: "grant_type", value: "client_credentials"),
			URLQueryItem(name: "client_id", value: Web.uid),
			URLQueryItem(name: "client_secret", value: Web.secret),
		]
		guard let finalURl = urlComponents.url else { return URL(fileURLWithPath:Web.api) }
		return finalURl
	}()
	
	var checkToken: URL = {
		var url = URLComponents()
		url.scheme = Web.scheme
		url.host = Web.api
		url.path = Web.path + "info"
		return url.url ?? URL(string: "")!
	}()
	
	var urlUser: URL = {
		var url = URLComponents()
		url.scheme = Web.scheme
		url.host = Web.api
		url.path = Web.userPath + "tpatti"
		return url.url ?? URL(string: "")!
	}()
	
	//TODO: Create User Defaults
	
	
	
	
	func getToken(completion: @escaping (Result<Token, Error>) -> Void) {
		let urlSession = URLSession(configuration: .default)
		var req = URLRequest(url: urlToken)
		req.httpMethod = "POST"
		let task = urlSession.dataTask(with: req) { (data,response,error) in
			if let error = error {
				completion(.failure(error))
			}
			
			if let data = data {
				do {
					let decodedData = try JSONDecoder().decode(Token.self, from: data)
					completion(.success(decodedData))
					self.token = decodedData.access_token
					self.tokenType = decodedData.token_type
				} catch {
					completion(.failure(error))
				}
			}
		}
		task.resume()
	}
	
	func checkToken(completion: @escaping (Result<CheckToken, Error>) -> Void) {
		let urlSession = URLSession(configuration: .default)
		var req = URLRequest(url: checkToken)
		req.httpMethod = "GET"
		req.addValue(tokenType! + " " + token!, forHTTPHeaderField: "Authorization")
		print("__________debug lvl GOD___________")
		print(req)
		let task = urlSession.dataTask(with: req) { (data,response,error) in
			if let error = error {
				completion(.failure(error))
			}
			if let data = data {
				do {
					let decodedData = try JSONDecoder().decode(CheckToken.self, from: data)
					completion(.success(decodedData))
				} catch {
					completion(.failure(error))
				}
			}
		}
		task.resume()
	}
	
	func loadUser(completion: @escaping (Result<ModelData, Error>) -> Void) {
		let urlSession = URLSession(configuration: .default)
		var req = URLRequest(url: urlUser)
		req.httpMethod = "GET"
		req.addValue(tokenType! + " " + token!, forHTTPHeaderField: "Authorization")
		print("__________debug lvl GOD___________")
		print(req)
		
		let task = urlSession.dataTask(with: req) { (data,response,error) in
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
		task.resume()
	}
}

