//
//  ViewController.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

final class SearchViewController: UIViewController, ProfileViewControllerProtocol {
	
	var userName: String?
	private var viewModel: SearchViewModelProtocol = SearchViewModel()
	private var snowFlakes = SnowFlakeManager()
	
	private let searchTextField: UITextField = {
		let tf = UITextField()
		tf.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		tf.textColor = .label
		tf.placeholder = K.search
		tf.layer.cornerRadius = 12
		tf.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
		tf.keyboardType = .default
		tf.returnKeyType = .go
		tf.autocorrectionType = .no
		tf.borderStyle = .roundedRect
		tf.clearButtonMode = .whileEditing
		tf.autocapitalizationType = .none
		tf.contentVerticalAlignment = .center
		tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	private let searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemPurple
		button.setTitle("Find Companion", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		button.layer.cornerRadius = 12
		button.heightAnchor.constraint(equalToConstant: 44).isActive = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupActions()
	}
	
	private func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: K.background) ?? UIImage())
		snowFlakes.injectSnowLayer(into: view)
		
		view.addSubviews([searchTextField, searchButton])
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 3),
			searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
			searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
			
			searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
			searchButton.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
			searchButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
		])
	}
	
	private func setupActions() {
		searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
		searchTextField.delegate = self
	}
	
	@objc private func searchButtonPressed() {
		userName = searchTextField.text?.lowercased()
		viewModel.delegate = self
		viewModel.buttonPressed(sender: self)
	}
}

extension SearchViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == searchTextField {
			searchButtonPressed()
			textField.resignFirstResponder()
			return false
		}
		return true
	}
}

private extension UITextField {
	func setLeftPaddingPoints(_ amount: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
		leftView = paddingView
		leftViewMode = .always
	}
}
