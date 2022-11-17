//
//  ProfileViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/17/22.
//

import Foundation

class ProfileViewModel: NSObject {
	
	private var networkService: NetworkService!
	
	
	override init() {
		super.init()
		self.networkService = NetworkService()
		getData()
	}
	
	func getData() {
		
	}
}
