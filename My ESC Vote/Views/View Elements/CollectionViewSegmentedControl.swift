//
//  CollectionViewSegmentedControl.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/11/2022.
//

import UIKit

protocol CollectionViewSegmentedControlDelegate {
	
	func didSelectItem(_ indexPath: IndexPath)
	
}

class CollectionViewSegmentedControl: UIView {
	
	var segmentButtons: [SegmentedControlButton]!
	
	@IBOutlet weak var segmentsStackVIew: UIStackView!
	
	var delegate: CollectionViewSegmentedControlDelegate!
	
	func setup(with segments: [String]) {
		var segmentButtons: [SegmentedControlButton];
		
		segmentButtons = segments.map { segment in
			let button: SegmentedControlButton = .instanceFromNib()
			button.delegate = self
			button.controlButton.setTitle(segment, for: .normal)
			//button.controlButton.titleLabel?.font = UIFont(name: Font.Name.gotham, size: Font.Size.small)
			
			return button
		}
		
		self.segmentButtons = segmentButtons
		
		setupUI()
	}
	
	private func setupUI() {
		segmentsStackVIew.distribution = .fillEqually
		segmentsStackVIew.alignment = .center
		segmentsStackVIew.spacing = 10
		
		segmentButtons.forEachWithIndex { index, button in
			button.index = index
			self.segmentsStackVIew.addArrangedSubview(button)
		}
		
		segmentButtons.first?.isSelected = true
	}
	
	func setSegmentButtonsObservers() {
		
	}
	
}

extension CollectionViewSegmentedControl: SegmentedControlButtonDelegate {
	
	func didTapControlButton(_ sender: SegmentedControlButton) {
		guard let item = sender.index else { return }
		
		segmentButtons.forEachOtherThan(at: item) { button in
			button.isSelected = false
		}
		
		
		let indexPath = IndexPath(item: item, section: 0)
		delegate.didSelectItem(indexPath)
	}
	
}

