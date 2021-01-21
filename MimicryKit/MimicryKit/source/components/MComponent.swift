//
//  MComponent.swift
//  MimicryKit
//
//  Created by zyf on 2021/1/19.
//

import UIKit

public enum MComponentStyle {
    case circle
    case rectangle(corner: CGFloat)
}

public protocol MComponents {
}

extension MComponents where Self: UIView {
    public func refreshShadow(isOn: Bool, layer1: CALayer, layer2: CALayer, layer3: CALayer, backgroundView: UIView, style: MComponentStyle) {
        if isOn {
            let path1: UIBezierPath
            let innerPart1: UIBezierPath
            switch style {
            case .circle:
                path1 = UIBezierPath(roundedRect: layer1.bounds.insetBy(dx: -10, dy: -10), cornerRadius: layer1.bounds.width / 2)
                innerPart1 = UIBezierPath(roundedRect: layer1.bounds, cornerRadius: layer1.bounds.width / 2).reversing()
            case let .rectangle(corner):
                path1 = UIBezierPath(roundedRect: layer1.bounds.insetBy(dx: -10, dy: -10), cornerRadius: corner)
                innerPart1 = UIBezierPath(roundedRect: layer1.bounds, cornerRadius: corner).reversing()
            }
            path1.append(innerPart1)
            layer1.masksToBounds = true
            layer1.shadowPath = path1.cgPath
            layer1.shadowOffset = .init(width: -3, height: -3)
            layer1.shadowOpacity = 1
            layer1.shadowColor = UIColor(r: 48, g: 52, b: 58).cgColor
            layer1.shadowRadius = 2

            let path2: UIBezierPath
            let innerPart2: UIBezierPath
            switch style {
            case .circle:
                path2 = UIBezierPath(roundedRect: layer2.bounds.insetBy(dx: -10, dy: -10), cornerRadius: layer2.bounds.width / 2)
                innerPart2 = UIBezierPath(roundedRect: layer2.bounds, cornerRadius: layer2.bounds.width / 2).reversing()
            case let .rectangle(corner):
                path2 = UIBezierPath(roundedRect: layer2.bounds.insetBy(dx: -10, dy: -10), cornerRadius: corner)
                innerPart2 = UIBezierPath(roundedRect: layer2.bounds, cornerRadius: corner).reversing()
            }
            path2.append(innerPart2)
            layer2.masksToBounds = true
            layer2.shadowPath = path2.cgPath
            layer2.shadowOffset = .init(width: 3, height: 3)
            layer2.shadowOpacity = 1
            layer2.shadowColor = UIColor(r: 36, g: 38, b: 44).cgColor
            layer2.shadowRadius = 2

            backgroundView.layer.masksToBounds = true
            layer3.opacity = 0
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer3.opacity = 1
            let path: UIBezierPath
            switch style {
            case .circle:
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: backgroundView.layer.cornerRadius)
            case let .rectangle(corner):
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: corner)
            }
            layer1.shadowPath = path.cgPath
            layer2.shadowPath = path.cgPath
            layer1.shadowOffset = .init(width: -3, height: -3)
            layer2.shadowOffset = .init(width: 3, height: 3)
            layer1.masksToBounds = false
            layer1.shadowColor = UIColor(r: 48, g: 52, b: 58).cgColor
            layer2.masksToBounds = false
            layer2.shadowColor = UIColor(r: 36, g: 38, b: 44).cgColor
            CATransaction.commit()

            layer1.shadowOpacity = 1
            layer1.shadowRadius = 2
            layer2.shadowOpacity = 1
            layer2.shadowRadius = 2

            backgroundView.layer.masksToBounds = false
        }
    }
}
