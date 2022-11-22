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
	
}
