////
////  NetworkService.swift
////  Companions
////
////  Created by Tiana Patti on 11/16/22.
////
//
//import UIKit
//import AuthenticationServices
//
//enum NetworkError: Error {
//	case invalidURL, noData, noToken, decodingError
//}
//
//class NetworkService {
//	
//	static let shared = NetworkService()
//	private init() {}
//	
//	private let UID = "ba4b7e2cd93cfc880949efdb9e952b820cf9eaad89cdb08af9c9c383159e24ac"
//	private let SECRET = "085250fd923886c882dd073dd6efec8e85083013b570042de5532024ac652b62"
//	
//	private let scheme = "https"
//	private let host = "api.intra.42.fr"
//	private let path = "/oauth/token"
//	private let redirectURLHostAllowed = "companion://companion".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//	
//	
//	func postRequestToken(for delegate: UIViewController, complition: @escaping (Result<String, NetworkError>) -> Void) {
//		
//		var components  = URLComponents()
//		components.scheme = "https"
//		components.host = "api.intra.42.fr"
//		components.path = "/oauth/authorize"
//		components.queryItems = [
//				URLQueryItem(name: "client_id", value: UID),
//				URLQueryItem(name: "redirect_uri", value: "companion://companion"),
//				URLQueryItem(name: "response_type", value: "code"),
//				URLQueryItem(name: "scope", value: "public"),
//				URLQueryItem(name: "state", value: "4815162342")
//			]
//		guard let url = components.url else {
//			complition(.failure(.invalidURL))
//			return
//		}
//
//		let webAuthSession = ASWebAuthenticationSession(url: url, callbackURLScheme: redirectURLHostAllowed) { data, error in
//			guard let replyData = data else {
//				complition(.failure(.noData))
//				return
//			}
//			guard let codeItem = replyData.query else {
//				complition(.failure(.decodingError))
//				return
//			}
//			DispatchQueue.main.async {
//				complition(.success(codeItem))
//			}
//			
//		}
//		webAuthSession.presentationContextProvider = (delegate as! ASWebAuthenticationPresentationContextProviding)
//		webAuthSession.start()
//	}
//	
//	
//	func fetchAccessToken(for code: String, complition: @escaping (Result<TokenData, NetworkError>) -> Void) {
//
//		var codeForToken = code.replacingOccurrences(of: "code=", with: "")
//		codeForToken = codeForToken.replacingOccurrences(of: "&state=4815162342", with: "")
//		print("Code: \(codeForToken)")
//		var components  = URLComponents()
//		components.scheme = "https"
//		components.host = "api.intra.42.fr"
//		components.path = "/oauth/token"
//		components.queryItems = [
//			URLQueryItem(name: "grant_type", value: "authorization_code"),
//			URLQueryItem(name: "client_id", value: self.UID),
//			URLQueryItem(name: "client_secret", value: self.SECRET),
//			URLQueryItem(name: "code", value: codeForToken),
//			URLQueryItem(name: "redirect_uri", value: "companion://companion"),
//			URLQueryItem(name: "state", value: "4815162342")
//		]
//		guard let url = components.url else {
//			complition(.failure(.invalidURL))
//			return
//		}
//		
//		var request = URLRequest(url: url)
//		request.httpMethod = "POST"
//		URLSession.shared.dataTask(with: request) { (data, _, error) in
//			guard let data = data else {
//				complition(.failure(.noData))
//				return
//			}
//			
//			do {
//				let tokenData = try JSONDecoder().decode(TokenData.self, from: data)
//				complition(.success(tokenData))
//			} catch {
//				complition(.failure(.noData))
//			}
//			
//		}.resume()
//	}
//	
//	
//	func fetch<T: Decodable>(dataType: T.Type, bearer: String, path: String, complition: @escaping(Result<T, NetworkError>) -> Void) {
//		
//		var components  = URLComponents()
//		components.scheme = "https"
//		components.host = "api.intra.42.fr"
//		components.path = path
//		
//		guard let url = components.url else {
//			complition(.failure(.invalidURL))
//			return
//		}
//		
//		var request = URLRequest(url: url)
//		request.httpMethod = "GET"
//		request.setValue("Bearer " + bearer, forHTTPHeaderField: "Authorization")
//		
//		URLSession.shared.dataTask(with: request) { data, _, error in
//			guard let data = data else {
//				complition(.failure(.noData))
//				return
//			}
//			do {
//				let type = try JSONDecoder().decode(T.self, from: data)
//				DispatchQueue.main.async {
//					complition(.success(type))
//				}
//			} catch {
//				complition(.failure(.noData))
//			}
//		}.resume()
//	}
//	
//	func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
//		guard let url = URL(string: url ?? "") else {
//			completion(.failure(.invalidURL))
//			return
//		}
//		DispatchQueue.global().async {
//			guard let imageData = try? Data(contentsOf: url) else {
//				completion(.failure(.noData))
//				return
//			}
//			DispatchQueue.main.async {
//				completion(.success(imageData))
//			}
//		}
//	}
//	
//}
//
