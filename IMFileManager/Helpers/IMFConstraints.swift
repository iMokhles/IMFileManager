//
//  IMFConstraints.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit

class IMFConstraints: NSObject {
    class func layoutBottomView(miniView: UIView, in superView: UIView, withConstant constant: Int) {
        
        let bottomLayout = NSLayoutConstraint(item: superView, attribute: .bottom, relatedBy: .equal, toItem: miniView, attribute: .bottom, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(bottomLayout)
    }
    
    class func layoutTopView(miniView: UIView, in superView: UIView, withConstant constant: Int) {
        
        let topLayout = NSLayoutConstraint(item: miniView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(topLayout)
    }
    
    class func layoutLeading(miniView: UIView, in superView: UIView, withConstant constant: Int) {
        
        let leadingLayout = NSLayoutConstraint(item: miniView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(leadingLayout)
    }
    
    class func layoutTrailingView(miniView: UIView, in superView: UIView, withConstant constant: Int) {
        
        let trailingLayout = NSLayoutConstraint(item: miniView, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(trailingLayout)
    }
    
    class func layoutView(miniView: UIView, underView miniView2: UIView, withConstant constant: Int) {
        
        let underLayout = NSLayoutConstraint(item: miniView, attribute: .top, relatedBy: .equal, toItem: miniView2, attribute: .bottom, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(underLayout)
    }
    
    class func layoutView(miniView: UIView, above miniView2: UIView, withConstant constant: Int) {
        let aboveLayout = NSLayoutConstraint(item: miniView, attribute: .bottom, relatedBy: .equal, toItem: miniView2, attribute: .top, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(aboveLayout)
    }
    
    class func layoutView(miniView: UIView, leftView miniView2: UIView, withConstant constant: Int) {
        let leftLayout = NSLayoutConstraint(item: miniView, attribute: .trailing, relatedBy: .equal, toItem: miniView2, attribute: .leading, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(leftLayout)
    }
    
    class func layoutView(miniView: UIView, rightView miniView2: UIView, withConstant constant: Int) {
        let rightLayout = NSLayoutConstraint(item: miniView, attribute: .leading, relatedBy: .equal, toItem: miniView2, attribute: .trailing, multiplier: 1, constant: CGFloat(constant))
        miniView.superview?.addConstraint(rightLayout)
    }
    
    class func addHeightConstraint(to miniView: UIView, withHeight height: Int) {
        let heightLayout = NSLayoutConstraint(item: miniView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(height))
        miniView.addConstraint(heightLayout)
    }
    
    class func addWidthConstraint(to miniView: UIView, withWidth width: Int) {
        let widthLayout = NSLayoutConstraint(item: miniView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(width))
        miniView.addConstraint(widthLayout)
    }
    
    class func center(miniView: UIView, in superView: UIView, xConstant: Int, yConstant: Int) {
        
        let xCenterConstraint = NSLayoutConstraint(item: superView, attribute: .centerX, relatedBy: .equal, toItem: miniView, attribute: .centerX, multiplier: 1, constant: CGFloat(xConstant))
        superView.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: superView, attribute: .centerY, relatedBy: .equal, toItem: miniView, attribute: .centerY, multiplier: 1, constant: CGFloat(yConstant))
        superView.addConstraint(yCenterConstraint)
    }
}
