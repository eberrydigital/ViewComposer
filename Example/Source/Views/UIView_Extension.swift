//
//  UIView_Extension.swift
//  Example
//
//  Created by Alexander Cyon on 2017-06-11.
//  Copyright © 2017 Alexander Cyon. All rights reserved.
//

import UIKit

extension UIView {
    func pinEdges(to view: UIView) {
        view.addConstraint(self.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(self.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        view.addConstraint(self.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        view.addConstraint(self.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}
