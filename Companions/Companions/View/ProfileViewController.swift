//
//  InformationViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
	
	private lazy var arrayWithUserData: [ModelData] = []
	
	let profileImage: UIImageView = {
		let image = UIImageView()
		image.layer.cornerRadius = 5
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let nickLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
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
	
	private let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		callToViewModelForUpdate()
		setupView()
		setupTabelView()
	}
	
	func setupView() {
		view.backgroundColor = .orange
		view.addSubviews([profileImage, nickLabel, emailLabel, locationLabel, walletLabel, mobileLabel, currentLvl, tableView])
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
			profileImage.heightAnchor.constraint(equalToConstant: 300),
			profileImage.widthAnchor.constraint(equalToConstant: 300),
			profileImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
			
			nickLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
			nickLabel.heightAnchor.constraint(equalToConstant: 50),
			nickLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 30),
			nickLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
			
			locationLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 50),
			locationLabel.widthAnchor.constraint(equalToConstant: 100),
			locationLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 30),
			
			walletLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor),
			walletLabel.heightAnchor.constraint(equalToConstant: 50),
			walletLabel.widthAnchor.constraint(equalToConstant: 50),
			walletLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 70),
			
			emailLabel.topAnchor.constraint(equalTo: profileImage.centerYAnchor),
			emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
			emailLabel.leftAnchor.constraint(equalTo: profileImage.leftAnchor, constant: 30),
			emailLabel.heightAnchor.constraint(equalToConstant: 50),
			
			currentLvl.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
			currentLvl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
			currentLvl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
			currentLvl.heightAnchor.constraint(equalToConstant: 50),
			
			tableView.topAnchor.constraint(equalTo: currentLvl.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

		])
	}
	
	func setupTabelView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(Cell.self, forCellReuseIdentifier: K.reuseIdentifier)
		tableView.backgroundColor = .white
		tableView.separatorStyle = .singleLine
	}
	
	func callToViewModelForUpdate() {
		
	}
	
	
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayWithUserData.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseIdentifier) as? Cell
		else { fatalError() }
		
		let element = arrayWithUserData[indexPath.row]
//		cell.configure(model: .init(name: element.name, description: element.description, image: element.icon_url))
		cell.accessoryType = .disclosureIndicator
		cell.backgroundColor = .black
		cell.tintColor = .black
		cell.selectionStyle = .none
		return cell
	}
	
}
