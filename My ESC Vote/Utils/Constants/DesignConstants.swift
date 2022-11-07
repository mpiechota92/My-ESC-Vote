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
			static let tintColor = UIColor(named: "Winter")!
			static let dimmedAccentColor = UIColor(named: "Dimmed Accent Color")!
			
			
			struct Primary {
				static let darkNavy = UIColor(named: "Dark Navy")
			}
			
			struct Secondary {
				static let lightNavy = UIColor(named: "Light Navy")!
			}
			
			struct Grayscale {
				
			}
			
		}
		
		struct Image {
			
			struct Icon {
				static let user = "person"
				static let register = "person.badge.plus"
				static let login = "person.crop.circle"
				static let logout = "rectangle.portrait.and.arrow.right"
				static let settings = "gearshape"
				static let about = "info.circle"
				static let close = "xmark.circle"
				static let back = "chevron.backward"
				static let home = "music.note.house"
				static let homeSelected = "music.note.house.fill"
				static let contests = "list.bullet.clipboard"
				static let contestsSelected = "list.bullet.clipboard.fill"
			}
			
		}
		
		struct Font {
			
			struct Name {
				static let gotham = "Gotham Book"
				static let gothamBold = "Gotham Bold"
			}
			
			struct Color {
				static let error = UIColor(named: "Error")!
				static let succsess = UIColor(named: "Success")!
			}
			
			struct Size {
				static let small = 15.0
				static let standard = 19.5
				static let large = 25.35
				static let extraLarge = 33.0
				
				static let header = 22.0
				static let subheader = 13.0
				static let body = 17.0
			}
			
		}
		
	}
	
}


