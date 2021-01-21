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
        public var selectedColor: UIColor = UIColor(r: 143, g: 147, b: 155)
        public var unselectedColor: UIColor = UIColor(r: 143, g: 147, b: 155)
        public var shadowColor: UIColor = UIColor(r: 48, g: 52, b: 58)
        public var iconSize: CGSize = CGSize(width: 22, height: 22)
        public var titleFont: UIFont = .systemFont(ofSize: 17)
        public var titleColor: UIColor = UIColor(r: 143, g: 147, b: 155)

        public static var `default`: Appearence = Appearence(selectedColor: UIColor(r: 143, g: 147, b: 155), unselectedColor: UIColor(r: 143, g: 147, b: 155), shadowColor: UIColor(r: 48, g: 52, b: 58))
    }
}

public class MButton: MCard {
    private var icon: UIImage? {
        didSet {
            updateView()
        }
    }

    private var title: String = "" {
        didSet {
            updateView()
        }
    }

    private var appearence: Appearence = .default {
        didSet {
            updateView()
        }
    }

    private var selectedColor: UIColor = UIColor(r: 143, g: 147, b: 155) {
        didSet {
            updateView()
        }
    }

    private var unselectedColor: UIColor = UIColor(r: 143, g: 147, b: 155) {
        didSet {
            updateView()
        }
    }

    private var shadowColor: UIColor = UIColor(r: 48, g: 52, b: 58) {
        didSet {
            updateView()
        }
    }

    private var iconSize: CGSize = CGSize(width: 22, height: 22) {
        didSet {
            updateView()
        }
    }

    private var titleFont: UIFont = .systemFont(ofSize: 17) {
        didSet {
            updateView()
        }
    }

    private var titleColor: UIColor = UIColor(r: 143, g: 147, b: 155) {
        didSet {
            updateView()
        }
    }

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
    @discardableResult public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    @discardableResult public func icon(_ icon: UIImage?) -> Self {
        self.icon = icon
        return self
    }
    
    @discardableResult public func icon(_ named: String) -> Self {
        self.icon = UIImage(named: named)
        return self
    }
    
    @discardableResult public func selectedColor(_ selectedColor: UIColor) -> Self {
        self.selectedColor = selectedColor
        return self
    }

    @discardableResult public func unselectedColor(_ unselectedColor: UIColor) -> Self {
        self.unselectedColor = unselectedColor
        return self
    }

    @discardableResult public func shadowColor(_ shadowColor: UIColor) -> Self {
        self.shadowColor = shadowColor
        return self
    }
    
    @discardableResult public func iconSize(_ iconSize: CGSize) -> Self {
        self.iconSize = iconSize
        return self
    }
    
    @discardableResult public func titleFont(_ titleFont: UIFont) -> Self {
        self.titleFont = titleFont
        return self
    }
    
    @discardableResult public func titleColor(_ titleColor: UIColor) -> Self {
        self.titleColor = titleColor
        return self
    }
}

extension MButton {
    private func initView() {
        addSubview(iconView)
        addSubview(titleLabel)
    }

    public func updateView() {
        refreshView()
        switch style {
        case .circle:
            var corner: CGFloat = 0
            if frame.width > frame.height {
                corner = frame.width / 2
            } else {
                corner = frame.height / 2
            }
            layer.cornerRadius = corner
        case let .rectangle(corner):
            layer.cornerRadius = corner
        }

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
        refreshShadow(isOn: isOn, layer1: layer1, layer2: layer2, layer3: layer3, backgroundView: backgroundView, style: style)
    }
}

extension MButton {
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        onButtonTapped()
    }
}

extension MButton {
    public func onTapped(_ closure: @escaping (MButton) -> Void) {
        onTappedClosure = closure
    }

    private func onButtonTapped() {
        isOn.toggle()
        onTappedClosure?(self)
    }
}
