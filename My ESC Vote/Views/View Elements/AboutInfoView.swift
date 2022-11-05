//
//  AboutInfoView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit

class AboutInfoView: UIView {
	
	@IBOutlet var contentView: UIView!
	
	func getInstance() -> AboutInfoView {
		var view: AboutInfoView = super.instanceFromNib(Constants.Content.Nib.aboutInfoView)
		
		
		
		return view
	}
}
