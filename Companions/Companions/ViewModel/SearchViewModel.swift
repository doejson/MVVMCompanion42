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
	
}

class SearchViewModel {
	var hello = Dynamic("")
	
}

extension SearchViewModel: SearchViewModelProtocol {
	
	@inlinable internal func buttonPressed(sender: UIViewController) {
		 let profileViewController = ProfileViewController(ProfileViewModel())
		
		 userName == "" || userName == "42" ? showAllert() : sender.navigationController?.pushViewController(profileViewController, animated: true)
		 print("Search Success")
	}
	
	@inlinable internal func showAllert() {
		print("Kyky ne rabotaet 🤷‍♂️")
	}
	
	
}
