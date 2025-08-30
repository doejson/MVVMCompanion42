//
//  Array+Ext.swift
//  Companions
//
//  Created by Dmitry Kaveshnikov on 25/12/2022.
//

import Foundation

extension Array {
	subscript(safe index: Int) -> Element? {
		if index < count {
			return self[index]
		}
		return nil
	}
}
