//
//  SearchViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 12/8/22.
//

import Foundation
import UIKit

protocol SearchViewModelProtocol {
	
	func buttonPressed(sender: UIViewController)
	func showAllert()
	var delegate: ProfileViewControllerProtocol? { get set }
	
}

class SearchViewModel {
	var delegate: ProfileViewControllerProtocol?

	var hello = Dynamic("")
	
}

extension SearchViewModel: SearchViewModelProtocol {

	func buttonPressed(sender: UIViewController) {
		let profileViewModel = ProfileViewModel(delegate)
		let profileViewController = ProfileViewController(profileViewModel)
		
		userName == "" || userName == "42" ? showAllert() : sender.navigationController?.pushViewController(profileViewController, animated: true)
		print("Search Success")
	}
	
	func showAllert() {
		print("Kyky ne rabotaet 🤷‍♂️")
	}
	
	
}
