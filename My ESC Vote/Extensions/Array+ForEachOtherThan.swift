//
//  Array+ForOtherThan.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/11/2022.
//

import Foundation

extension Array {
	
	func forEachOtherThan(at index: Int, _ body: @escaping (_ element: Element) -> ()) {
		var tempArray = self
		tempArray.remove(at: index)
		
		tempArray.forEach { element in
			body(element)
		}
	}
	
	func forEachWithIndex(_ body: @escaping (_ index: Int, _ element: Element) -> ()) where Element: Equatable {
		
		self.forEach { element in
			// Get the index of the element
			let index = self.firstIndex { _element in
				return _element == element
			}
			
			guard let index = index else { return }
			
			body(index, element)
		}
	}
	
}
