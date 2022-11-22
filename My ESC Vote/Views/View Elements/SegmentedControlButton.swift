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
			controlButton.titleLabel?.textColor = newValue ? Color.Primary.darkNavy : Color.Primary.accentColor
			controlButtonBackground.backgroundColor = newValue ? Color.Primary.accentColor : Color.transparent
		}
	}
	
	var delegate: SegmentedControlButtonDelegate!
	var index: Int!
	var title: String! {
		didSet {
			controlButton.titleLabel?.text = title
		}
	}
	
	@IBOutlet weak var controlButton: UIButton!
	@IBOutlet weak var controlButtonBackground: UIView!
	
	init(_ title: String) {
		// ?? Include??
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		controlButtonBackground.layer.cornerRadius = controlButtonBackground.frame.height / 2.0
	}
	
	@IBAction func didTapControlButton(_ sender: Any) {
		isSelected = true
		delegate.didTapControlButton(self)
	}
	
}
