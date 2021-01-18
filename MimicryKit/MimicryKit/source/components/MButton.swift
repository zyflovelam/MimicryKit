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
        public var backgroundColor: UIColor
        public var selectedColor: UIColor
        public var unselectedColor: UIColor
        public var shadowColor: UIColor
        public var style: Style
        public var iconSize: CGSize = CGSize(width: 22, height: 22)
        public var titleFont: UIFont = .systemFont(ofSize: 17)
        public var titleColor: UIColor = UIColor(r: 143, g: 147, b: 155)

        public static var `default`: Appearence = Appearence(backgroundColor: .init(r: 41, g: 45, b: 50), selectedColor: UIColor(r: 143, g: 147, b: 155), unselectedColor: UIColor(r: 143, g: 147, b: 155), shadowColor: UIColor(r: 48, g: 52, b: 58), style: .circle)
    }
}

extension MButton.Appearence {
    public enum Style {
        case circle
        case rectangle(_ corner: CGFloat)
    }
}

public class MButton: UIView {
    public var isOn: Bool = false {
        didSet {
            updateView()
        }
    }

    public var icon: UIImage? {
        didSet {
            updateView()
        }
    }

    public var title: String = "" {
        didSet {
            updateView()
        }
    }

    var appearence: Appearence = .default {
        didSet {
            updateView()
        }
    }

    private var backgroundView: UIView = UIView()
    private var iconView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()

    private var layer1: CALayer = CALayer()
    private var layer2: CALayer = CALayer()
    private var layer3: CALayer = CALayer()

    private var onTappedClosure: ((MButton) -> Void)?

    public convenience init(icon: UIImage? = nil, title: String = "", appearence: Appearence = .default) {
        self.init(frame: .zero)
        self.icon = icon
        self.title = title
        self.appearence = appearence
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
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
    private func initView() {
        addSubview(backgroundView)
        addSubview(iconView)
        addSubview(titleLabel)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonTapped(_:))))
    }

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
            layer.cornerRadius = corner
        case let .rectangle(corner):
            backgroundView.layer.cornerRadius = corner
            layer.cornerRadius = corner
        }
        backgroundView.backgroundColor = appearence.backgroundColor

        iconView.image = icon
        var origin: CGPoint = .zero
        if title == "" {
            origin = CGPoint(x: (frame.width - appearence.iconSize.width) / 2, y: (frame.height - appearence.iconSize.height) / 2)
        } else {
            let width = title.widthWithFont(font: appearence.titleFont)
            let totalWidth = width + appearence.iconSize.width + 50
            if frame.width < totalWidth {
                frame.size = CGSize(width: totalWidth, height: frame.height)
                layoutSubviews()
            }
            origin = CGPoint(x: 20, y: (frame.height - appearence.iconSize.height) / 2)
            titleLabel.frame = CGRect(x: 30 + appearence.iconSize.width, y: 0, width: width, height: frame.height)
            titleLabel.numberOfLines = 1
            titleLabel.text = title
            titleLabel.font = appearence.titleFont
            titleLabel.textColor = appearence.titleColor
        }

        iconView.frame = CGRect(origin: origin, size: appearence.iconSize)
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
        updateShadow()
    }

    private func updateShadow() {
        if isOn {
            let path1: UIBezierPath
            let innerPart1: UIBezierPath
            switch appearence.style {
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
            switch appearence.style {
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
            let path: UIBezierPath
            switch appearence.style {
            case .circle:
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: backgroundView.layer.cornerRadius)
            case let .rectangle(corner):
                path = UIBezierPath(roundedRect: backgroundView.bounds, cornerRadius: corner)
            }

            layer1.shadowOpacity = 1
            layer1.masksToBounds = false
            layer1.shadowPath = path.cgPath
            layer1.shadowOffset = .init(width: -3, height: -3)
            layer1.shadowColor = UIColor(r: 48, g: 52, b: 58).cgColor
            layer1.shadowRadius = 2

            layer2.shadowOpacity = 1
            layer2.masksToBounds = false
            layer2.shadowPath = path.cgPath
            layer2.shadowOffset = .init(width: 3, height: 3)
            layer2.shadowColor = UIColor(r: 36, g: 38, b: 44).cgColor
            layer2.shadowRadius = 2

            layer3.opacity = 1
            backgroundView.layer.masksToBounds = false
        }
    }
}

extension MButton {
    public func onTapped(_ closure: @escaping (MButton) -> Void) {
        onTappedClosure = closure
    }

    @objc private func onButtonTapped(_ sender: UITapGestureRecognizer) {
        isOn.toggle()
        onTappedClosure?(self)
    }
}
