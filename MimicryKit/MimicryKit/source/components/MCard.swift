//
//  MCard.swift
//  MimicryKit
//
//  Created by zyf on 2021/1/19.
//

import UIKit

public class MCard: UIView, MComponents {
    private var layer1: CALayer = CALayer()
    private var layer2: CALayer = CALayer()
    private var layer3: CALayer = CALayer()
    public var backgroundView: UIView = UIView()

    public var style: MComponentStyle = .rectangle(corner: 5) {
        didSet {
            refreshView()
        }
    }

    public var isOn: Bool = false {
        didSet {
            refreshView()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        refreshView()
    }
}

extension MCard {
    public func refreshView() {
        backgroundView.frame = CGRect(origin: .zero, size: frame.size)
        backgroundView.backgroundColor = UIColor(r: 41, g: 45, b: 50)
        switch style {
        case .circle:
            var corner: CGFloat = 0
            if frame.width > frame.height {
                corner = frame.width / 2
            } else {
                corner = frame.height / 2
            }
            backgroundView.layer.cornerRadius = corner
            layer.cornerRadius = corner
        case let .rectangle(corner):
            backgroundView.layer.cornerRadius = corner
            layer.cornerRadius = corner
        }
        backgroundView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        backgroundView.layer.addSublayer(layer1)
        backgroundView.layer.addSublayer(layer2)
        backgroundView.layer.addSublayer(layer3)
        layer1.frame = backgroundView.bounds
        layer2.frame = backgroundView.bounds
        layer1.cornerRadius = backgroundView.layer.cornerRadius
        layer2.cornerRadius = backgroundView.layer.cornerRadius
        layer3.frame = backgroundView.bounds
        layer3.masksToBounds = true
        layer3.backgroundColor = backgroundView.backgroundColor?.cgColor
        layer3.cornerRadius = backgroundView.layer.cornerRadius
        refreshShadow(isOn: isOn, layer1: layer1, layer2: layer2, layer3: layer3, backgroundView: backgroundView, style: style)
    }
}

extension MCard {
    private func initView() {
        super.addSubview(backgroundView)
    }
}

extension MCard {
    @discardableResult public func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult public func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }

    @discardableResult public func style(_ style: MComponentStyle) -> Self {
        self.style = style
        return self
    }

    @discardableResult public func addTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}
