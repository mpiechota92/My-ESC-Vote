//
//  UIView+InstanceFromNib.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

extension UIView {
	
	class func instanceFromNib<T: UIView>() -> T {
		return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil)![0] as! T
	}
	
}
