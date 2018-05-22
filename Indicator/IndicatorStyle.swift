//
//  IndicatorStyle.swift
//  Indicator
//


import UIKit

// MARK: - Protocols

public protocol IndicatorStyleProtocol {
    
    // COLOR VALUEs
    var strokeColors    : [UIColor] { get set }
    
    // VARIABLEs
    var size            : CGSize  { get set }
    
    var strokeWidth     : CGFloat { get set }
    var minProgress     : CGFloat { get set }
    var progress        : CGFloat { get set }
    
    var colorAnimationDuration   : Double { get set }
    var rotationAnimationDuration: Double { get set }
    var eraseInAnimationDuration : Double { get set }
    var eraseOutAnimationDuration: Double { get set }
    
}


// MARK: - Structs

public struct IndicatorStyleDefault: IndicatorStyleProtocol {
    
    // COLOR VALUEs
    public var strokeColors: [UIColor]
    
    // VARIABLEs
    public var size : CGSize
    
    public var strokeWidth: CGFloat
    public var minProgress: CGFloat
    public var progress: CGFloat
    
    public var colorAnimationDuration: Double
    public var rotationAnimationDuration: Double
    public var eraseInAnimationDuration: Double
    public var eraseOutAnimationDuration: Double
    
    
    public init(strokeColors: [UIColor] = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)],
         size: CGSize = CGSize(width: 35.0, height: 35.0),
         strokeWidth: CGFloat = 1.0,
         minProgress: CGFloat = 0.05,
         progress: CGFloat = 0.75,
         colorAnimationDuration: Double = 3.5,
         rotationAnimationDuration: Double = 2.0,
         eraseInAnimationDuration: Double = 0.5,
         eraseOutAnimationDuration: Double = 0.5)
    {
        self.strokeColors = strokeColors
        self.size = size
        self.strokeWidth = strokeWidth
        self.minProgress = minProgress
        self.progress = progress
        self.colorAnimationDuration = colorAnimationDuration
        self.rotationAnimationDuration = rotationAnimationDuration
        self.eraseInAnimationDuration = eraseInAnimationDuration
        self.eraseOutAnimationDuration = eraseOutAnimationDuration
    }
    
}
