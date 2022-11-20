//
//  IntraModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation

//MARK: - Constants
struct K {
	
	static let appName = "Companions42"
	static let error = "Error"
	static let loginButtonTitle = "Log In 💖"
}
//
////MARK: - Users
//
//struct TokenData: Codable {
//	let accessToken: String?
//	
//	var accessTokenString: String {
//		let result = accessToken ?? ""
//		return result
//	}
//	
//	private enum CodingKeys: String, CodingKey {
//		case accessToken = "access_token"
//	}
//}
//
//
//struct User: Codable {
//	let id: Int?
//	let email, login, firstName, lastName: String?
//	let usualFullName: String?
//	let usualFirstName: String?
//	let url: String?
//	let phone, displayname: String?
//	let imageURL: String?
//	let image: Image?
//	let newImageURL: String?
//	let staff: Bool?
//	let correctionPoint: Int?
//	let poolMonth, poolYear: String?
//	let wallet: Int?
//	let anonymizeDate, dataErasureDate, createdAt, updatedAt: String?
//	let alumnizedAt: String?
//	let alumni: Bool?
//	let cursusUsers: [CursusUser]?
//	let projectsUsers: [ProjectsUser]?
//	let languagesUsers: [LanguagesUser]?
//	let achievements: [Achievement]?
//	let titles: [Title]?
//	let titlesUsers: [TitlesUser]?
//	let campus: [Campus]?
//	let campusUsers: [CampusUser]?
//
//	enum CodingKeys: String, CodingKey {
//		case id, email, login
//		case firstName = "first_name"
//		case lastName = "last_name"
//		case usualFullName = "usual_full_name"
//		case usualFirstName = "usual_first_name"
//		case url, phone, displayname
//		case imageURL = "image_url"
//		case image
//		case newImageURL = "new_image_url"
//		case staff = "staff?"
//		case correctionPoint = "correction_point"
//		case poolMonth = "pool_month"
//		case poolYear = "pool_year"
//		case wallet
//		case anonymizeDate = "anonymize_date"
//		case dataErasureDate = "data_erasure_date"
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//		case alumnizedAt = "alumnized_at"
//		case alumni = "alumni?"
//		case cursusUsers = "cursus_users"
//		case projectsUsers = "projects_users"
//		case languagesUsers = "languages_users"
//		case achievements, titles
//		case titlesUsers = "titles_users"
//		case campus
//		case campusUsers = "campus_users"
//	}
//}
//
//struct Achievement: Codable {
//	let id: Int?
//	let name, achievementDescription: String?
//	let tier: Tier?
//	let kind: Kind?
//	let visible: Bool?
//	let image: String?
//	let nbrOfSuccess: Int?
//	let usersURL: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id, name
//		case achievementDescription = "description"
//		case tier, kind, visible, image
//		case nbrOfSuccess = "nbr_of_success"
//		case usersURL = "users_url"
//	}
//}
//
//enum Kind: String, Codable {
//	case pedagogy = "pedagogy"
//	case project = "project"
//	case scolarity = "scolarity"
//	case social = "social"
//}
//
//enum Tier: String, Codable {
//	case challenge = "challenge"
//	case easy = "easy"
//	case hard = "hard"
//	case medium = "medium"
//	case none = "none"
//}
//
//// MARK: - Campus
//struct Campus: Codable {
//	let id: Int?
//	let name, timeZone: String?
//	let language: Language?
//	let usersCount, vogsphereID: Int?
//	let country, address, zip, city: String?
//	let website: String?
//	let facebook, twitter: String?
//	let active, campusPublic: Bool?
//	let emailExtension: String?
//	let defaultHiddenPhone: Bool?
//
//	enum CodingKeys: String, CodingKey {
//		case id, name
//		case timeZone = "time_zone"
//		case language
//		case usersCount = "users_count"
//		case vogsphereID = "vogsphere_id"
//		case country, address, zip, city, website, facebook, twitter, active
//		case campusPublic = "public"
//		case emailExtension = "email_extension"
//		case defaultHiddenPhone = "default_hidden_phone"
//	}
//}
//
//// MARK: - Language
//struct Language: Codable {
//	let id: Int?
//	let name, identifier, createdAt, updatedAt: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id, name, identifier
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//	}
//}
//
//// MARK: - CampusUser
//struct CampusUser: Codable {
//	let id, userID, campusID: Int?
//	let isPrimary: Bool?
//	let createdAt, updatedAt: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case userID = "user_id"
//		case campusID = "campus_id"
//		case isPrimary = "is_primary"
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//	}
//}
//
//// MARK: - CursusUser
//struct CursusUser: Codable {
//	let grade: String?
//	let level: Double?
//	let skills: [Skill]?
//	let blackholedAt: String?
//	let id: Int?
//	let beginAt: String?
//	let endAt: String?
//	let cursusID: Int?
//	let hasCoalition: Bool?
//	let createdAt, updatedAt: String?
//	let user: UserClass?
//	let cursus: Cursus?
//
//	enum CodingKeys: String, CodingKey {
//		case grade, level, skills
//		case blackholedAt = "blackholed_at"
//		case id
//		case beginAt = "begin_at"
//		case endAt = "end_at"
//		case cursusID = "cursus_id"
//		case hasCoalition = "has_coalition"
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//		case user, cursus
//	}
//}
//
//// MARK: - Cursus
//struct Cursus: Codable {
//	let id: Int?
//	let createdAt, name, slug, kind: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case createdAt = "created_at"
//		case name, slug, kind
//	}
//}
//
//// MARK: - Skill
//struct Skill: Codable {
//	let id: Int?
//	let name: String?
//	let level: Double?
//}
//
//// MARK: - UserClass
//struct UserClass: Codable {
//	let id: Int?
//	let email, login, firstName, lastName: String?
//	let usualFullName: String?
//	let usualFirstName: String?
//	let url: String?
//	let phone, displayname: String?
//	let imageURL: String?
//	let image: Image?
//	let newImageURL: String?
//	let staff: Bool?
//	let correctionPoint: Int?
//	let poolMonth, poolYear: String?
//	let wallet: Int?
//	let anonymizeDate, dataErasureDate, createdAt, updatedAt: String?
//	let alumnizedAt: String?
//	let alumni: Bool?
//
//	enum CodingKeys: String, CodingKey {
//		case id, email, login
//		case firstName = "first_name"
//		case lastName = "last_name"
//		case usualFullName = "usual_full_name"
//		case usualFirstName = "usual_first_name"
//		case url, phone, displayname
//		case imageURL = "image_url"
//		case image
//		case newImageURL = "new_image_url"
//		case staff = "staff?"
//		case correctionPoint = "correction_point"
//		case poolMonth = "pool_month"
//		case poolYear = "pool_year"
//		case wallet
//		case anonymizeDate = "anonymize_date"
//		case dataErasureDate = "data_erasure_date"
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//		case alumnizedAt = "alumnized_at"
//		case alumni = "alumni?"
//	}
//}
//
//// MARK: - Image
//struct Image: Codable {
//	let link: String?
//	let versions: Versions?
//}
//
//// MARK: - Versions
//struct Versions: Codable {
//	let large, medium, small, micro: String?
//}
//
//// MARK: - LanguagesUser
//struct LanguagesUser: Codable {
//	let id, languageID, userID, position: Int?
//	let createdAt: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case languageID = "language_id"
//		case userID = "user_id"
//		case position
//		case createdAt = "created_at"
//	}
//}
//
//// MARK: - ProjectsUser
//struct ProjectsUser: Codable {
//	let id, occurrence: Int?
//	let finalMark: Int?
//	let status: String?
//	let validated: Bool?
//	let currentTeamID: Int?
//	let project: Project?
//	let cursusIDS: [Int]?
//	let markedAt: String?
//	let marked: Bool?
//	let retriableAt: String?
//	let createdAt, updatedAt: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id, occurrence
//		case finalMark = "final_mark"
//		case status
//		case validated = "validated?"
//		case currentTeamID = "current_team_id"
//		case project
//		case cursusIDS = "cursus_ids"
//		case markedAt = "marked_at"
//		case marked
//		case retriableAt = "retriable_at"
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//	}
//}
//
//// MARK: - Project
//struct Project: Codable {
//	let id: Int?
//	let name, slug: String?
//	let parentID: Int?
//
//	enum CodingKeys: String, CodingKey {
//		case id, name, slug
//		case parentID = "parent_id"
//	}
//}
//
//
//// MARK: - Title
//struct Title: Codable {
//	let id: Int?
//	let name: String?
//}
//
//// MARK: - TitlesUser
//struct TitlesUser: Codable {
//	let id, userID, titleID: Int?
//	let selected: Bool?
//	let createdAt, updatedAt: String?
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case userID = "user_id"
//		case titleID = "title_id"
//		case selected
//		case createdAt = "created_at"
//		case updatedAt = "updated_at"
//	}
//}
//
//
//
//
//
