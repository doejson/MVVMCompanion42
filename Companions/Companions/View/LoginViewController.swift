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
	var tokenStatus: String?
	
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
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		loginButton.isOpaque = false
		loginButton.layer.cornerRadius = loginButton.frame.size.width / 2
	}
	
	func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
		view.addSubview(labelView)
		view.addSubview(loginButton)
		setupConstraints()
	}
	
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
	
	func checktoken() {
		NetworkService.shared.checkToken { result in
			switch result {
			case .success(let data):
				self.tokenStatus = data.expires_type
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func fetch() {
		checktoken()
		if tokenStatus == "weak" || tokenStatus == "expired" || tokenStatus == nil {
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
}
	
	@objc func loginButtonPressed() {
		fetch()
		let searchViewController = SearchViewController()
		self.navigationController?.pushViewController(searchViewController, animated: true)
		print("Login Success")
		
		print(UserDefaults.standard.value(forKey: "token"))
		print(UserDefaults.standard.value(forKey: "tokenType"))
	}
	
	func callToViewModelForUpdate() {
		
	}


}

