//
//  ViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit

class LoginViewController: UIViewController {
	
	private var viewModel: LoginViewModelProtocol = LoginViewModel()
	
	let loginTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemMint
		textField.layer.cornerRadius = 12.4
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .systemMint
		textField.layer.cornerRadius = 12.4
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let labelView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: K.logo)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let loginButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .purple
		button.setTitle(K.loginButtonTitle, for: .normal)
		button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	lazy var noConnectionImage: UIImageView = {
		let image = UIImageView()
		let largeFont = UIFont.systemFont(ofSize: 60)
		let configuration = UIImage.SymbolConfiguration(font: largeFont)
		image.image = UIImage(systemName: "wifi.exclamationmark", withConfiguration: configuration)
		image.tintColor = .green
		image.isHidden = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	lazy var noConnectionLabel: UILabel = {
		let title = UILabel()
		title.font = UIFont.systemFont(ofSize: 30)
		title.textColor = .green
		title.textAlignment = .center
		title.text = "No Internet connection"
		title.isHidden = true
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	//MARK: Initializers View Model
	
//	init (_ viewModel: LoginViewModel) {
//		self.viewModel = viewModel
//		super.init(nibName: nil, bundle: nil)
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
	
	
	
	//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
		callToViewModelForUpdate()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		loginButton.layer.cornerRadius = loginButton.frame.size.width / 2
	}
	
	func setupView() {
		guard let image = UIImage(named: K.background) else { return }
		view.backgroundColor = UIColor(patternImage: image)
		view.addSubviews([labelView, loginButton, noConnectionImage, noConnectionLabel])
		setupConstraints()
	}
	
	@objc func loginButtonPressed() {
		callToViewModelForUpdate()
		let searchViewController = SearchViewController()
		self.navigationController?.pushViewController(searchViewController, animated: true)
		print("Login Success")
		print(UserDefaults.standard.value(forKey: "token") ?? "")
		print(UserDefaults.standard.value(forKey: "tokenType") ?? "")
	}
	
	func callToViewModelForUpdate() {
		
		if viewModel.checkConnection == false {
			self.noConnectionUIActions()
			return
		}
		viewModel.fetch()
		
//		viewModel.fetch() = { [weak self] in
//			guard let self = self else { return }
//			if !Storage.isSaveSearch {
//				self.showSearchAlert()
//			}
//		}

	}
}

extension LoginViewController {
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			labelView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			labelView.heightAnchor.constraint(equalToConstant: 60),
			labelView.widthAnchor.constraint(equalToConstant: 80),
			
			loginButton.heightAnchor.constraint(equalToConstant: 200),
			loginButton.widthAnchor.constraint(equalToConstant: 200),
			loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			loginButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			
			noConnectionImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			noConnectionImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			
			noConnectionLabel.topAnchor.constraint(equalTo: noConnectionImage.bottomAnchor),
			noConnectionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			noConnectionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			noConnectionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
		])
	}
	
	func noConnectionUIActions() {
		view.backgroundColor = .black
		labelView.isHidden = true
		loginButton.isHidden = true
		noConnectionImage.isHidden = false
		noConnectionLabel.isHidden = false
	}
}

