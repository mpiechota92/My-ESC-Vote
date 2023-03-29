//
//  File.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 29/03/2023.
//

import Foundation
import UIKit

class BasePageCell: UICollectionViewCell, HavingNib {
	weak var parent: BasePagedViewController?
	weak var basePageView: BasePageView?
}
