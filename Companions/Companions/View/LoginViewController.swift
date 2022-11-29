//
//  ViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit

class LoginViewController: UIViewController {
	
	var token: String?
	var tokenType: String?
	
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
		view.image = UIImage(named: "logo.png")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let loginButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .blue
		button.setTitle(K.loginButtonTitle, for: .normal)
		button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
		button.layer.cornerRadius = 12.4
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
		fetch()
    }
	func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
		view.addSubview(labelView)
//		view.addSubview(loginTextField)
//		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		setupConstraints()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			labelView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			labelView.heightAnchor.constraint(equalToConstant: 60),
			labelView.widthAnchor.constraint(equalToConstant: 80),
			
			//			loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//			loginTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
//			loginTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
//			loginTextField.heightAnchor.constraint(equalToConstant: 75),
//
//			passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50),
//			passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
//			passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
//			passwordTextField.heightAnchor.constraint(equalToConstant: 75),
			
			loginButton.heightAnchor.constraint(equalToConstant: 75),
			loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
			
			])
	}
	
	func fetch() {
		NetworkService.shared.getToken { result in
			switch result {
			case .success(let data):
				UserDefaults.standard.setValue(data.access_token, forKey: "token")
				UserDefaults.standard.setValue(data.token_type, forKey: "tokenType")
				UserDefaults.standard.synchronize()
			case .failure(let error):
				print(error)
		}
	}
}
	
	@objc func loginButtonPressed() {
		let searchViewController = SearchViewController()
		self.navigationController?.pushViewController(searchViewController, animated: true)
		print("Login Success")
		
		print(UserDefaults.standard.value(forKey: "token"))
		print(UserDefaults.standard.value(forKey: "tokenType"))
	}
	
	func callToViewModelForUpdate() {
		
	}


}

