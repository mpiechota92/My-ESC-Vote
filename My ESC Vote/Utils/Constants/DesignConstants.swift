//
//  File.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//
import UIKit

extension Constants {
	
	struct Design {
		
		struct Color {
			
			static let accentColor = UIColor(named: "AccentColor")!
			
			struct Primary {
				
			}
			
			struct Secondary {
				
			}
			
			struct Grayscale {
				
			}
			
		}
		
		struct Image {
			
			struct Icon {
				static let user = "person"
				static let register = "person.badge.plus"
				static let login = "person.crop.circle"
			}
			
		}
		
		struct Font {
			
			struct Name {
				static let gotham = "Gotham Book"
				static let gothamBold = "GothamBold"
			}
			
			struct Color {
				static let error = UIColor(named: "Error")!
				static let succsess = UIColor(named: "Success")!
			}
			
			struct Size {
				static let small = 15.0
				static let standard = 19.5
				static let large = 25.35
				
				static let header = 22.0
				static let subheader = 13.0
				static let body = 17.0
			}
			
		}
		
	}
	
}


