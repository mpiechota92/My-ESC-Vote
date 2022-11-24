//
//  SegmentControlButton.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/11/2022.
//

import UIKit

protocol SegmentedControlButtonDelegate: AnyObject {
	
	func didTapControlButton(_ sender: SegmentedControlButton)
	
}

class SegmentedControlButton: UIView {
	
	static let height = 50.0
	
	var isSelected: Bool = false {
		willSet {
			let textColor = newValue ? Color.Primary.darkNavy : Color.Primary.accentColor
			DispatchQueue.main.async {
				self.controlButton.setTitleColor(textColor, for: .normal)
				self.controlButtonBackground.backgroundColor = newValue ? Color.Primary.accentColor : Color.transparent
			}
		}
	}
	
	weak var delegate: SegmentedControlButtonDelegate!
	var index: Int!
	var title: String! {
		didSet {
			self.controlButton.setTitle(self.title, for: .normal)
			self.controlButton.setTitle(self.title, for: [.normal, .selected])
			self.controlButton.setTitle(self.title, for: .highlighted)
			
		}
	}
	
	@IBOutlet weak var controlButton: UIButton!
	@IBOutlet weak var controlButtonBackground: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		controlButton.titleLabel?.font = UIFont(name: Font.Name.metropolisThin, size: Font.Size.small)
		controlButton.setTitleColor(Color.Primary.accentColor, for: .normal)
		controlButtonBackground.layer.cornerRadius = controlButtonBackground.frame.height / 5.0
	}
	
	@IBAction func didTapControlButton(_ sender: Any) {
		isSelected = true
		delegate.didTapControlButton(self)
	}
	
}


