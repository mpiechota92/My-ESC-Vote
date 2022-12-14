//
//  VoteMenuCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class VoteMenuCell: UICollectionViewCell {
    
	let menuTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Menu Item"
		label.textAlignment = .center
		label.textColor = Color.Primary.accentColor
		
		return label
	}()
	
	override var isSelected: Bool {
		didSet {
			menuTitleLabel.textColor = isSelected ? Color.Primary.accentColor : Color.Primary.dimmedAccentColor
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(menuTitleLabel)
		
		menuTitleLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
