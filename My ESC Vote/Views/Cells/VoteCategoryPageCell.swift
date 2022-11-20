//
//  VoteCategoryPageCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class VoteCategoryPageCell: UICollectionViewCell {
    
	var view: UIView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(view)
		view.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	
	
	
	
	required init?(coder: NSCoder) {
		fatalError()
	}
}
