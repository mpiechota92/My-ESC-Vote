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
			
			static let tintColor = UIColor(named: "Winter")!
			static let transparent = UIColor(named: "Transparent")
			
			static let error = UIColor(named: "Error")!
			static let succsess = UIColor(named: "Success")!
			
			struct Primary {
				static let darkNavy = UIColor(named: "Dark Navy")
				static let navy = UIColor(named: "Navy")
				static let accentColor = UIColor(named: "AccentColor")!
				static let dimmedAccentColor = UIColor(named: "Dimmed Accent Color")!
				static let winter = UIColor(named: "Winter")!
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
				static let voteCellAnchor = "line.3.horizontal"
			}
			
		}
		
		struct Font {
			
			struct Name {
				static let metropolisBlack = "Metropolis-Black"
				static let metropolisBlackItalic = "Metropolis-BlackItalic"
				static let metropolisBold = "Metropolis-Bold"
				static let metropolisBoldItalic = "Metropolis-BoldItalic"
				static let metropolisExtraBold = "Metropolis-ExtraBold"
				static let metropolisExtraBoldItalic = "Metropolis-ExtraBoldItalic"
				static let metropolisExtraLight = "Metropolis-ExtraLight"
				static let metropolisExtraLightItalic = "Metropolis-ExtraLightItalic"
				static let metropolisLight = "Metropolis-Light"
				static let metropolisLightItalic = "Metropolis-LightItalic"
				static let metropolisMedium = "Metropolis-Medium"
				static let metropolisMediumItalic = "Metropolis-MediumItalic"
				static let metropolisRegular = "Metropolis-Regular"
				static let metropolisRegularItalic = "Metropolis-RegularItalic"
				static let metropolisSemiBold = "Metropolis-SemiBold"
				static let metropolisSemiBoldItalic = "Metropolis-SemiBoldItalic"
				static let metropolisThin = "Metropolis-Thin"
				static let metropolisThinItalic = "Metropolis-ThinItalic"
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


