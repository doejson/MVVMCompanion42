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
	let expires_in_seconds: Int
}

class NetworkService {
	
	static let shared = NetworkService()
	private init() {}
	
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
		//TODO: DI?!
		urlComponents.queryItems = [
			URLQueryItem(name: "grant_type", value: "client_credentials"),
			URLQueryItem(name: "client_id", value: Web.uid),
			URLQueryItem(name: "client_secret", value: Web.secret)
		]
		//TODO: Cringe
		guard let finalURl = urlComponents.url else { return URL(fileURLWithPath:Web.api) }
		print(finalURl)
		return finalURl
	}()
	
	var checkToken: URL? = {
		var url = URLComponents()
		url.scheme = Web.scheme
		url.host = Web.api
		url.path = Web.path + "/info"
		url.queryItems = [
			URLQueryItem(name: "Authorization", value: "Token")
		]
		return url.url
	}()
	
	//TODO: Create User Defaults
	
	
	
	
	func getToken(completion: @escaping (Result<Token, Error>) -> Void) {
		
		let urlSession = URLSession(configuration: .default).dataTask(with: urlToken) { (data,response,error) in

			if let error = error {
				completion(.failure(error))
			}
			
			if let data = data {
				do {
					let decodedData = try JSONDecoder().decode(Token.self, from: data)
					completion(.success(decodedData))
				} catch {
					completion(.failure(error))
				}
			}
		}
		urlSession.resume()
	}

	func checkToken(completion: @escaping () -> Void) {
		
		let urlSession = URLSession(configuration: .default).dataTask(with: checkToken) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
			<#code#>
		}
		
	
	}



func loadUserJson(completion: @escaping (Result<ModelData, Error>) -> Void) {
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

