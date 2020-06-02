//
//  EY+ImageView.swift
//  EngineYard
//
//  Created by Amarjit on 09/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true

        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}

extension UIImage {

    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }

    func resize(_ size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        return redraw(in: rect)
    }

    func redraw(in rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return nil }

        let rect = CGRect(origin: .zero, size: size)
        let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.size.height)

        context.concatenate(flipVertical)
        context.draw(cgImage, in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func circled(forRadius radius: CGFloat) -> UIImage? {
        let rediusSize = CGSize(width: radius, height: radius)
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return nil }

        let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.size.height)
        context.concatenate(flipVertical)

        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.allCorners], cornerRadii: rediusSize)
        context.addPath(bezierPath.cgPath)
        context.clip()

        context.drawPath(using: .fillStroke)
        context.draw(cgImage, in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }


}
