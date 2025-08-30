//
//  ViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//
import UIKit
import Network

protocol LoginViewModelProtocol {

//	var isUserAlreadyLogIn: Bool { get set }
	var checkConnection: Bool { get }
	var onUpdate: (() -> Void)? { get set }
	func checktoken()
	func fetch()
}

final class LoginViewModel: LoginViewModelProtocol {
	
	var onUpdate: (() -> Void)?
	
	var token: String?
	var tokenType: String?
	var tokenStatus: String?
	
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
					self.onUpdate?()
				case .failure(let error):
					print(error)
				}
			}
		}
	}
	
	var checkConnection: Bool = NetworkService.shared.isNetworkAvailable

}
