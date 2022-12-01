//
//  UITableView+Update.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/12/2022.
//

import UIKit

extension UITableView {
	
	func reloadRows(from leftIndexPath: IndexPath, to rightIndexPath: IndexPath, section: Int = 0) {
		let minIndex: Int = min(leftIndexPath.row, rightIndexPath.row)
		let maxIndex: Int = max(leftIndexPath.row, rightIndexPath.row)
		
		for row in minIndex...maxIndex {
			DispatchQueue.main.async {
				let indexPath = IndexPath(row: row, section: section)
				self.reloadRows(at: [indexPath], with: .automatic)
			}
		}
	}
	
	
}

