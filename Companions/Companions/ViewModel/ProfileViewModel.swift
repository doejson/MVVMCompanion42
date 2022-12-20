//
//  ProfileViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/17/22.
//

import Foundation

protocol ProfileViewModelProtocol {
	
	func fetchData()
	func helloYandex()
}

class ProfileViewModel {
	var x = Dynamic("")
	
}

extension ProfileViewModel: ProfileViewModelProtocol {
	
	func fetchData() {
		
	}
	
	func helloYandex() {
		
	}
	
	
}
