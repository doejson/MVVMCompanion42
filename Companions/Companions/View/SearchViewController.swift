//
//  ViewController.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

class SearchViewController: UIViewController, ProfileViewControllerProtocol {
	
	var userName: String?
	private var viewModel: SearchViewModelProtocol = SearchViewModel()
	
	var snowFlakes = SnowFlakeManager()
	
	let searchTextField: UITextField = {
		let search = UITextField()
		search.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		search.textColor = .white
		search.placeholder = K.search
		search.backgroundColor = .lightGray
		search.alpha = 0.85
		search.keyboardType = UIKeyboardType.default
		search.returnKeyType = UIReturnKeyType.done
		search.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		search.autocorrectionType = UITextAutocorrectionType.no
		search.borderStyle = UITextField.BorderStyle.roundedRect
		search.clearButtonMode = UITextField.ViewMode.whileEditing;
		search.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
		search.autocapitalizationType = .none
		search.returnKeyType = .go
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	let searchButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .purple
		button.setTitle("Find Companion42", for: .normal)
		button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
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
		searchButton.isOpaque = false
		searchButton.layer.cornerRadius = searchButton.frame.size.width / 2
	}
	
	//MARK: - Methods
	private func setupView() {
		view.backgroundColor = UIColor(patternImage: UIImage(named: K.background)!)
		snowFlakes.injectSnowLayer(into: view)
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
		setupConstraints()
	}
	
	@objc func searchButtonPressed() {
		userName = searchTextField.text?.lowercased()
		viewModel.delegate = self
		viewModel.buttonPressed(sender: self)
	}
	
	deinit {
		print ("Search View Controller succesfully Deinited")
	}
	//TODO: - Do
	
	func callToViewModel() {
		
	}
	
}

extension SearchViewController {
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			
			searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
			searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
			searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
			searchTextField.heightAnchor.constraint(equalToConstant: 50),
			
			searchButton.heightAnchor.constraint(equalToConstant: 200),
			searchButton.widthAnchor.constraint(equalToConstant: 200),
			searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 50),
			searchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
			
		])
	}
}
