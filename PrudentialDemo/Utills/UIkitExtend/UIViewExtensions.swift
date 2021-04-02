//
//  UIViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//
#if canImport(UIKit) && !os(watchOS)
import UIKit
public extension UIView {
    // =================================================================
    //                              画圆角/阴影等
    // =================================================================
    // MARK: - 画圆角/阴影
    /// SwifterSwift: Set some or all corners radiuses of view.
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    ///   - borderWidth: 边框宽度,传入大于0时才绘制边框
    ///   - borderColor: 边框颜色
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat, borderWidth: CGFloat = -1.0, borderColor: UIColor = UIColor.gray) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        if borderWidth > 0.0 {
            // 移除之前的边框layer
            for layer in layer.sublayers ?? [] {
                if layer is CAShapeLayer && layer.name == "borderLayer" {
                    layer.removeFromSuperlayer()
                }
            }
            let borderLayer = CAShapeLayer()
            borderLayer.name = "borderLayer"
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = backgroundColor?.cgColor
            borderLayer.path = maskPath.cgPath
            layer.insertSublayer(borderLayer, at: 0)
        }
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    /// SwifterSwift: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    /// SwifterSwift: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    /// SwifterSwift: Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    /// SwifterSwift: x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    /// SwifterSwift: y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    /// SwifterSwift: top of view.
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    /// SwifterSwift: left of view.
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    /// SwifterSwift: right of view.
    var right: CGFloat {
        get {
            return (frame.origin.x + frame.size.width)
        }
        set {
            var frame = self.frame
            frame.origin.x = (newValue - frame.size.width)
            self.frame = frame
        }
    }
    /// SwifterSwift: bottom of view.
    var bottom: CGFloat {
        get {
            return (frame.origin.y + frame.size.height)
        }
        set {
            var frame = self.frame
            frame.origin.x = (newValue - frame.size.height)
            self.frame = frame
        }
    }
    /// SwifterSwift: centerX of view.
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.x)
        }
    }
    /// SwifterSwift: centerY of view.
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
}
#endif
