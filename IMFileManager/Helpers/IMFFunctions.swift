//
//  IMFFunctions.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class IMFFunctions: NSObject {
    
    class func getStringBundleValue(key:String) -> String {
        let value = Bundle.main.object(forInfoDictionaryKey: key) as! String
        return value
    }
    class func topViewController() -> UIViewController? {
        var resultViewController: UIViewController? = nil
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            resultViewController = getTopViewController(rootViewController)
            while resultViewController?.presentedViewController != nil {
                resultViewController = resultViewController?.presentedViewController
            }
        }
        return resultViewController
    }
    
    class func getTopViewController(_ object: AnyObject!) -> UIViewController? {
        if let navigationController = object as? UINavigationController {
            return getTopViewController(navigationController.viewControllers.last)
        }
        else if let tabBarController = object as? UITabBarController {
            if tabBarController.selectedIndex < (tabBarController.viewControllers?.count)! {
                return getTopViewController(tabBarController.viewControllers![tabBarController.selectedIndex])
            }
        }
        else if let vc = object as? UIViewController {
            return vc
        }
        
        return nil
    }
    class func getRootViewController() -> UIViewController{
        var controller: UIViewController
        let systemVersion: NSString = UIDevice.current.systemVersion as NSString
        if systemVersion.floatValue < 6.0 {
            let array = UIApplication.shared.windows
            let window = array[0]
            
            let uiview = window.subviews[0]
            controller = uiview.next as! UIViewController
        } else {
            controller = (UIApplication.shared.keyWindow?.rootViewController)!
        }
        
        return controller
    }
    
    class func addBadgeNumber(forItemAtIndex index:Int, num: Int) {
        let tabBarController = getRootViewController() as! UITabBarController
        
        let item = tabBarController.tabBar.items![index]
        if item.badgeValue == nil {
            item.badgeValue = "0"
        }
        let badgeValue = NSString(string: item.badgeValue!).integerValue
        item.badgeValue = NSString(format: "%d", badgeValue + num) as String
    }
    
    class func clearBadgeNumber(forItemAtIndex index:Int) {
        let tabBarController = getRootViewController() as! UITabBarController
        
        let item = tabBarController.tabBar.items![index]
        item.badgeValue = nil
    }
    
    class func setTabBarIndex(index: Int) {
        let tabBarController = getRootViewController() as! UITabBarController
        tabBarController.selectedIndex = index
        
    }
    
    func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    class func showUpdateNameAlert(viewC: UIViewController, completion: @escaping (String?) -> Void) -> Void {
        let alert = UIAlertController(title: NSLocalizedString("Update Name", comment: "update name"), message: NSLocalizedString("Enter new Name", comment: "enter new name"), preferredStyle: .alert)
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = NSLocalizedString("New Name", comment: "new name")
            tfAlert.keyboardAppearance = .dark
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Change", comment: "change"), style: .default, handler: { (bla) in
            let nameString = alert.textFields![0].text
            
            completion(nameString)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel"), style: .cancel, handler:{ (bla) in
            
        }))
        viewC.present(alert, animated: true, completion: nil)
        
    }
}
