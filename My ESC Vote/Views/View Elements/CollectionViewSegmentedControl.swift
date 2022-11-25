//
//  CollectionViewSegmentedControl.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 22/11/2022.
//

import UIKit

protocol CollectionViewSegmentedControlDelegate: AnyObject {
	
	func didSelectItem(_ indexPath: IndexPath)
	
}

class CollectionViewSegmentedControl: UIView {
	
	var segmentButtons: [SegmentedControlButton]!
	
	@IBOutlet weak var segmentsStackVIew: UIStackView!
	
	weak var delegate: CollectionViewSegmentedControlDelegate!
	
	func setup(with segments: [String]) {
		var segmentButtons: [SegmentedControlButton];
		
		segmentButtons = segments.map { segment in
			let button: SegmentedControlButton = .instanceFromNib()
			button.delegate = self
			button.title = segment
			
			return button
		}
		
		self.segmentButtons = segmentButtons
		
		setupUI()
	}
	
	private func setupUI() {
		segmentsStackVIew.distribution = .fillEqually
		segmentsStackVIew.alignment = .center
		segmentsStackVIew.spacing = 10
		
		print(self.frame.height)
		print(segmentsStackVIew.frame.height)
		
		for (index, button) in segmentButtons.enumerated() {
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


extension CollectionViewSegmentedControl: PagesCollectionViewDelegate {
	
	func didSelectItem(at index: Int) {
		segmentButtons.forEachOtherThan(at: index) { button in
			button.isSelected = false
		}
		
		segmentButtons[index].isSelected = true
	}
	
}
