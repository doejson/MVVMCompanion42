//
//  KeychainService.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 10/12/2022.
//

import Foundation
import Security

//final class KeychainService {
//
//	enum KeyChainError: Error {
//		case storeFailed
//		case loadFailed
//	}
//
//	static let standard = KeychainService()
//
//	private init () {}
//
//	func save(_ data: Data, service: String, account: String) {
//
//		//step 1
//		let query = [kSecValueData: data,
//					kSecClass: kSecClassGenericPassword,
//					kSecAttrService: service,
//					kSecAttrAccount: kSecAttrAccount] as CFDictionary
//
//		let status = SecItemAdd(query, nil)
//		if status != errSecSuccess {
//			print("Error \(status)")
//		}
//
//		//step 2
//		if status == errSecDuplicateItem {
//			// Item already exist, thus update it.
//			let query = [
//				kSecAttrService: service,
//				kSecAttrAccount: account,
//				kSecClass: kSecClassGenericPassword,
//			] as CFDictionary
//
//			let attributesToUpdate = [kSecValueData: data] as CFDictionary
//
//			// Update existing item
//			SecItemUpdate(query, attributesToUpdate)
//		}
//	}
//
//
//	func read(service: String, account: String) -> Data? {
//
//	 let query = [
//		 kSecAttrService: service,
//		 kSecAttrAccount: account,
//		 kSecClass: kSecClassGenericPassword,
//		 kSecReturnData: true
//	 ] as CFDictionary
//
//	 var result: AnyObject?
//	 SecItemCopyMatching(query, &result)
//
//	 return (result as? Data)
// }
//
//
//	func delete(service: String, account: String) {
//
//	 let query = [
//		 kSecAttrService: service,
//		 kSecAttrAccount: account,
//		 kSecClass: kSecClassGenericPassword,
//		 ] as CFDictionary
//
//	 // Delete item from keychain
//	 SecItemDelete(query)
// }
//
//}


