//
//  RefreshControl.swift
//  Indicator
//

import UIKit

class RefreshControl: UIRefreshControl {
    private let indicator: Indicator
    
    var style: IndicatorStyleProtocol
    
    var pullToRefresh: (() -> Void)?
    
    init(_ style: IndicatorStyleProtocol? = nil) {
        if let style = style {
            self.style = style
        } else {
            self.style = IndicatorStyleDefault()
        }
        indicator = Indicator(style: self.style)
        
        super.init()
        
        tintColor = .clear
        addSubview(indicator)
        
        addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        indicator.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        indicator.startAnimating()
        pullToRefresh?()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        indicator.stopAnimating()
    }
}
