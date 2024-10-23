//
//  SOSUILabel.swift
//  SOSFramework
//
//  Created by Smin on 12/23/23.
//

import UIKit

public class SOSUILabel: UILabel {

    public override func awakeFromNib() {
        super.awakeFromNib()

        isUserInteractionEnabled = true
        addGestureRecognizer(
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPress(_:))
            )
        )
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    // MARK: - UIResponderStandardEditActions
    
    public override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
    
    // MARK: - Long-press Handler
    
    @objc func handleLongPress(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == .began,
            let recognizerView = recognizer.view,
            let recognizerSuperview = recognizerView.superview {
            recognizerView.becomeFirstResponder()
            UIMenuController.shared.showMenu(from:recognizerSuperview, rect:recognizerView.frame)
        }
    }

}
