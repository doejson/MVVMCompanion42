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
	
	var isNetworkAvilaliable: Bool { get set }
	var isUserAlreadyLogIn: Bool { get set }
	
}

class LoginViewModel: NSObject {
	
	var token: String?
	var tokenType: String?
	var tokenStatus: String?
	var connection: NWPathMonitor?
	
	func checktoken() {
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

}

extension LoginViewModel: LoginViewModelProtocol {

	var isNetworkAvilaliable: Bool {
		get {
			if connection?.currentPath.status == .requiresConnection {
				return true
				print ("okay")
			} else {
				return false
				print ("no connection")
			}
		}
		set {
			<#code#>
		}
	}
	
	var isUserAlreadyLogIn: Bool {
		get {
			<#code#>
		}
		set {
			<#code#>
		}
	}
	
	
}
