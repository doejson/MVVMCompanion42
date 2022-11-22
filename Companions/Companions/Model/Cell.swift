//
//  ProjectCell.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import UIKit

class Cell: UITableViewCell {

	final class Cell: UITableViewCell {
		
		// MARK: Static
		static let identifier = K.reuseIdentifier
		
		// MARK: Properties
		private let name: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.textColor = .white
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		private let descript: UILabel = {
			let label = UILabel()
			label.numberOfLines = 0
			label.textColor = .white
			label.adjustsFontSizeToFitWidth = true
			label.translatesAutoresizingMaskIntoConstraints = false
			return label
		}()
		
		private let image: UIImageView = {
			let image = UIImageView()
			image.layer.cornerRadius = 10
			image.clipsToBounds = true
			image.translatesAutoresizingMaskIntoConstraints = false
			return image
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
			contentView.addSubview(image)
			contentView.addSubview(name)
			contentView.addSubview(descript)
			
			NSLayoutConstraint.activate([
				
				image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
				image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
				image.widthAnchor.constraint(equalToConstant: 60),
				image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
				
				name.topAnchor.constraint(equalTo: image.topAnchor),
				name.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 20),
				
				descript.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
				descript.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 20),
				descript.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
				descript.bottomAnchor.constraint(equalTo: image.bottomAnchor)
	   
			])
		}
	}
}
