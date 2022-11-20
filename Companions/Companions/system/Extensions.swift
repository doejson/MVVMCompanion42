//
//  Extensions.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 20/11/2022.
//

import Foundation
import UIKit

extension UIView {
	
	func addSubviews(_ views: [Any]) {
		views.forEach { if let view = $0 as? UIView {
			self.addSubview(view)
			}
		}
	}
	
	func pin(to superView: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
		leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
		trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
		bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
	}
}
