//
//  UITableViewExtensions.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func addPullToRefresh() -> UIRefreshControl {
        let refresh = UIRefreshControl()
        if #available(iOS 10.0, *) {
            self.refreshControl = refresh
        } else {
            // Fallback on earlier versions
            self.addSubview(refresh)
        }
        return refresh
    }
}
