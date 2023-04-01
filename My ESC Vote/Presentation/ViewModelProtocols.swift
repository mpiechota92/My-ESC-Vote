//
//  ViewModelProtocols.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 21/03/2023.
//

import Foundation

protocol CategoryProtocol: Codable, CaseIterable {
	var simpleDescription: String { get }
}

protocol ListViewModelProtocol: AnyObject {
	var itemList: [ListItemProtocol] { get set }
	func instantiate() -> Self
	func instantiate(with itemList: [ListItemProtocol]) -> Self
}

class ListViewModel: ListViewModelProtocol {

	var itemList: [ListItemProtocol] = []
	
	// MARK: - Initializers
	
	required init() {
	}
	
	init(with itemList: [ListItemProtocol]) {
		self.itemList = itemList
	}
	
	func instantiate() -> Self {
		return Self.init()
	}
	
	func instantiate(with itemList: [ListItemProtocol]) -> Self {
		let instance = Self.init()
		instance.itemList = itemList
		return instance
	}
}


protocol ListItemProtocol { }
