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

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
	
  func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
	image = nil
	// Кодируем URL
	let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
	
	if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
	  image = cachedImage
	  return
	}
	
	// Индикатор загрузки
	let activityIndicator = self.configureActivityIndicator()
	addSubview(activityIndicator)
	activityIndicator.startAnimating()
	
	guard let url = URL(string: imageServerUrl) else { return }
	
	URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
	  if error != nil {
		DispatchQueue.main.async { [weak self] in
		  guard let self = self else { return }
		  self.image = placeHolder
		}
		return
	  }
	  
	  guard let data = data else { return }
	  guard let downloadedImage = UIImage(data: data) else { return }
	  
	  imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
	  DispatchQueue.main.async { [weak self] in
		guard let self = self else { return }
		
		self.image = downloadedImage
		activityIndicator.removeFromSuperview()
	  }
	}).resume()
  }
  
  private func configureActivityIndicator() -> UIActivityIndicatorView {
	let activityIndicator = UIActivityIndicatorView.init(style: .medium)
	activityIndicator.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
	activityIndicator.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
	activityIndicator.autoresizingMask = AutoresizingMask(rawValue: AutoresizingMask.RawValue(UInt8(AutoresizingMask.flexibleRightMargin.rawValue) | UInt8(AutoresizingMask.flexibleLeftMargin.rawValue) | UInt8(AutoresizingMask.flexibleBottomMargin.rawValue) | UInt8(AutoresizingMask.flexibleTopMargin.rawValue)))
	
	return activityIndicator
  }
}
