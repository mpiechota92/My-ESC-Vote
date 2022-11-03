//
//  Option.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/11/2022.
//

import UIKit

struct MenuOption {
	
	typealias Handler = (_ navigationController: UINavigationController?) -> ()
	
	var title: String
	var icon: String
	var targetViewController: String? = nil
	var handler: Handler
	
	
}
