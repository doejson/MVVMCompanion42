//
//  SearchViewModel.swift
//  Companions
//
//  Created by Tiana Patti on 12/8/22.
//

import Foundation

protocol SearchViewModelProtocol {
	
	func buttonPressed()
	func showAllert()
	
}

class SearchViewModel {
	var hello = Dynamic("")
	
}

extension SearchViewModel: SearchViewModelProtocol {
	
	func buttonPressed() {
		
	}
	
	func showAllert() {
		
	}
	
	
}
