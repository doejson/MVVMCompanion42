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
	
	private lazy var projectInfoData: [ProjectsUsersModel] = []
	private lazy var arrayWithCellData: [ProjectInfoModel] = []
	private lazy var cursusData: [CursusModel] = []
	
	let profileImage: UIImageView = {
		let image = UIImageView()
		image.layer.borderWidth = 1.0
		image.layer.masksToBounds = false
		image.layer.borderColor = UIColor.white.cgColor
		image.layer.cornerRadius = 3
		image.clipsToBounds = true
		image.image = UIImage(named: K.profile)
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let nickLabel: UILabel = {
		let label = UILabel()
		label.text = K.userError
		label.adjustsFontSizeToFitWidth = true
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let locationLabel: UILabel = {
		let label = UILabel()
		label.adjustsFontSizeToFitWidth = true
		label.tintColor = .white
		label.textAlignment = .center
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let emailLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.adjustsFontSizeToFitWidth = true
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	let walletLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let pointsLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let currentLvlLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.tintColor = .cyan
		label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let currentLvl: UIProgressView = {
		let currentLvl = UIProgressView()
		currentLvl.clipsToBounds = true
		currentLvl.layer.borderWidth = 1
		currentLvl.layer.borderColor = UIColor.black.cgColor
		currentLvl.progressTintColor = .purple
		currentLvl.trackTintColor = .white
		currentLvl.translatesAutoresizingMaskIntoConstraints = false
		return currentLvl
	}()
	
	private let tableView = UITableView()
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		callToViewModelForUpdate()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		profileImage.backgroundColor = UIColor.clear
		profileImage.isOpaque = false
		profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
		currentLvl.layer.cornerRadius = 12.4
	}
	
	func setupView() {
		guard let image = UIImage(named: K.background) else { return }
		view.backgroundColor = UIColor(patternImage: image)
		view.addSubviews([profileImage, nickLabel,locationLabel, emailLabel, walletLabel,pointsLabel,currentLvl,currentLvlLabel, tableView])
		setupConstraints()
		fetchData()
		setupTabelView()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			profileImage.heightAnchor.constraint(equalToConstant: 150),
			profileImage.widthAnchor.constraint(equalToConstant: 150),
			profileImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
			
			nickLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
			nickLabel.heightAnchor.constraint(equalToConstant: 40),
			nickLabel.widthAnchor.constraint(equalToConstant: 100),
			nickLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			locationLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 40),
			locationLabel.leftAnchor.constraint(equalTo: nickLabel.rightAnchor, constant: 10),
			locationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			
			emailLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor),
			emailLabel.heightAnchor.constraint(equalToConstant: 30),
			emailLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			emailLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			walletLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
			walletLabel.heightAnchor.constraint(equalToConstant: 30),
			walletLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			walletLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			pointsLabel.topAnchor.constraint(equalTo: walletLabel.bottomAnchor),
			pointsLabel.heightAnchor.constraint(equalToConstant: 30),
			pointsLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			pointsLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
			
			currentLvl.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
			currentLvl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
			currentLvl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
			currentLvl.heightAnchor.constraint(equalToConstant: 30),
			
			currentLvlLabel.centerXAnchor.constraint(equalTo: currentLvl.centerXAnchor),
			currentLvlLabel.centerYAnchor.constraint(equalTo: currentLvl.centerYAnchor),
			
			tableView.topAnchor.constraint(equalTo: currentLvl.bottomAnchor, constant: 10),
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
			
		])
	}
	
	func setupTabelView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = UIColor.clear
		tableView.isOpaque = false
		tableView.register(Cell.self, forCellReuseIdentifier: K.reuseIdentifier)
		tableView.separatorStyle = .singleLine
	}
	
	func fetchData() {
		NetworkService.shared.loadUser(userName:delegate?.userName) { result in
			switch result {
			case .success(let data):
				self.projectInfoData = data.projects_users ?? []
				self.cursusData = data.cursus_users 
				//Cringe
				guard let level = self.cursusData[1].level else { return }
				let levelProgress = level.truncatingRemainder(dividingBy: 1)
				let stringLevel = "\(level) %"
//				let level =  Int((self.cursusData[1].level ?? 0.0) * 100) % 100
				DispatchQueue.main.async {
					self.tableView.reloadData()
					self.emailLabel.text = data.email
					self.nickLabel.text = data.login
					self.locationLabel.text = self.helloYandex(email: data.email ?? "Moscow")
					self.walletLabel.text = "wallet: \(data.wallet ?? 0)₳"
					self.pointsLabel.text = "evaluation points: \(data.correction_point ?? 0)"
					self.currentLvl.setProgress(levelProgress, animated: false)
					self.currentLvlLabel.text = stringLevel
					//MARK: - Nado ili ne nado ?
					self.reloadInputViews()
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func helloYandex(email: String) -> String {
		let mail = email
		let result = String(mail.split(separator: "@")[1])
		var campusName: String {
			switch result {
			case "student.21-school.ru": return "📍Moscow"
			case "student.42.fr": return "📍Paris"
			case "student.42tokyo.jp": return "📍Tokyo"
			default: return "📍Adelaide"
			}
		}
		return campusName
	}
	
	func callToViewModelForUpdate() {
		
	}

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projectInfoData.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseIdentifier) as? Cell
		else { fatalError() }
		
		let data = projectInfoData.sorted {$0.finalMark ?? 0 > $1.finalMark ?? 0}
		let element = data[indexPath.row]
		cell.configure(model: Cell.Model(name: element.project?.name, mark: String(element.finalMark ?? 0), validated: element.validated))
		cell.backgroundColor = UIColor.clear
		cell.isOpaque = false
		cell.tintColor = .black
		cell.selectionStyle = .none
		return cell
	}
	
}
