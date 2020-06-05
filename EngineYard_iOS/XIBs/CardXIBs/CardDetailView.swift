//
//  CardDetailView.swift
//  EngineYard
//
//  Created by Amarjit on 05/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}

extension UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func instantiate(autolayout: Bool = true) -> Self {
        // generic helper function
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
}

class CardDetailView: UIView {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet var btnBuyBtnCollection: [BorderedButton]!

    static func nib() -> UINib {
        return UINib(nibName: "CardDetailView", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    @IBAction func btnBuyDidPress(_ sender: UIButton) {
        print("You pressed buy on tag: \(sender.tag)")
    }

   
    

    /*

    override func initialize() {
        super.initialize()

        // first: load the view hierarchy to get proper outlets
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)

        // next: append the container to our view
        self.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }*/
}
