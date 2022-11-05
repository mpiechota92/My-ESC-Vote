//
//  ViewControllerConstants.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

extension Constants {
	
	struct UI {
		
		struct Storyboard {
			static let main = "Main"
		}
		
		struct ViewController {
			
			struct Segues {
				static let showRegistration = "showRegistration"
			}
			
			struct ID {
				static let register = "RegisterViewController"
				static let login = "LoginViewController"
				static let main = "MainViewController"
				static let voting = "VotingViewController"
			}
			
		}
		
		struct TableView {
			
			struct Cell {
				
				static let menuOption = "MenuOptionTableViewCell"
				
			}
			
		}
		
		struct TabBarController {
			
			struct Item {
				static let home = "Home"
			}
			
		}
		
	}
	
}
