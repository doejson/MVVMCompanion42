//
//  NetworkModel.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 28/11/2022.
//

import Foundation


let userName = UserDefaults.standard.string(forKey: "user")

struct Web {

	static let scheme = "https"
	static let api = "api.intra.42.fr"
	static let path = "/oauth/token/"
	static let userPath = "/v2/users/"
	static let secret = ProcessInfo.processInfo.environment["secret"]
	static let uid = ProcessInfo.processInfo.environment["uid"]
	
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

struct ModelData: Codable {
	let id: Int?
	let email: String?
	let login: String?
	let wallet: Int?
	let correction_point: Int?
	let pool_month: String?
	let pool_year: String?
	let location: String?
	let active: Bool?
}
