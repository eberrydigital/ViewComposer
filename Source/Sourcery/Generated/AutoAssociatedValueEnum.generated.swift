// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

public protocol AssociatedValueEnumExtractor {
    var associatedValue: Any? { get }
}

public extension AssociatedValueEnumExtractor {
    func associatedValueTyped<T>() -> T? {
        if let value = associatedValue as? T {
            return value
        } else if let recursive = associatedValue as? AssociatedValueEnumExtractor, let value = recursive.associatedValue as? T {
            return value
        } 
        return nil
    }
}

public protocol StrippedRepresentation: RawRepresentable, Equatable, Hashable {}
public protocol AssociatedValueStrippable: Equatable {
    associatedtype Stripped: StrippedRepresentation
    var stripped: Stripped { get }
}

        extension LayoutPriority: AssociatedValueEnumExtractor {
            public var associatedValue: Any? {
                switch self {
                            case .required: return nil
                            case .low: return nil
                            case .high: return nil
                                case .custom(let custom):
                                    return custom
                }
            }

                    var custom: Float? {
                        switch self {
                            case .custom(let custom):
                                return custom
                            default:
                                return nil
                        }
                    }
        }

        public enum LayoutPriorityStripped: String, StrippedRepresentation {
            case required
            case low
            case high
            case custom
        } 

        extension LayoutPriorityStripped {
            public var hashValue: Int {
                return rawValue.hashValue
            }

        }

        extension LayoutPriority: Hashable {
            public var hashValue: Int {
                return stripped.hashValue
            }
        }
        extension LayoutPriority: AssociatedValueStrippable {
        	public static func == (lhs: LayoutPriority, rhs: LayoutPriority) -> Bool {
        	    return lhs.stripped == rhs.stripped
        	}
            public typealias Stripped = LayoutPriorityStripped
            public var stripped: Stripped {
        		switch self {
        			 case .required:
        				return .required
        			 case .low:
        				return .low
        			 case .high:
        				return .high
        			 case .custom:
        				return .custom
        		}
        	}
        }

        extension ViewAttribute: AssociatedValueEnumExtractor {
            public var associatedValue: Any? {
                switch self {
                                case .custom(let custom):
                                    return custom
                                case .isHidden(let isHidden):
                                    return isHidden
                                case .backgroundColor(let backgroundColor):
                                    return backgroundColor
                                case .cornerRadius(let cornerRadius):
                                    return cornerRadius
                                case .radius(let radius):
                                    return radius
                                case .verticalHugging(let verticalHugging):
                                    return verticalHugging
                                case .verticalCompression(let verticalCompression):
                                    return verticalCompression
                                case .horizontalHugging(let horizontalHugging):
                                    return horizontalHugging
                                case .horizontalCompression(let horizontalCompression):
                                    return horizontalCompression
                                case .contentMode(let contentMode):
                                    return contentMode
                                case .height(let height):
                                    return height
                                case .width(let width):
                                    return width
                                case .text(let text):
                                    return text
                                case .font(let font):
                                    return font
                                case .textColor(let textColor):
                                    return textColor
                                case .`case`(let `case`):
                                    return `case`
                                case .textAlignment(let textAlignment):
                                    return textAlignment
                                case .placeholder(let placeholder):
                                    return placeholder
                                case .image(let image):
                                    return image
                                case .isScrollEnabled(let isScrollEnabled):
                                    return isScrollEnabled
                                case .states(let states):
                                    return states
                                case .target(let target):
                                    return target
                                case .axis(let axis):
                                    return axis
                                case .distribution(let distribution):
                                    return distribution
                                case .alignment(let alignment):
                                    return alignment
                                case .spacing(let spacing):
                                    return spacing
                                case .margin(let margin):
                                    return margin
                                case .marginsRelative(let marginsRelative):
                                    return marginsRelative
                                case .baselineRelative(let baselineRelative):
                                    return baselineRelative
                                case .arrangedSubviews(let arrangedSubviews):
                                    return arrangedSubviews
                }
            }

                    var custom: BaseAttributed? {
                        switch self {
                            case .custom(let custom):
                                return custom
                            default:
                                return nil
                        }
                    }
                    var isHidden: Bool? {
                        switch self {
                            case .isHidden(let isHidden):
                                return isHidden
                            default:
                                return nil
                        }
                    }
                    var backgroundColor: UIColor? {
                        switch self {
                            case .backgroundColor(let backgroundColor):
                                return backgroundColor
                            default:
                                return nil
                        }
                    }
                    var cornerRadius: CGFloat? {
                        switch self {
                            case .cornerRadius(let cornerRadius):
                                return cornerRadius
                            default:
                                return nil
                        }
                    }
                    var radius: Radius? {
                        switch self {
                            case .radius(let radius):
                                return radius
                            default:
                                return nil
                        }
                    }
                    var verticalHugging: LayoutPriority? {
                        switch self {
                            case .verticalHugging(let verticalHugging):
                                return verticalHugging
                            default:
                                return nil
                        }
                    }
                    var verticalCompression: LayoutPriority? {
                        switch self {
                            case .verticalCompression(let verticalCompression):
                                return verticalCompression
                            default:
                                return nil
                        }
                    }
                    var horizontalHugging: LayoutPriority? {
                        switch self {
                            case .horizontalHugging(let horizontalHugging):
                                return horizontalHugging
                            default:
                                return nil
                        }
                    }
                    var horizontalCompression: LayoutPriority? {
                        switch self {
                            case .horizontalCompression(let horizontalCompression):
                                return horizontalCompression
                            default:
                                return nil
                        }
                    }
                    var contentMode: UIViewContentMode? {
                        switch self {
                            case .contentMode(let contentMode):
                                return contentMode
                            default:
                                return nil
                        }
                    }
                    var height: CGFloat? {
                        switch self {
                            case .height(let height):
                                return height
                            default:
                                return nil
                        }
                    }
                    var width: CGFloat? {
                        switch self {
                            case .width(let width):
                                return width
                            default:
                                return nil
                        }
                    }
                    var text: String? {
                        switch self {
                            case .text(let text):
                                return text
                            default:
                                return nil
                        }
                    }
                    var font: UIFont? {
                        switch self {
                            case .font(let font):
                                return font
                            default:
                                return nil
                        }
                    }
                    var textColor: UIColor? {
                        switch self {
                            case .textColor(let textColor):
                                return textColor
                            default:
                                return nil
                        }
                    }
                    var `case`: Case? {
                        switch self {
                            case .`case`(let `case`):
                                return `case`
                            default:
                                return nil
                        }
                    }
                    var textAlignment: NSTextAlignment? {
                        switch self {
                            case .textAlignment(let textAlignment):
                                return textAlignment
                            default:
                                return nil
                        }
                    }
                    var placeholder: String? {
                        switch self {
                            case .placeholder(let placeholder):
                                return placeholder
                            default:
                                return nil
                        }
                    }
                    var image: UIImage? {
                        switch self {
                            case .image(let image):
                                return image
                            default:
                                return nil
                        }
                    }
                    var isScrollEnabled: Bool? {
                        switch self {
                            case .isScrollEnabled(let isScrollEnabled):
                                return isScrollEnabled
                            default:
                                return nil
                        }
                    }
                    var states: [ControlState]? {
                        switch self {
                            case .states(let states):
                                return states
                            default:
                                return nil
                        }
                    }
                    var target: Actor? {
                        switch self {
                            case .target(let target):
                                return target
                            default:
                                return nil
                        }
                    }
                    var axis: UILayoutConstraintAxis? {
                        switch self {
                            case .axis(let axis):
                                return axis
                            default:
                                return nil
                        }
                    }
                    var distribution: UIStackViewDistribution? {
                        switch self {
                            case .distribution(let distribution):
                                return distribution
                            default:
                                return nil
                        }
                    }
                    var alignment: UIStackViewAlignment? {
                        switch self {
                            case .alignment(let alignment):
                                return alignment
                            default:
                                return nil
                        }
                    }
                    var spacing: CGFloat? {
                        switch self {
                            case .spacing(let spacing):
                                return spacing
                            default:
                                return nil
                        }
                    }
                    var margin: CGFloat? {
                        switch self {
                            case .margin(let margin):
                                return margin
                            default:
                                return nil
                        }
                    }
                    var marginsRelative: Bool? {
                        switch self {
                            case .marginsRelative(let marginsRelative):
                                return marginsRelative
                            default:
                                return nil
                        }
                    }
                    var baselineRelative: Bool? {
                        switch self {
                            case .baselineRelative(let baselineRelative):
                                return baselineRelative
                            default:
                                return nil
                        }
                    }
                    var arrangedSubviews: [UIView]? {
                        switch self {
                            case .arrangedSubviews(let arrangedSubviews):
                                return arrangedSubviews
                            default:
                                return nil
                        }
                    }
        }

        public enum ViewAttributeStripped: String, StrippedRepresentation {
            case custom
            case isHidden
            case backgroundColor
            case cornerRadius
            case radius
            case verticalHugging
            case verticalCompression
            case horizontalHugging
            case horizontalCompression
            case contentMode
            case height
            case width
            case text
            case font
            case textColor
            case `case`
            case textAlignment
            case placeholder
            case image
            case isScrollEnabled
            case states
            case target
            case axis
            case distribution
            case alignment
            case spacing
            case margin
            case marginsRelative
            case baselineRelative
            case arrangedSubviews
        } 

        extension ViewAttributeStripped {
            public var hashValue: Int {
                return rawValue.hashValue
            }

        }

        extension ViewAttribute: Hashable {
            public var hashValue: Int {
                return stripped.hashValue
            }
        }
        extension ViewAttribute: AssociatedValueStrippable {
        	public static func == (lhs: ViewAttribute, rhs: ViewAttribute) -> Bool {
        	    return lhs.stripped == rhs.stripped
        	}
            public typealias Stripped = ViewAttributeStripped
            public var stripped: Stripped {
        		switch self {
        			 case .custom:
        				return .custom
        			 case .isHidden:
        				return .isHidden
        			 case .backgroundColor:
        				return .backgroundColor
        			 case .cornerRadius:
        				return .cornerRadius
        			 case .radius:
        				return .radius
        			 case .verticalHugging:
        				return .verticalHugging
        			 case .verticalCompression:
        				return .verticalCompression
        			 case .horizontalHugging:
        				return .horizontalHugging
        			 case .horizontalCompression:
        				return .horizontalCompression
        			 case .contentMode:
        				return .contentMode
        			 case .height:
        				return .height
        			 case .width:
        				return .width
        			 case .text:
        				return .text
        			 case .font:
        				return .font
        			 case .textColor:
        				return .textColor
        			 case .`case`:
        				return .`case`
        			 case .textAlignment:
        				return .textAlignment
        			 case .placeholder:
        				return .placeholder
        			 case .image:
        				return .image
        			 case .isScrollEnabled:
        				return .isScrollEnabled
        			 case .states:
        				return .states
        			 case .target:
        				return .target
        			 case .axis:
        				return .axis
        			 case .distribution:
        				return .distribution
        			 case .alignment:
        				return .alignment
        			 case .spacing:
        				return .spacing
        			 case .margin:
        				return .margin
        			 case .marginsRelative:
        				return .marginsRelative
        			 case .baselineRelative:
        				return .baselineRelative
        			 case .arrangedSubviews:
        				return .arrangedSubviews
        		}
        	}
        }


extension Collection where Iterator.Element: AssociatedValueStrippable, Iterator.Element: Hashable {
    func contains<Stripped: StrippedRepresentation>(_ element: Stripped) -> Bool where Stripped == Iterator.Element.Stripped {
        return map { $0.stripped }.contains(element)
    }
}

extension Collection where Iterator.Element: AssociatedValueStrippable, Iterator.Element: AssociatedValueEnumExtractor {
    func associatedValue<AssociatedValue, Stripped: StrippedRepresentation>(_ element: Stripped) -> AssociatedValue? where Stripped == Iterator.Element.Stripped {
        for item in self {
            guard item.stripped == element else { continue }
            return item.associatedValueTyped()
        }
        return nil
    }
}
