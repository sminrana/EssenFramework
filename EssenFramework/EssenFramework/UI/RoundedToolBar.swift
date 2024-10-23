
import Foundation
import UIKit

@IBDesignable public class RoundedToolBar: UIToolbar {
    /// Border radius
    @IBInspectable public var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
}
