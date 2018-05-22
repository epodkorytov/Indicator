# Indicator

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Quick Start

### How to use

Import compiled library to your class:

    import Indicator

### Style

You can create your own style of its indicator by inheriting from `IndicatorStyleProtocol`.

IndicatorStyleProtocol has a following attributes:

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

`strokeColors` attribute is an array of colors, indicator change its color translate through this colors animatedly and `colorAnimationDuration` attribute define the time of its changing

If you do not want to create your own style you can use `IndicatorStyleDefault()`:

	let style = IndicatorStyleDefault()

Initialization of `IndicatorStyleDefault()` has default values for all its attributes:

    public init(strokeColors: [UIColor] = [.red],
                size: CGSize = CGSize(width: 35.0, height: 35.0),
                strokeWidth: CGFloat = 1.0,
                minProgress: CGFloat = 0.05,
                progress: CGFloat = 0.75,
                colorAnimationDuration: Double = 3.5,
                rotationAnimationDuration: Double = 2.0,
                eraseInAnimationDuration: Double = 0.5,
                eraseOutAnimationDuration: Double = 0.5)

So, you can init `IndicatorStyleDefault()` with direct setting of its attributes, but it is no need to specify all of it. For example:

    let style = IndicatorStyleDefault(strokeColors: [.black],
                                      strokeWidth: 3.0,
                                      colorAnimationDuration: 10.0)

### Initialization

Just initialize this indicator with defined style:

	let indicator = Indicator(style: style)

and set its center:

	indicator.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 0.5)

### Animation

You can start or stop your animation by calling appropriate methods

	indicator.startAnimating()
	indicator.stopAnimating()

### Progress

You can set progress of its animation by calling:
	
	indicator.progress = <YOUR_PROGRESS>

If `<YOUR_PROGRESS>` value will be lower than predefined `progress` in your style it will not affect. If you want to change `progress` attribute without reinitializing of its style you can call method:

	indicator.changeUpperProgressValue(to: <NEW_VALUE>)
