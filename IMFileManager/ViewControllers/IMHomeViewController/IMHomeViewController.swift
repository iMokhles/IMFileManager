//
//  IMHomeViewController.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import UIKit
import LGButton

class IMHomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var linkTextField: UITextField!
    @IBOutlet var downloadBtn: LGButton!
    let test100mbZipFile = "http://speedtest.tele2.net/100MB.zip"
    var downloadsVC    : IMDownloadsViewController?
    let downloadsPath = MZUtility.baseFilePath + "/Downloads"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !FileManager.default.fileExists(atPath: downloadsPath) {
            let _ = FolderCDHelper.sharedFolder.addNewFolder(folderName: "Downloads", fullPath: downloadsPath, is_main: true)
            try! FileManager.default.createDirectory(atPath: downloadsPath, withIntermediateDirectories: true, attributes: nil)
        }
        setupDownloadButton()
        setupDownloadsViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupDownloadButton() {
        downloadBtn.titleString = "Download"
        downloadBtn.leftIconFontName = "fa"
        downloadBtn.leftIconString = "cloud-download"
        downloadBtn.bgColor = UIColor.defaultIMColor()
        
    }

    func setupDownloadsViewController() {
        
        let tabBarTabs : NSArray? = self.tabBarController?.viewControllers as NSArray?
        let downloadsNVC : UINavigationController = tabBarTabs?.object(at: 1) as! UINavigationController
        downloadsVC = downloadsNVC.viewControllers[0] as? IMDownloadsViewController
        
        
    }
    @IBAction func downloadBtnTapped(_ sender: LGButton) {
        
        linkTextField.text = test100mbZipFile
        if (linkTextField.text?.isBlank() == false) {
            let fileURL = linkTextField.text! as NSString
            
            var fileName : NSString = fileURL.lastPathComponent as NSString
            fileName = MZUtility.getUniqueFileNameWithPath((downloadsPath as NSString).appendingPathComponent(fileName as String) as NSString)
            var downloadPath = ""
            let downloadsFolder = FolderCDHelper.sharedFolder.getFolderByName(folderName: "Downloads")
            if (downloadBtn.leftIconString.contains(find: "cloud-download")) {
                downloadPath = downloadsPath+"/"+fileName.pathExtension
                if (!FileManager.default.fileExists(atPath: downloadPath)) {
                    _ = FileCDHelper.sharedFile.addNewFolder(folderName: fileName.pathExtension, fullPath: downloadPath, parent: downloadsFolder)
                    try! FileManager.default.createDirectory(atPath: downloadPath, withIntermediateDirectories: true, attributes: nil)
                }
            } else {
                downloadPath = downloadsPath+"/"+downloadBtn.leftIconString
                if (!FileManager.default.fileExists(atPath: downloadPath)) {
                    _ = FileCDHelper.sharedFile.addNewFolder(folderName: downloadBtn.leftIconString, fullPath: downloadPath, parent: downloadsFolder)
                    try! FileManager.default.createDirectory(atPath: downloadPath, withIntermediateDirectories: true, attributes: nil)
                }
            }
            IMFFunctions.setTabBarIndex(index: 1)
            downloadsVC?.downloadManager.addDownloadTask(fileName as String, fileURL: fileURL as String, destinationPath: downloadPath)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if (textField.isFacebookUrl()) {
            downloadBtn.titleString = "Facebook"
            downloadBtn.leftIconString = "facebook"
            downloadBtn.bgColor = UIColor.facebookBlueColor()
        } else if (textField.isTwitterUrl()) {
            downloadBtn.titleString = "Twitter"
            downloadBtn.leftIconString = "twitter"
            downloadBtn.bgColor = UIColor.twitterColor()
        } else if (textField.isSoundCloudUrl()) {
            downloadBtn.titleString = "SoundCloud"
            downloadBtn.leftIconString = "soundcloud"
            downloadBtn.bgColor = UIColor.soundCloudColor()
        } else if (textField.isInstagramUrl()) {
            downloadBtn.titleString = "Instagram"
            downloadBtn.leftIconString = "instagram"
            downloadBtn.bgColor = UIColor.instagramColor()
        } else if (textField.isYoutubeUrl()) {
            downloadBtn.titleString = "Youtube"
            downloadBtn.leftIconString = "youtube"
            downloadBtn.bgColor = UIColor.youtubeColor()
        } else {
            downloadBtn.titleString = "Download"
            downloadBtn.leftIconString = "cloud-download"
            downloadBtn.bgColor = UIColor.defaultIMColor()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

