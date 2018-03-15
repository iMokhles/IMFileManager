//
//  StringExtensions.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation

extension String {
    func isBlank() -> Bool {
        let trimmed = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    public func getExtension() -> String? {
        
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty {
            return nil
        }
        
        return ext
    }
}
