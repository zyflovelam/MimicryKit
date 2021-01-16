//
//  MButton.swift
//  MimicryKit
//
//  Created by zyf on 2021/1/16.
//

import UIKit

extension MButton {
    public enum `Type` {
        case `switch`
        case button
    }

    public struct Appearence {
        var backgroundColor: UIColor
        var selectedColor: UIColor
        var unselectedColor: UIColor
        var shadowColor: UIColor
        var style: Style

        var iconSize: CGSize = CGSize(width: 22, height: 22)

        var titleFont: UIFont = .systemFont(ofSize: 17)
        var titleColor: UIColor = UIColor(r: 143, g: 147, b: 155)

        static var `default`: Appearence = Appearence(backgroundColor: .init(r: 41, g: 45, b: 50), selectedColor: UIColor(r: 143, g: 147, b: 155), unselectedColor: UIColor(r: 143, g: 147, b: 155), shadowColor: UIColor(r: 48, g: 52, b: 58), style: .circle)
    }
}

extension MButton.Appearence {
    enum Style {
        case circle
        case rectangle
        case roundedRectangle(_ corner: CGFloat)
    }
}

public class MButton: UIView {
    var isOn: Bool = false {
        didSet {
            updateView()
        }
    }

    var type: Type = .switch {
        didSet {
            updateView()
        }
    }

    var icon: UIImage? {
        didSet {
            updateView()
        }
    }

    var title: String = "" {
        didSet {
            updateView()
        }
    }

    var appearence: Appearence = .default

    private var backgroundView: UIView = UIView()
    private var iconView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()

    public convenience init(type: Type, icon: UIImage? = nil, title: String = "") {
        self.init(frame: .zero)
        self.icon = icon
        self.title = title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        addSubview(iconView)
        addSubview(titleLabel)
        updateView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
}

extension MButton {
    private func updateView() {
        print("frame: \(frame)")
        backgroundView.frame = CGRect(origin: .zero, size: frame.size)
        switch appearence.style {
        case .circle:
            var corner: CGFloat = 0
            if frame.width > frame.height {
                corner = frame.width / 2
            } else {
                corner = frame.height / 2
            }
            backgroundView.layer.cornerRadius = corner
        case .rectangle:
            backgroundView.layer.cornerRadius = 0
        case let .roundedRectangle(corner):
            backgroundView.layer.cornerRadius = corner
        }
        backgroundView.backgroundColor = appearence.backgroundColor

        iconView.image = icon
        var origin: CGPoint = .zero
        if title == "" {
            origin = CGPoint(x: (frame.width - appearence.iconSize.width) / 2, y: (frame.height - appearence.iconSize.height) / 2)
        } else {
            // 有文字
        }

        iconView.frame = CGRect(origin: origin, size: appearence.iconSize)

        updateShadow()
    }

    private func updateShadow() {
        if isOn {
            // 点击了, 内阴影
        } else {
            // 没点击,外阴影
            let path: UIBezierPath
            switch appearence.style {
            case .circle:
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: backgroundView.layer.cornerRadius)
            case .rectangle:
                path = UIBezierPath(rect: backgroundView.bounds)
            case let .roundedRectangle(corner):
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: corner)
            }

//            backgroundView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            backgroundView.subviews.forEach { $0.removeFromSuperview() }

            let view1 = UIView(frame: CGRect(origin: .zero, size: backgroundView.frame.size))
            view1.layer.cornerRadius = backgroundView.layer.cornerRadius
            view1.layer.masksToBounds = false
            view1.layer.frame = CGRect(origin: .zero, size: backgroundView.frame.size)
            view1.layer.shadowOffset = .init(width: -5, height: -5)
            view1.layer.shadowOpacity = 1
            view1.layer.shadowColor = UIColor(r: 48, g: 52, b: 58).cgColor
            view1.layer.shadowRadius = 4
            view1.layer.shadowPath = path.cgPath
            view1.layer.needsDisplayOnBoundsChange = true

            let view2 = UIView(frame: CGRect(origin: .zero, size: backgroundView.frame.size))
            view2.layer.cornerRadius = backgroundView.layer.cornerRadius
            view2.layer.masksToBounds = false
            view2.layer.frame = CGRect(origin: .zero, size: backgroundView.frame.size)
            view2.layer.shadowOffset = .init(width: 5, height: 5)
            view2.layer.shadowOpacity = 1
            view2.layer.shadowColor = UIColor(r: 36, g: 38, b: 44).cgColor
            view2.layer.shadowRadius = 4
            view2.layer.shadowPath = path.cgPath
            view2.layer.needsDisplayOnBoundsChange = true
            
            backgroundView.addSubview(view1)
            backgroundView.addSubview(view2)
            
            let view3 = UIView(frame: CGRect(origin: .zero, size: backgroundView.frame.size))
            view3.backgroundColor = backgroundView.backgroundColor
            view3.layer.cornerRadius = backgroundView.layer.cornerRadius
            backgroundView.addSubview(view3)

//            backgroundView.layer.addSublayer(bottomLayer)
//            backgroundView.layer.addSublayer(topLayer)
//            backgroundView.layer.shadowOffset = .init(width: 15, height: 15)
//            backgroundView.layer.shadowOpacity = 1
//            backgroundView.layer.shadowColor = UIColor(r: 36, g: 38, b: 44).cgColor
//            backgroundView.layer.shadowRadius = 15
//            backgroundView.layer.shadowPath = path.cgPath
        }
    }
}
