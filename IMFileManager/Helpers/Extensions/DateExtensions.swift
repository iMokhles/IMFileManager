//
//  DateExtensions.swift
//  IMFileManager
//
//  Created by iMokhles on 01/02/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
