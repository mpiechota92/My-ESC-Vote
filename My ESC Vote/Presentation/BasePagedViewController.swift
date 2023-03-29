//
//  BasePagedViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 21/03/2023.
//

import Foundation
import UIKit

protocol BasePagedViewControllerProtocol: HavingStoryboard {
	var categories: Categories? { get set }
}

class BasePagedViewController: UIViewController, BasePagedViewControllerProtocol {
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var categoriesControl: UISegmentedControl!
	@IBOutlet weak var pagesCollectionView: UICollectionView!
	
	var segmentActionHandler: ((_ action: UIAction) -> Void)?
	var categoryType = (any CategoryProtocol).self
	
	private var pageLists: [String: ListViewModelProtocol] = [:]
	private var pageView: BasePageView?
	
	var categories: Categories?
	var listViewModel: ListViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupData()
		setupUI()
		customSetup()
		pagesCollectionView.reloadData()
	}
	
	func setupData() {
		guard let categories = categories?.allCases() else { return }
		
		categories.forEach { category in
			let vc = BasePageView.instantiateViewController()
			vc.fill(with: self.listViewModel ?? ListViewModel())
			self.addChild(vc)
		}
	}
	
	private func setupUI() {
		setupCategories()
		setupPages()
	}
	
	func customSetup() {
		
	}
	
	private func setupCategories() {
		categoriesControl.removeAllSegments()
		guard let categories = categories?.allCases() else { return }
		
		let handler = segmentActionHandler ?? handleSegmentSelected(_:)
		let action = UIAction(handler: handler)
		
		for (index, category) in categories.enumerated() {
			categoriesControl.setAction(action, forSegmentAt: index)
			categoriesControl.setTitle(category, forSegmentAt: index)
		}
		
		categoriesControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.Name.metropolisThin, size: Font.Size.small)!], for: .normal)
	}
	
	private func setupPages() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		
		
	}
	
	@objc private func handleSegmentSelected(_ action: UIAction) {
		let index = categoriesControl.selectedSegmentIndex
		let indexPath = IndexPath(item: index, section: 0)
		
		pagesCollectionView.isPagingEnabled = false
		pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		pagesCollectionView.isPagingEnabled = true
	}
}
