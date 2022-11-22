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
	
	var collectionView: UICollectionView!
	var segmentButtons: [SegmentedControlButton]!
	
	@IBOutlet weak var segmentsStackVIew: UIStackView!
	
	var delegate: CollectionViewSegmentedControlDelegate!
	
	func setup(with segments: [String]) {
		var segmentButtons: [SegmentedControlButton];
		
		segmentButtons = segments.map(SegmentedControlButton.init)
		
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
		collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom)
		delegate.didSelectItem(indexPath)
	}
	
}

