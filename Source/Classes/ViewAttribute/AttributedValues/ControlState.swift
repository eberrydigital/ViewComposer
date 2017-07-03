//
//  ControlState.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-05-31.
//
//

import UIKit

public protocol ControlState {
    var state: UIControlState { get }
    
    var title: String? { get set }
    var titleColor: UIColor? { get set }
    var image: UIImage? { get set }
    init(title: String?, titleColor: UIColor?, image: UIImage?)
}

extension ControlState {
    
    public init(_ title: String) {
        self.init(title: title, titleColor: nil, image: nil)
    }
    
    /// Use together with some other state with title. Title from that other state will be copied over by ViewComposer
    public init(_ titleColor: UIColor) {
        self.init(title: nil, titleColor: titleColor, image: nil)
    }
    
    public init(_ image: UIImage) {
        self.init(title: nil, titleColor: nil, image: image)
    }
    
    public init(_ title: String, _ titleColor: UIColor) {
        self.init(title: title, titleColor: titleColor, image: nil)
    }
    
    public init(_ title: String, _ image: UIImage) {
        self.init(title: title, titleColor: nil, image: image)
    }
    
    public init(_ title: String, _ titleColor: UIColor, _ image: UIImage) {
        self.init(title: title, titleColor: titleColor, image: image)
    }
}

public struct Normal: ControlState {
    public let state: UIControlState = .normal
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Highlighted: ControlState {
    public let state: UIControlState = .highlighted
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Disabled: ControlState {
    public let state: UIControlState = .disabled
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Selected: ControlState {
    public let state: UIControlState = .selected
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Focused: ControlState {
    public let state: UIControlState = .focused
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Application: ControlState {
    public let state: UIControlState = .application
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

public struct Reserved: ControlState {
    public let state: UIControlState = .reserved
    
    public var title: String?
    public var titleColor: UIColor?
    public var image: UIImage?
    
    public init(title: String?, titleColor: UIColor?, image: UIImage?) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}
