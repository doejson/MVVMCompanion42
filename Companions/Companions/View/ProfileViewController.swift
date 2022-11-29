//
//  InformationViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation
import UIKit

protocol ProfileViewControllerProtocol {
	var userName: String? { get set }
}

class ProfileViewController: UIViewController {
	
	var delegate: ProfileViewControllerProtocol?
	
	private lazy var arrayWithUserData: [ModelData] = []
	
	
	let profileImage: UIImageView = {
		let image = UIImageView()
		image.layer.borderWidth = 1.0
		image.backgroundColor = .green
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let nickLabel: UILabel = {
		let label = UILabel()
		label.text = "nick"
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let emailLabel: UILabel = {
		let label = UILabel()
		label.text = "email"
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 10, weight: .light)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let locationLabel: UILabel = {
		let label = UILabel()
		label.text = "location"
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let walletLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let mobileLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	//	let currentLvl: UIProgressView = {
	//		let currentLvl = UIProgressView()
	//		return currentLvl
	//	}()
	
	private let tableView = UITableView()
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		callToViewModelForUpdate()
		setupView()
		setupTabelView()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
	}
	
	func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
		view.addSubviews([profileImage, nickLabel, emailLabel, locationLabel, walletLabel, mobileLabel, tableView])
		setupConstraints()
		fetchData()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			profileImage.heightAnchor.constraint(equalToConstant: 100),
			profileImage.widthAnchor.constraint(equalToConstant: 100),
			profileImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
			
			nickLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
			nickLabel.heightAnchor.constraint(equalToConstant: 40),
			nickLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			nickLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			
			emailLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor),
			emailLabel.heightAnchor.constraint(equalToConstant: 30),
			emailLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			emailLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			locationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 30),
			locationLabel.widthAnchor.constraint(equalToConstant: 70),
			locationLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			walletLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor),
			walletLabel.heightAnchor.constraint(equalToConstant: 30),
			walletLabel.widthAnchor.constraint(equalToConstant: 30),
			walletLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			
			
			//			currentLvl.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
			//			currentLvl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
			//			currentLvl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
			//			currentLvl.heightAnchor.constraint(equalToConstant: 50),
			
			tableView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
			
		])
	}
	
	func setupTabelView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(Cell.self, forCellReuseIdentifier: K.reuseIdentifier)
		tableView.backgroundColor = .white
		tableView.separatorStyle = .singleLine
	}
	
	func fetchData() {
		
		print(delegate?.userName)
		NetworkService.shared.loadUser(userName:delegate?.userName) { result in
			switch result {
			case .success(let data):
				DispatchQueue.main.async {
					self.emailLabel.text = data.email
					self.nickLabel.text = data.login
					self.locationLabel.text = "\(data.wallet)"
					self.reloadInputViews()
				}
			case .failure(let error):
				print(error)
			}
		}
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
