
import Foundation
import UIKit

@IBDesignable public class RoundedView: UIView {
    /// Border radius
    @IBInspectable public var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius
        }
    }
}
