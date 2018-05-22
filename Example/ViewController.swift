//
//  ViewController.swift
//  Example
//


import UIKit
import Indicator

class ViewController: UIViewController {

//    MARK: - Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
//    MARK: - Private methods
    
    private func setup() {
        var style = IndicatorStyleDefault()
            style.progress = 0.1
        let indicator = Indicator(style: style)
            indicator.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 0.5)
        view.addSubview(indicator)
        indicator.startAnimating()
        progressIndicator(indicator, currentProgress: 0.1)
    }
    
    
    private func progressIndicator(_ indicator: Indicator, currentProgress: CGFloat) {
        if currentProgress > 1.0 {
            indicator.stopAnimating()
            return
        }
        indicator.progress = currentProgress
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak weakSelf = self] in
            weakSelf?.progressIndicator(indicator, currentProgress: currentProgress + 0.05)
        }
    }
    


}

