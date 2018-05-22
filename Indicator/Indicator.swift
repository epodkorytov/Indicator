//
//  Indicator.swift
//  Indicator
//

import UIKit


public class Indicator: UIView {
    
//    MARK: - Constants
    
    private let STROKE_KEY = "stroke"
    private let STROKE_START_KEY = "strokeStart"
    private let STROKE_END_KEY = "strokeEnd"
    private let STROKE_COLOR_KEY = "strokeColor"
    private let TRANSFORM_KEY = "transform"
    private let ROTATION_KEY = "rotation"
    private let COLOR_KEY = "color"
    
    private var _progress: CGFloat = 0.0
    public var progress: CGFloat! {
        get {
            return _progress
        }
        set {
            if newValue > _progress && _progress <= 1 {
                _progress = newValue
            } else if newValue <= 100 {
                if (newValue / 100.0) > _progress {
                    _progress = newValue / 100.0
                }
            }
        }
    }
    
//    MARK: - Variables
    
    private let circleShapeLayer = CAShapeLayer()
    
    private var style: IndicatorStyleProtocol! {
        didSet {
            setupStyle()
        }
    }
    
    
//    MARK: - Instance initialization
    
    public init(style: IndicatorStyleProtocol) {
        super.init(frame: CGRect(origin: .zero, size: style.size))
        self.style = style
        setup()
    }

    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Private methods
    
    private func setup() {
        backgroundColor = .clear
        
        progress = style.progress
        
        circleShapeLayer.actions = [STROKE_END_KEY: NSNull(),
                                    STROKE_START_KEY: NSNull(),
                                    STROKE_COLOR_KEY: NSNull(),
                                    TRANSFORM_KEY: NSNull()]
        circleShapeLayer.backgroundColor = UIColor.clear.cgColor
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        circleShapeLayer.lineWidth = style.strokeWidth
        circleShapeLayer.lineCap = kCALineCapRound
        circleShapeLayer.strokeStart = 0
        circleShapeLayer.strokeEnd = style.minProgress
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        circleShapeLayer.frame = bounds
        circleShapeLayer.path = UIBezierPath(arcCenter: center,
                                             radius: center.x,
                                             startAngle: 0,
                                             endAngle: CGFloat(Double.pi * 2),
                                             clockwise: true).cgPath
        layer.addSublayer(circleShapeLayer)
    }
    
    
    private func setupStyle() {
        progress = style.progress
        circleShapeLayer.lineWidth = style.strokeWidth
        circleShapeLayer.strokeEnd = style.minProgress
        if layer.animation(forKey: ROTATION_KEY) != nil {
            stopAnimating()
        }
        startAnimating()
    }
    
    
    private func startColorAnimation() {
        let cgColors = style.strokeColors.map({ $0.cgColor })
        let color = CAKeyframeAnimation(keyPath: STROKE_COLOR_KEY)
            color.values = cgColors
            color.duration = style.colorAnimationDuration
            color.calculationMode = kCAAnimationPaced
            color.repeatCount = Float.infinity
        circleShapeLayer.add(color, forKey: COLOR_KEY)
    }
    
    
    private func startRotatingAnimation() {
        let rotation = CABasicAnimation(keyPath: "\(TRANSFORM_KEY).\(ROTATION_KEY).z")
            rotation.toValue = Double.pi * 2
            rotation.duration = style.rotationAnimationDuration
            rotation.isCumulative = true
            rotation.isAdditive = true
            rotation.repeatCount = Float.infinity
        layer.add(rotation, forKey: ROTATION_KEY)
    }
    
    
    private func startStrokeAnimation() {
        let easeInOutSineTimingFunc = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1.0)
        let currentProgress: CGFloat = progress
        let endFromValue: CGFloat = circleShapeLayer.strokeEnd
        let endToValue: CGFloat = endFromValue + currentProgress
        let strokeEnd = CABasicAnimation(keyPath: STROKE_END_KEY)
            strokeEnd.fromValue = endFromValue
            strokeEnd.toValue = endToValue
            strokeEnd.duration = style.eraseOutAnimationDuration
            strokeEnd.fillMode = kCAFillModeForwards
            strokeEnd.timingFunction = easeInOutSineTimingFunc
            strokeEnd.beginTime = 0.1
            strokeEnd.isRemovedOnCompletion = false
        let startFromValue: CGFloat = circleShapeLayer.strokeStart
        let startToValue: CGFloat = fabs(endToValue - style.minProgress)
        let strokeStart = CABasicAnimation(keyPath: STROKE_START_KEY)
            strokeStart.fromValue = startFromValue
            strokeStart.toValue = startToValue
            strokeStart.duration = style.eraseInAnimationDuration
            strokeStart.fillMode = kCAFillModeForwards
            strokeStart.timingFunction = easeInOutSineTimingFunc
            strokeStart.beginTime = strokeEnd.beginTime + strokeEnd.duration + 0.2
            strokeStart.isRemovedOnCompletion = false
        let pathAnim = CAAnimationGroup()
            pathAnim.animations = [strokeEnd, strokeStart]
            pathAnim.duration = strokeStart.beginTime + strokeStart.duration
            pathAnim.fillMode = kCAFillModeForwards
            pathAnim.isRemovedOnCompletion = false
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak weakSelf = self]  in
            if let transform = weakSelf?.circleShapeLayer.transform, weakSelf?.circleShapeLayer.animation(forKey: self.STROKE_KEY) != nil {
                weakSelf?.circleShapeLayer.transform = CATransform3DRotate(transform, CGFloat(Double.pi * 2) * currentProgress, 0, 0, 1)
                weakSelf?.circleShapeLayer.removeAnimation(forKey: self.STROKE_KEY)
                weakSelf?.startStrokeAnimation()
            }
        }
        circleShapeLayer.add(pathAnim, forKey: STROKE_KEY)
        CATransaction.commit()
    }
    
    
//    MARK: - Interface methods
    
    public func startAnimating() {
        if layer.animation(forKey: ROTATION_KEY) == nil {
            startColorAnimation()
            startStrokeAnimation()
            startRotatingAnimation()
        }
    }
    
    
    public func stopAnimating() {
        circleShapeLayer.removeAllAnimations()
        layer.removeAllAnimations()
        circleShapeLayer.transform = CATransform3DIdentity
        layer.transform = CATransform3DIdentity
    }
    
    
    public func changeUpperProgressValue(to newValue: CGFloat) {
        _progress = newValue
    }
    
}

