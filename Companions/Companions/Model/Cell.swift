//
//  ProjectCell.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

protocol Configurable {
	associatedtype Model
	func configure(model: Model)
}

	final class Cell: UITableViewCell {
		
		// MARK: Static
		static let identifier = K.reuseIdentifier
		
		// MARK: Properties
		private let name: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.textColor = .white
			label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		private let mark: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.textColor = .white
			label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
			label.adjustsFontSizeToFitWidth = true
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		private let status: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.adjustsFontSizeToFitWidth = true
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		private let validated: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.textColor = .white
			label.adjustsFontSizeToFitWidth = true
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		

		// MARK: Initializers
		override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			setupView()
		}
		required init?(coder: NSCoder) {
			super.init(coder: coder)
		}
		// MARK: Setup
		private func setupView() {
			contentView.addSubview(name)
			contentView.addSubview(mark)
			contentView.addSubview(validated)
			
			NSLayoutConstraint.activate([
				
				name.topAnchor.constraint(equalTo: contentView.topAnchor),
				name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
				name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
				name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				
				mark.topAnchor.constraint(equalTo: contentView.topAnchor),
				mark.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: -75),
				mark.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
				mark.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				
				validated.topAnchor.constraint(equalTo: contentView.topAnchor),
				validated.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: -35),
				validated.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
				validated.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				
			])
		}
	}

// MARK: - Configurable
extension Cell: Configurable {

	struct Model {
		let name: String?
		let mark: String?
		let validated: Bool?
	}

	func configure(model: Model) {
		name.text = model.name
		mark.text = model.mark
		if model.validated == true {
			validated.text = "✅"
		} else {
			validated.text = "❌"
		}
		
	}
}
