//
//  ProfileViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/17/22.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {
	
	func fetchData()
	func checkCampus(email: String) -> String
	var tableViewCount: Int { get }
	var projectInfoData: [ProjectsUsersModel] { get }
	var levelProgress: Float { get }
	var stringLevel: String { get }
	var email: String { get }
	var login: String { get }
	var wallet: String { get }
	var points: String { get }
	var location: String { get }
}

class ProfileViewModel {
	var x = Dynamic("")
	var delegate: ProfileViewControllerProtocol?
	
	var projectInfoData: [ProjectsUsersModel] = []
	private lazy var arrayWithCellData: [ProjectInfoModel] = []
	private lazy var cursusData: [CursusModel] = []
	var levelProgress: Float = 0.0
	var stringLevel: String = ""
	var email: String = ""
	var login: String = ""
	var wallet: String = ""
	var points: String = ""
	var location: String = ""
	
	
	
}

extension ProfileViewModel: ProfileViewModelProtocol {

	
	var tableViewCount: Int {
		projectInfoData.count
	}
	
	func fetchData() {
		NetworkService.shared.loadUser(userName:delegate?.userName) { result in
			switch result {
			case .success(let data):
				print (data)
				self.projectInfoData = (data.projects_users ?? []).sorted {$0.finalMark ?? 0 > $1.finalMark ?? 0}
				self.cursusData = data.cursus_users
				self.email = data.email ?? ""
				self.login = data.login ?? ""
				self.wallet = "wallet: \(data.wallet ?? 0)₳"
				self.points = "evaluation points: \(data.correction_point ?? 0)"
				self.location = self.checkCampus(email: data.email ?? "Moscow")
				guard let level = self.cursusData[1].level else { return }
				self.levelProgress = level.truncatingRemainder(dividingBy: 1)
				self.stringLevel = "\(level) %"
				
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func checkCampus(email: String) -> String {
		let mail = email
		let result = String(mail.split(separator: "@")[1])
		var campusName: String {
			switch result {
			case "student.21-school.ru": return "📍Moscow"
			case "student.42.fr": return "📍Paris"
			case "student.42tokyo.jp": return "📍Tokyo"
			default: return "📍Adelaide"
			}
		}
		return campusName
	}
}
