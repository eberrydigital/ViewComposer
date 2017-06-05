//
//  NestedStackViewsViewController.swift
//  ViewComposer-Example
//
//  Created by Alexander Cyon on 2017-05-30.
//  Copyright © 2017 Alexander Cyon. All rights reserved.
//

import UIKit
import ViewComposer

class NestedStackViewsViewController: UIViewController, StackViewOwner {
    private lazy var redButton = UIButton.make(.backgroundColor(.red), .text("Red"), .textColor(.blue))
    private lazy var blueButton: UIButton = make(.backgroundColor(.blue), .states([.normal("Blue", nil)]), .textColor(.red))
    private lazy var buttons: UIStackView = make(.arrangedSubviews([self.redButton, self.blueButton]), .distribution(.fillEqually))
    
    private lazy var yellowButton: UIButton = make(.backgroundColor(.yellow), .text("Yellow"), .textColor(.red))
    private lazy var label: UILabel = make(.text("Hey ViewComposer user"), .textAlignment(.center))
    
    lazy var stackView: UIStackView = make(.arrangedSubviews([self.buttons, self.yellowButton, self.label]), .axis(.vertical), .distribution(.fillEqually))
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "ViewComposer - Nested StackViews"
    }
}
