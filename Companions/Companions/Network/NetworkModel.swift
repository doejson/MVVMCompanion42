//
//  NetworkModel.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 28/11/2022.
//

import Foundation

//MARK: UserDefaults
let userName = UserDefaults.standard.string(forKey: "user")

//MARK: Keychain
//let keyChainService = KeyChainManager()
//let userName = keyChainService.getApiKey(for: "user")

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
		case 1000...7200: return "okay"
		case 200...1000: return "medium"
		case 0...200: return "weak"
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
	let cursus_users: [CursusModel]
	let projects_users: [ProjectsUsersModel]?
}

struct ProjectsUsersModel: Codable {
	let id, occurrence: Int?
	let finalMark: Int?
	let status: String?
	let validated: Bool?
	let currentTeamID: Int?
	let project: ProjectInfoModel?
	let cursusIDS: [Int]?
	let markedAt: String?
	
	enum CodingKeys: String, CodingKey {
		case id, occurrence
		case finalMark = "final_mark"
		case status
		case validated = "validated?"
		case currentTeamID = "current_team_id"
		case project
		case cursusIDS = "cursus_ids"
		case markedAt = "marked_at"
		
	}
}

struct ProjectInfoModel: Codable {
	let id: Int?
	let name: String?
	let slug: String?
	let parentID: Int?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case slug
		case parentID = "parent_id"
	}
}

struct CursusModel: Codable {
	let grade: String?
	let level: Float?
	let cursus: CursusType?
}

struct CursusType: Codable {
	let name: String?
}
