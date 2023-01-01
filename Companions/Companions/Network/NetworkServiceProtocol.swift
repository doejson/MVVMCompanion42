//
//  NetworkServiceProtocol.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 28/11/2022.
//

import Foundation
import UIKit

protocol APIService {
	
	static var shared: APIService { get }
	
	var isNetworkAvailable: Bool { get }
	
	//MARK: - get token
	func getToken(completion: @escaping (Result<Token, Error>) -> Void)
		
	//MARK: - check token
	func checkToken(completion: @escaping (Result<CheckToken, Error>) -> Void)
	
	//MARK: - get user data
	func loadUser(userName: String?, completion: @escaping (Result<ModelData, Error>) -> Void)
	
	//MARK: - Download Image
	func testAsyncLoadUserPhoto(userName: String?, urlUser: URL?) async throws -> UIImage

}
