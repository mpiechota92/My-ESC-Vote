//
//  Category.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 28/03/2023.
//

import Foundation

protocol CategoryIterable {
	func allCases() -> [String]
}

open class Categories: CategoryIterable {
	//Have to override
	open func allCases() -> [String] {
		fatalError()
	}
}
