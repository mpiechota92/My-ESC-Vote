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
	@IBOutlet weak var countryNameLabel: UILabel!
	
	var viewModel: CountryViewModel? {
		didSet {
			guard let viewModel = viewModel else { return }
			let country = viewModel.country
			
			songNameLabel.text = country.song
			artistNameLabel.text = country.artist
			countryNameLabel.text = country.name
			countryImageView.image = UIImage(named: country.name)
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
