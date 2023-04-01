//
//  ContestantsViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/04/2023.
//

import Foundation
import UIKit

class ContestantsViewController: UIViewController, HavingStoryboard {
	
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var categoriesControl: UISegmentedControl!
	@IBOutlet weak var pagesCollectionView: UICollectionView!
	
	private var viewModel: ContestantsListViewModel!
	private var menuButton: MenuButton = MenuButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		pagesCollectionView.reloadData()
	}
	
	func fill(with viewModel: ContestantsListViewModel) {
		self.viewModel = viewModel
	}
	
	private func setupUI() {
		setupCategoriesControl()
		setupMenuButton()
	}
	
	private func setupCategoriesControl() {
		categoriesControl.removeAllSegments()
		
		for (index, category) in ContestCategory.allCases.enumerated() {
			self.categoriesControl.setAction(UIAction(handler: handleSegmentSelected(_:)), forSegmentAt: index)
			self.categoriesControl.setTitle(category.rawValue, forSegmentAt: index)
			
			let vc = ContestantsPageView.instantiateViewController()
			let viewModel = BaseContestantsListViewModel(for: category)
			vc.fill(with: viewModel)
			self.addChild(vc)
		}
		
		categoriesControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.Name.metropolisThin, size: Font.Size.small)!], for: .normal)
	}
	
	private func setupMenuButton() {
		menuButton.parent = self
		menuButton.setupButton(for: navigationController, with: UIStoryboard(name: Self.identifier, bundle: nil))
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
	}
	
	@objc private func handleSegmentSelected(_ action: UIAction) {
		let index = categoriesControl.selectedSegmentIndex
		let indexPath = IndexPath(item: index, section: 0)
		
		pagesCollectionView.isPagingEnabled = false
		pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		pagesCollectionView.isPagingEnabled = true
	}
}
