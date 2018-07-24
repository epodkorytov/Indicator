//
//  RefreshControl.swift
//  Indicator
//

import UIKit

public class RefreshControl: UIRefreshControl {
    private let indicator: Indicator
    
    public var style: IndicatorStyleProtocol
    
    public var pullToRefresh: (() -> Void)?
    
    private override init() {
        self.style = IndicatorStyleDefault()
        indicator = Indicator(style: self.style)
        
        super.init()
        
        tintColor = .clear
        addSubview(indicator)
        
        addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    public init(_ style: IndicatorStyleProtocol? = nil) {
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        indicator.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        indicator.startAnimating()
        pullToRefresh?()
    }
    
    override public func endRefreshing() {
        super.endRefreshing()
        indicator.stopAnimating()
    }
}
