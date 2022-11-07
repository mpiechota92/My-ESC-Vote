//
//  ContestTableViewCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class ContestTableViewCell: UITableViewCell {

	@IBOutlet weak var cellBubble: UIView!
	@IBOutlet weak var contestNameLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	
	var viewModel: ContestViewModel?
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		cellBubble.layer.cornerRadius = cellBubble.frame.size.height / 5
//		contentView.snp.makeConstraints { make in
//			make.edges.equalToSuperview().inset(20)
//		}
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func setup() {
		contestNameLabel.font = UIFont(name: Constants.Design.Font.Name.gothamBold, size: Constants.Design.Font.Size.extraLarge)
		countryNameLabel.font = UIFont(name: Constants.Design.Font.Name.gotham, size: Constants.Design.Font.Size.large)
		
		contestNameLabel.text = viewModel?.getContestTitle()
		countryNameLabel.text = "Armenia"
	}
	
	
}
