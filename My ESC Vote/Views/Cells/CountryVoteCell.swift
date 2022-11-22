//
//  CountryVoteCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import UIKit

class CountryVoteCell: UITableViewCell {
	
	static let estimatedRowHeight = 61.0
	static let identifier = "CountryVoteCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "CountryVoteCell",
					 bundle: nil)
	}
		
	
	@IBOutlet weak var countryImageView: UIImageView!
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var artistNameLabel: UILabel!
	
	var viewModel: CountryViewModel? {
		didSet {
			songNameLabel.text = viewModel?.country.song
			artistNameLabel.text = viewModel?.country.artist
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	
}
