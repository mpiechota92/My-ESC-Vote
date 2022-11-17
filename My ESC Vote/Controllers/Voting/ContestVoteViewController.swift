//
//  ContestVoteViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import UIKit

class ContestVoteViewController: UIViewController {
	
	private var secondaryBackground: UIView = {
		let view = UIView()
		view.backgroundColor = Color.Primary.navy
		return view
	}()
	
	private var countriesTableView: UITableView = {
		let tbview = UITableView()
		tbview.register(UINib(nibName: "CountryVoteCell", bundle: nil), forCellReuseIdentifier: "CountryVoteCell")
		
		return tbview
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	func setupUI() {
		
		view.backgroundColor = Color.Primary.darkNavy
		
		view.addSubview(secondaryBackground)
		secondaryBackground.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide)
		}
		
		
		
	}
	
}
