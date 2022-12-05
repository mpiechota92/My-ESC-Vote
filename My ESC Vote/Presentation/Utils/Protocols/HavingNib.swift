//
//  HavingNib.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 27/11/2022.
//

import UIKit

protocol HavingNib: NSObjectProtocol {
	associatedtype T
	static var nibName: String { get }
	static var identifier: String { get }
	static var nib: UINib { get }
	static func instantiateFromNib() -> T
}

extension HavingNib {
	
	static var nibName: String { String(describing: Self.self) }
	static var identifier: String { String(describing: Self.self) }
	static var nib: UINib { UINib(nibName: self.nibName, bundle: Bundle(for: Self.self)) }
	
	static func instantiateFromNib() -> Self {
		let name = self.nibName

		guard let instance = self.nib.instantiate(withOwner: nil).first as? Self else {
			fatalError("Cannot instantiate \(Self.self) from nib with name \(name)")
		}
		
		return instance
	}
	
}
