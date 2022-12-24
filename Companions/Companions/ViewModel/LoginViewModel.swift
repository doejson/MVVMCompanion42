//
//  ViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation
import UIKit
import Network

protocol LoginViewModelProtocol {
	func checkConnection()
	func checktoken()
	func fetch()
	
}

class LoginViewModel: LoginViewModelProtocol {
	var token: String?
	var tokenType: String?
	var tokenStatus: String?
	
	func checktoken() {
		checkConnection()
		NetworkService.shared.checkToken { result in
			switch result {
			case .success(let data):
				DispatchQueue.main.async {
					self.tokenStatus = data.expires_type
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func fetch() {
		checkConnection()
		checktoken()
		if tokenStatus == "weak" || tokenStatus == "expired" || tokenStatus == nil {
			NetworkService.shared.getToken { result in
				switch result {
				case .success(let data):
					UserDefaults.standard.setValue(data.access_token, forKey: "token")
					UserDefaults.standard.setValue(data.token_type, forKey: "tokenType")
					UserDefaults.standard.synchronize()
				case .failure(let error):
					print(error)
				}
			}
		}
	}
	
	func checkConnection() {
		let vc = NoNetworkVC()
		if NetworkService.shared.isNetworkAvailable == true {
			print("connection ok")
		} else {
			print("no connection")
		}
	}
	
	

}
