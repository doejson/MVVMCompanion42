//
//  InformationViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
	
	var viewModel: ProfileViewModelProtocol
	
	init(_ viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		viewModel.onUpdate = { [weak self] in
			guard let self = self else { return }
			self.updateView()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let profileImage: UIImageView = {
		let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
		image.layer.cornerRadius = image.frame.size.height / 2
		image.layer.borderWidth = 1.0
		image.layer.masksToBounds = false
		image.layer.borderColor = UIColor.white.cgColor
		image.clipsToBounds = true
		image.image = UIImage(named: K.profile)
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	private let nickLabel: UILabel = {
		let label = UILabel()
		label.text = K.userError
		label.adjustsFontSizeToFitWidth = true
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	private let locationLabel: UILabel = {
		let label = UILabel()
		label.adjustsFontSizeToFitWidth = true
		label.tintColor = .white
		label.textAlignment = .center
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.adjustsFontSizeToFitWidth = true
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	
	private let walletLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let pointsLabel: UILabel = {
		let label = UILabel()
		label.tintColor = .white
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let currentLvlLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.tintColor = .cyan
		label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let currentLvl: UIProgressView = {
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
		callToViewModelForUpdate()
		setupView()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		profileImage.backgroundColor = UIColor.clear
		profileImage.isOpaque = false
		profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
		currentLvl.layer.cornerRadius = 12.4
	}
	
	private func setupView() {
		guard let image = UIImage(named: K.background) else { return }
		view.backgroundColor = UIColor(patternImage: image)
		view.addSubviews([profileImage, nickLabel,locationLabel, emailLabel, walletLabel,pointsLabel,currentLvl,currentLvlLabel, tableView])
		setupConstraints()
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
	
	func callToViewModelForUpdate() {
		viewModel.fetchData()
	}
	
	func updateView() {
		DispatchQueue.main.async {
			self.emailLabel.text = self.viewModel.email
			self.nickLabel.text = self.viewModel.login
			self.locationLabel.text = self.viewModel.location
			self.walletLabel.text = self.viewModel.wallet
			self.pointsLabel.text = self.viewModel.points
			self.currentLvl.setProgress((self.viewModel.levelProgress), animated: false)
			self.currentLvlLabel.text = self.viewModel.stringLevel
			self.tableView.reloadData()
		}
	}
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.tableViewCount
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseIdentifier) as? Cell
		else { fatalError() }
		
		let data = viewModel.projectInfoData
		let element = data[indexPath.row]
		cell.configure(model: Cell.Model(name: element.project?.name, mark: String(element.finalMark ?? 0), validated: element.validated))
		cell.backgroundColor = UIColor.clear
		cell.isOpaque = false
		cell.tintColor = .black
		cell.selectionStyle = .none
		return cell
	}
}
