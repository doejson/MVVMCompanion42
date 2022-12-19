//
//  ViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit

class LoginViewController: UIViewController {
	
	var viewModel = LoginViewModel()
	
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
	
	//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
		view.addSubview(labelView)
		view.addSubview(loginButton)
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
		viewModel.checktoken()
		viewModel.fetch()
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
			loginButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
	}
}

