//
//  NetworkService.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit
import AuthenticationServices
import Network

enum NetworkError: Error {
	case invalidURL, noData, noToken, decodingError
}

final class NetworkService: APIService {

	static let shared: APIService = NetworkService()
	private init() {}
	
	var connection: NWPathMonitor?
	
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
	
	private var checkToken: URL = {
		var url = URLComponents()
		url.scheme = Web.scheme
		url.host = Web.api
		url.path = Web.path + "info"
		guard let finalURl = url.url else { return URL(fileURLWithPath:Web.api) }
		return finalURl
	}()
	
	private var urlUser: URL = {
		var url = URLComponents()
		url.scheme = Web.scheme
		url.host = Web.api
		url.path = Web.userPath
		guard let finalURl = url.url else { return URL(fileURLWithPath:Web.api) }
		return finalURl
	}()
	
	//TODO: Create User Defaults
	
	func getToken(completion: @escaping (Result<Token, Error>) -> Void) {
		
		let urlSession = URLSession(configuration: .default)
		var req = URLRequest(url: urlToken)
		req.httpMethod = "POST"
		
		DispatchQueue.global(qos: .utility).async {
			
			let task = urlSession.dataTask(with: req) { (data,response,error) in
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
			task.resume()
		}
	}
	
	func checkToken(completion: @escaping (Result<CheckToken, Error>) -> Void) {
		
		guard let token = UserDefaults.standard.string(forKey: "token") else { return }
		guard let tokenType = UserDefaults.standard.string(forKey: "tokenType") else { return }
		
		let urlSession = URLSession(configuration: .default)
		var req = URLRequest(url: checkToken)
		req.httpMethod = "GET"
		req.addValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")
		
		DispatchQueue.global(qos: .utility).async {
			
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
	}
	
	func loadUser(userName: String?, completion: @escaping (Result<ModelData, Error>) -> Void) {
		
		guard let token = UserDefaults.standard.string(forKey: "token") else { return }
		guard let tokenType = UserDefaults.standard.string(forKey: "tokenType") else { return }
		let urlSession = URLSession(configuration: .default)
		let urlUser = urlUser.appendingPathComponent(userName ?? "")
		var req = URLRequest(url: urlUser)
		req.httpMethod = "GET"
		req.addValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")

		let task = urlSession.dataTask(with: req) { (data,response,error) in
			if let error = error {
				completion(.failure(error))
			}
			if let data = data {
				do {
					let decodedData = try JSONDecoder().decode(ModelData.self, from: data)
					completion(.success(decodedData))
				} catch {
					print(req)
					completion(.failure(error))
				}
			}
		}
		task.resume()
	}
	
	
	var isNetworkAvailable: Bool {
		get {
			if connection?.currentPath.status == .requiresConnection {
				print ("no connection")
				return false
				
			} else {
				print ("okay")
				return true
				
			}
		}
	}
	
	func testAsyncLoadUserPhoto(userName: String?, urlUser: URL?) async throws -> UIImage {
		
		guard let url = urlUser?.appendingPathComponent(userName ?? "") else {
			return UIImage()
		}
		
		let (data,response) = try await URLSession.shared.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse,
			  httpResponse.statusCode == 200 else {
			throw NetworkError.invalidURL
		}
		
		guard let image = UIImage(data: data) else {
			throw NetworkError.noData
		}
		return image
	}
}
