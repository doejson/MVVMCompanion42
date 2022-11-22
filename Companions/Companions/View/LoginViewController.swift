//
//  ViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit

class LoginViewController: UIViewController {
	
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
	
//	let view: UIView = {
//		let view = UIView()
//		view.backgroundColor = .systemMint
//		return view
//	}()
	
	let loginButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .blue
		button.setTitle(K.loginButtonTitle, for: .normal)
		button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
		button.layer.cornerRadius = 12.4
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
		NetworkService.shared.createURL()
    }
	func setupView() {
		view.backgroundColor = .orange
		view.addSubview(loginTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		setupConstraints()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
			loginTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			loginTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			loginTextField.heightAnchor.constraint(equalToConstant: 75),
			
			passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50),
			passwordTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			passwordTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			passwordTextField.heightAnchor.constraint(equalToConstant: 75),
			
			loginButton.heightAnchor.constraint(equalToConstant: 75),
			loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
			
			])
	}
	
	@objc func loginButtonPressed() {
		let searchViewController = SearchViewController()
		self.navigationController?.pushViewController(searchViewController, animated: true)
		print("Login Success")
	}
	
	func callToViewModelForUpdate() {
		
	}


}

