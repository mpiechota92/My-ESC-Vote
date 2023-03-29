//
//  ViewModelFactory.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/03/2023.
//

import Foundation

protocol ViewModelFactory {
	func instantiateViewModel() -> ListViewModelProtocol
	func instantiateViewModelItem() -> ListItemProtocol
}
