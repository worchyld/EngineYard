//
//  EY+Notification.swift
//  EngineYard
//
//  Created by Amarjit on 04/03/2022.
//

import Foundation

class NotificationListener: NSObject {
    @objc func handleDidSaveNotification(_ notification:Notification) {
        print("* Notification received: \(notification)")
    }
}
