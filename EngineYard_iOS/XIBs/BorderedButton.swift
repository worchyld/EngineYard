//
//  BorderedButton.swift
//  EngineYard
//
//  Created by Amarjit on 28/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var selectedBorderColor : UIColor = UIColor.blue {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var highlightedBorderColor : UIColor = UIColor.systemRed {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    // MARK: Setup button

    private func setupButton() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .disabled)
        self.setTitleColor(.red, for: .highlighted)


        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.titleLabel?.textAlignment = .center
    }


    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = selectedBorderColor.cgColor
            }
            else {
                layer.borderColor = borderColor.cgColor
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = UIColor.blue.cgColor //enabledBorderColor.cgColor
                layer.opacity = 1.0
            }
            else {
                layer.borderColor = UIColor.lightGray.cgColor
                layer.opacity = 0.5
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.borderColor = highlightedBorderColor.cgColor
            }
//            else {
//                layer.borderColor = UIColor.white.cgColor
//            }
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
