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
		search.backgroundColor = .systemOrange
		search.layer.cornerRadius = 12.4
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	let searchButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemOrange
		button.layer.cornerRadius = 12.4
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
	
	private func setupView() {
		view.backgroundColor = .systemBlue
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
		setupConstraints()
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
