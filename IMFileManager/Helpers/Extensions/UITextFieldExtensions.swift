//
//  UITextFieldExtensions.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isFacebookUrl() -> Bool {
        return ((self.text?.lowercased().contains(find: "facebook.com"))!)
    }
    func isTwitterUrl() -> Bool {
        return ((self.text?.lowercased().contains(find: "twitter.com"))!)
    }
    func isSoundCloudUrl() -> Bool {
        return ((self.text?.lowercased().contains(find: "soundcloud.com"))!)
    }
    func isInstagramUrl() -> Bool {
        return ((self.text?.lowercased().contains(find: "instagram.com"))!)
    }
    func isYoutubeUrl() -> Bool {
        return ((self.text?.lowercased().contains(find: "youtu.be"))! || (self.text?.lowercased().contains(find: "youtube.com"))!)
    }
}
