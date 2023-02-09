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
	var checkConnection: Bool { get set }
	func checktoken()
	func fetch()
	
}

final class LoginViewModel: LoginViewModelProtocol {

	
	var token: String?
	var tokenType: String?
	var tokenStatus: String?
//	let keyChainStore: KeyChainStore
//
//	init(keyChainStore: KeyChainStore) {
//		   self.keyChainStore = keyChainStore
//	   }
	
	
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
					
					//MARK: - UserDefaults
					UserDefaults.standard.setValue(data.access_token, forKey: "token")
					UserDefaults.standard.setValue(data.token_type, forKey: "tokenType")
					UserDefaults.standard.synchronize()
					
					//MARK: - Keychain
					
//					guard let token = data.access_token, let tokenType = data.token_type else { return }
//					self.keyChainStore.setApiKey("access_token", for: token)
//					self.keyChainStore.setApiKey("token_type", for: tokenType)
					
//					KeychainService.standard.save(newData, service: "access_token", account: "Companions42")
//					KeychainService.standard.save(newType, service: "token_type", account: "Companions42")
					
				case .failure(let error):
					print(error)
				}
			}
		}
	}
	
	var checkConnection: Bool {
		get {
			NetworkService.shared.isNetworkAvailable == true ? true : false
		}
		set {
			print("Hi I'm View Model")
		}
	}

}
