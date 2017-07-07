//
//  Button.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-05-31.
//
//

import UIKit

open class Button: UIButton, Composable {
    
    open let style: ViewStyle
    
    required public init(_ style: ViewStyle? = nil) {
        let style = style.merge(superiorTo: .default)
        self.style = style
        super.init(frame: .zero)
        compose(with: style)
    }
    
    required public init?(coder: NSCoder) { requiredInit() }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutSubviews(with: style)
    }
}

private extension ViewStyle {
    @nonobjc static let `default`: ViewStyle = [.roundedBy(.height), .verticalHugging(.high), .verticalCompression(.high)]
}
