//
//  EY+ViewController.swift
//  EngineYard
//
//  Created by Amarjit on 22/12/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
//
//    func showAlert(message: Message) {
//
//        guard let title = message.title else {
//            return
//        }
//        guard let message = message.message else {
//            return
//        }
//
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okString = NSLocalizedString("OK", comment: "OK")
//
//        let actionOK = UIAlertAction(title: okString, style: .default) { (action) in
//            alertController.dismiss(animated: true, completion: nil)
//        }
//
//        alertController.addAction(actionOK)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
}

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}

typealias NavigationBackClosure = (() -> ())

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
}
