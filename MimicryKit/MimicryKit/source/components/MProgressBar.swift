//
//  MProgressBar.swift
//  MimicryKit
//
//  Created by zyf on 2021/1/21.
//

import UIKit

extension MProgressBar {
    public enum Direction {
        case horizontal
        case vertical
    }
}

public class MProgressBar: MCard {
    private var autoAnimation: Bool = true

    override public var isOn: Bool {
        get { return true }
        set { }
    }

    override public var style: MComponentStyle {
        get { return .rectangle(corner: cornerSize) }
        set { }
    }

    private var cornerSize: CGFloat = 2 {
        didSet {
            updateView()
        }
    }

    private var _editable: Bool = false

    public var direction: Direction = .horizontal {
        didSet {
            updateView()
        }
    }

    private var _progress: Double = 0.0 {
        didSet {
            updateProgress()
        }
    }

    public var progress: Double {
        return _progress
    }

    public var barTintColor: UIColor = UIColor(r: 121, g: 86, b: 255) {
        didSet {
            updateView()
        }
    }

    private var progressLayer: CALayer = CALayer()

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

extension MProgressBar {
    @discardableResult public func progress(_ progress: Double) -> Self {
        _progress = progress > 1 ? 1 : progress
        return self
    }

    @discardableResult public func barTintColor(_ barTintColor: UIColor) -> Self {
        self.barTintColor = barTintColor
        return self
    }

    @discardableResult public func cornerSize(_ cornerSize: CGFloat) -> Self {
        self.cornerSize = cornerSize
        return self
    }

    @discardableResult public func editable(_ editable: Bool) -> Self {
        _editable = editable
        return self
    }

    @discardableResult public func direction(_ direction: Direction) -> Self {
        self.direction = direction
        return self
    }
}

extension MProgressBar {
    private func initView() {
        layer.addSublayer(progressLayer)
    }

    private func updateView() {
        style = .rectangle(corner: cornerSize)
        refreshView()
        switch style {
        case .circle:
            fatalError("[MimicryKit] => MProgressBar's style can not be circle")
        case .rectangle(corner: _):
            progressLayer.cornerRadius = (cornerSize - 2 <= 0 ? 1 : cornerSize - 2)
        }
        switch direction {
        case .horizontal:
            progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: frame.height)
        case .vertical:
            progressLayer.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0)
        }
        progressLayer.backgroundColor = barTintColor.cgColor
        updateProgress()
    }

    private func updateProgress() {
        if !autoAnimation {
            CATransaction.setAnimationDuration(0.05)
        }
        CATransaction.begin()
        switch direction {
        case .horizontal:
            progressLayer.frame.size.width = frame.width * CGFloat(progress)
        case .vertical:
            progressLayer.frame.size.height = frame.height * CGFloat(progress)
            progressLayer.frame.origin.y = frame.height - frame.height * CGFloat(progress)
        }
        CATransaction.commit()
    }
}

extension MProgressBar {
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if _editable {
            if let touch = touches.first {
                let location = touch.location(in: self)
                updateProgress(byLocation: location)
            }
        }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if _editable {
            if let touch = touches.first {
                let location = touch.location(in: self)
                updateProgress(byLocation: location)
            }
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if _editable {
            if let touch = touches.first {
                let location = touch.location(in: self)
                updateProgress(byLocation: location)
            }
        }
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if _editable {
            if let touch = touches.first {
                let location = touch.location(in: self)
                updateProgress(byLocation: location)
            }
        }
    }

    private func updateProgress(byLocation location: CGPoint) {
        autoAnimation = false
        switch direction {
        case .horizontal:
            var x = location.x
            let total: CGFloat = frame.width
            if x < 0 {
                x = 0
            }
            if x > frame.width {
                x = frame.width
            }
            progress(Double(x / total))
        case .vertical:
            var y = location.y
            let total: CGFloat = frame.height
            if y < 0 {
                y = 0
            }
            if y > frame.height {
                y = frame.height
            }
            let p = Double(y / total)
            progress(1 - p)
        }
    }
}
