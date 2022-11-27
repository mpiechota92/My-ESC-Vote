//
//  UICollectionView+Register.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 27/11/2022.
//

import UIKit

extension UICollectionView {
	
	func register<T: HavingNib>(for cellClass: T.Type) {
		self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
	}
	
}
