//
//  StackViewLabelView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/11/2022.
//

import UIKit
import SnapKit

enum LabelType {
	case error
	case info
	case alert
	case success
}

class LabelView: UIView {
	
	var contentView: UIView!
	var mainLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		
		return label
	}()
	
	var labelType: LabelType? {
		willSet {
			switch newValue {
			case .error:
				mainLabel.textColor = Constants.Design.Font.Color.error
			case .success:
				mainLabel.textColor = Constants.Design.Font.Color.succsess
			default:
				mainLabel.textColor = Constants.Design.Color.accentColor
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		addSubview(mainLabel)
		
		mainLabel.snp.makeConstraints { make in
			make.size.edges.equalToSuperview()
		}
		
		mainLabel.font = UIFont(
			name: Constants.Design.Font.Name.gothamBold,
			size: Constants.Design.Font.Size.small
		)

		self.backgroundColor = .init(white: 1.0, alpha: 0.0)
		self.isHidden = true
	}
}
