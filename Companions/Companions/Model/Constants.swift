//
//  Constants.swift
//  Companions
//
//  Created by Tiana Patti on 11/22/22.
//

import Foundation

//MARK: - Constants
struct K {
	
	static let appName = "Companions42"
	static let error = "Error"
	static let loginButtonTitle = "Log In 💖"
	static let reuseIdentifier = "Cell"
}

struct Web {
	
	static let scheme = "https"
	static let api = "api.intra.42.fr"
	static let path = "/oauth/token/"
	static let userPath = "/v2/users/"
	static let secret = ProcessInfo.processInfo.environment["secret"]
	static let uid = ProcessInfo.processInfo.environment["uid"]
	
}
