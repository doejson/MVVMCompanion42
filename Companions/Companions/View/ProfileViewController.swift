//
//  InformationViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
	
	let profileImage: UIImageView = {
		let image = UIImageView()
		image.layer.cornerRadius = 5
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let emailLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let locationLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let walletLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let mobileLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let currentLvl: UIProgressView = {
		let currentLvl = UIProgressView()
		return currentLvl
	}()
	
	let projectTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		callToViewModelForUpdate()
		setupView()
	}
	
	func setupView() {
		view.backgroundColor = .orange
		view.addSubviews([profileImage, emailLabel, locationLabel, walletLabel, mobileLabel,currentLvl, projectTableView])
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			
			
		])
	}
	
	func callToViewModelForUpdate() {
		
	}
}
