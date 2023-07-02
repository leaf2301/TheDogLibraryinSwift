//
//  Extensions.swift
//
//
//  Created by Tran Hieu on 15/06/2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
