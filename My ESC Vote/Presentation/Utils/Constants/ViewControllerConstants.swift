//
//  ViewControllerConstants.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

extension Constants {
	
	enum UI {
		
		enum Storyboard {
			static let main = "Main"
		}
		
		enum ViewController {
			
			enum Segues {
				static let showRegistration = "showRegistration"
			}
			
			enum ID {
				static let register = "RegisterViewController"
				static let login = "LoginViewController"
				static let main = "MainViewController"
				static let voting = "VotingViewController"
				static let contests = "ContestsViewController"
			}
			
		}
		
		enum TableView {
			
			enum Cell {
				
				static let menuOption = "MenuOptionTableViewCell"
				static let contest = "ContestTableViewCell"
				static let vote = "ParticipantCell"
				
			}
			
		}
		
		enum TabBarController {
			
			enum Item {
				static let home = "Home"
			}
			
		}
		
	}
	
}
