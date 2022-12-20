//
//  NoNetworkVC.swift
//  Companions
//
//  Created by Tiana Patti on 12/20/22.
//

import Foundation
import UIKit

class NoNetworkVC: UIViewController {
	
	let str: String = "21"
	
	lazy var imageView: UIImageView = {
		let image = UIImageView()
		let largeFont = UIFont.systemFont(ofSize: 60)
		let configuration = UIImage.SymbolConfiguration(font: largeFont)
		image.image = UIImage(systemName: "wifi.exclamationmark", withConfiguration: configuration)
		image.tintColor = .green
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	lazy var label: UILabel = {
		let title = UILabel()
		title.font = UIFont.systemFont(ofSize: 60)
		title.textColor = .green
		title.text = "No Internet connection"
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConstraints()
	}
	
	

}

extension NoNetworkVC {
	func setupConstraints() {
		
		view.addSubview(imageView)
		
		NSLayoutConstraint.activate([
		
			imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			
			label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			
		])
		
	}
}
