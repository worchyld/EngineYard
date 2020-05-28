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

    /*
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    */

    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }

    /*
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
     */

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
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.setTitleColor(.white, for: UIControl.State.normal)
        self.setTitleColor(.systemBlue, for: .selected)
        self.setTitleColor(.systemBlue, for: .highlighted)
        self.setTitleColor(.systemBlue, for: .focused)
        self.setTitleColor(.darkGray, for: .disabled)
        self.sizeToFit()
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
