//
//  ViewController.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

class SearchViewController: UIViewController {
	
	let searchTextField: UITextField = {
		let search = UITextField()
		search.placeholder = "Search ..."
		search.backgroundColor = .lightGray
		search.alpha = 0.85
		search.keyboardType = UIKeyboardType.default
		search.returnKeyType = UIReturnKeyType.done
		search.autocorrectionType = UITextAutocorrectionType.no
		search.font = UIFont.systemFont(ofSize: 15)
		search.borderStyle = UITextField.BorderStyle.roundedRect
		search.clearButtonMode = UITextField.ViewMode.whileEditing;
		search.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
		search.autocapitalizationType = .words
		search.returnKeyType = .go
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	let searchButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 12.4
		button.setTitle("Press me 🟢", for: .normal)
		button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchTextField.delegate = self
		setupView()
	}
	
	private func setupView() {
		view.backgroundColor = .systemBlue
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
		setupConstraints()
	}
	
	@objc func searchButtonPressed() {
		let profileViewController = ProfileViewController()
		self.navigationController?.pushViewController(profileViewController, animated: true)
		print("Search Success")
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			
			searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			searchTextField.heightAnchor.constraint(equalToConstant: 75),
			
			searchButton.heightAnchor.constraint(equalToConstant: 50),
			searchButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			searchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
			
		])
	}
	
}

extension SearchViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextField.endEditing(true)
		guard let text = searchTextField.text else {
			return false
		}
		print (text)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		//TODO: Use Guard 😎
		if textField.text != "" {
			return true
		} else {
			textField.placeholder = "Type something"
			return false
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if let user = searchTextField.text?.lowercased() {
			UserDefaults.standard.setValue(user, forKey: "user")
		}
		searchTextField.text = ""
	}
}
