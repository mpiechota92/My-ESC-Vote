//
//  HavingStoryboard.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 27/11/2022.
//


import UIKit

protocol HavingStoryboard: NSObjectProtocol {
	associatedtype T
	static var fileName: String { get }
	static var identifier: String { get }
	static func instantiateViewController(_ bundle: Bundle?) -> T
}

extension HavingStoryboard {
	
	static var fileName: String { return String(describing: Self.self) }
	static var identifier: String { return String(describing: Self.self) }
	
	static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
		let fileName = self.fileName
		let identifier = self.identifier
		let storyBoard = UIStoryboard(name: fileName, bundle: bundle)
		
		guard let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as? Self else {
			fatalError("Cannot instantiate view controller \(Self.self) from storyboard with name \(fileName), with identifier \(identifier)")
		}
		
		return vc
	}
	
}
