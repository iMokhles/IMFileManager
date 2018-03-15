//
//  UIBarButtonItemExtensions.swift
//  CashApp
//
//  Created by iMokhles on 05/01/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation
import UIKit


fileprivate var closureKey: UInt = 0

extension UIBarButtonItem: Attachable {
    
    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.closureInit(closure)
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, _ closure:  @escaping (UIBarButtonItem?) -> Void) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.closureInit(closure)
    }
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.closureInit(closure)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.closureInit(closure)
    }
    
    public convenience init(customView: UIView, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.init(customView: customView)
        self.closureInit(closure)
    }
    
    func closureInit(_ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.target = self
        self.action = #selector(invoke)
        self.set(ClosureWrapper<UIBarButtonItem>(closure), forKey: &closureKey)
    }
    
    @objc func invoke() {
        (self.getAttach(forKey: &closureKey) as? ClosureWrapper<UIBarButtonItem>)?.closure(self)
    }
}
