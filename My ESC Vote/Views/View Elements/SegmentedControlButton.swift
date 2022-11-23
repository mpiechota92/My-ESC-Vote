//
//  SegmentControlButton.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/11/2022.
//

import UIKit

protocol SegmentedControlButtonDelegate {
	
	func didTapControlButton(_ sender: SegmentedControlButton)
	
}

class SegmentedControlButton: UIView {
	
	var isSelected: Bool = false {
		willSet {
			let textColor = newValue ? Color.Primary.darkNavy : Color.Primary.accentColor
			controlButton.titleLabel?.textColor = textColor
			
			controlButtonBackground.backgroundColor = newValue ? Color.Primary.accentColor : Color.transparent
		}
	}
	
	var delegate: SegmentedControlButtonDelegate!
	var index: Int!
	var title: String! {
		didSet {
			controlButton.setTitle(title, for: [.normal, .selected, .focused, .highlighted, .application, .disabled, .reserved])
		}
	}
	
	@IBOutlet weak var controlButton: UIButton!
	@IBOutlet weak var controlButtonBackground: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		controlButtonBackground.layer.cornerRadius = controlButtonBackground.frame.height / 5.0
		controlButton.titleLabel?.font  = UIFont(name: Font.Name.metropolisThin, size: 10)
	}
	
	@IBAction func didTapControlButton(_ sender: Any) {
		isSelected = true
		delegate.didTapControlButton(self)
	}
	
}


