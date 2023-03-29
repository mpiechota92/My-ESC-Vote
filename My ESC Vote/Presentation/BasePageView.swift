//
//  BasePageView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 21/03/2023.
//

import Foundation
import UIKit

protocol BasePageViewProtocol: HavingStoryboard {
	var viewModelType: ListViewModel.Type { get }
	var viewModel: ListViewModelProtocol? { get set }
	func getViewModelInstance() -> ListViewModelProtocol
}

class BasePageView: UIViewController, HavingStoryboard {
	
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Public properties
	private var viewModel: ListViewModelProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerCell()
		setupTableView()
	}
	
	func fill(with viewModel: ListViewModelProtocol) {
		self.viewModel = viewModel
	}
	
	private func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.showsVerticalScrollIndicator = false
	}
	
	// Must override
	func registerCell() {
		fatalError()
	}
}

extension BasePageView: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		fatalError()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		fatalError()
	}
}
