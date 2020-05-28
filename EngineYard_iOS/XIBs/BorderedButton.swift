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
    private let normalColor: CGColor = UIColor.white.cgColor
    private let disabledColor: CGColor = UIColor.lightGray.cgColor
    private let disabledOpacity: Float = 0.35

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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        self.setNeedsDisplay()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    // MARK: Setup button

    private func setupButton() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.lightGray, for: .disabled)
        self.titleLabel?.textAlignment = .center

        if !isEnabled {
            layer.borderColor = disabledColor
            layer.opacity = disabledOpacity
        }
        else {
            layer.borderColor = normalColor
            layer.opacity = 1.0
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = normalColor
                layer.opacity = 1.0
            }
            else {
                layer.borderColor = disabledColor
                layer.opacity = disabledOpacity
            }
        }
    }


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        // Drawing code
        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }

}
