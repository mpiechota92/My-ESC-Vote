//
//  UIView+InstanceFromNib.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

extension UIView {
	
	class func instanceFromNib<T: UIView>(_ nibName: String) -> T {
		return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
	}
	
}
