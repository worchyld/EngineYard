//
//  EY+Notification.swift
//  EngineYard
//
//  Created by Amarjit on 27/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

class NotificationListener: NSObject {
    @objc func handleDidSaveNotification(_ notification:Notification) {
        print("* Did save notification received: \(notification)")
    }
}
