//
//  IMDownloadsViewController.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit

class IMDownloadsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MZDownloadManagerDelegate {
    var selectedIndexPath : IndexPath!
    
    lazy var downloadManager: MZDownloadManager = {
        [unowned self] in
        let sessionIdentifer: String = IMFConstant.kAppBackgroundSessionId
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var completion = appDelegate.backgroundSessionCompletionHandler
        
        let downloadmanager = MZDownloadManager(session: sessionIdentifer, delegate: self, completion: completion)
        return downloadmanager
        }()
    
    @IBOutlet var mainTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshCellForIndex(_ downloadModel: MZDownloadModel, index: Int) {
        let indexPath = IndexPath.init(row: index, section: 0)
        let cell = self.mainTable.cellForRow(at: indexPath)
        if let cell = cell {
            let downloadCell = cell as! IMDownloadsCell
            downloadCell.updateCellForRowAtIndexPath(indexPath, downloadModel: downloadModel)
        }
    }
    
    // MARK: - UITabelViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadManager.downloadingArray.count
    }
    
    // MARK: - UITabelViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let downloadsCell = tableView.dequeueReusableCell(withIdentifier: "downloadsCell") as! IMDownloadsCell
        
        let downloadModel = downloadManager.downloadingArray[indexPath.row]
        
        downloadsCell.updateCellForRowAtIndexPath(indexPath, downloadModel: downloadModel)
        
        downloadsCell.cancelButtonBlock = {
            (downloadModel,downloadCell,row,section) -> Void in
            self.downloadManager.cancelTaskAtIndex(row)
        }
        
        downloadsCell.toggleButtonBlock = {
            (state,downloadModel,downloadCell,row,section) -> Void in
            if (state == 1) {
                self.downloadManager.resumeDownloadTaskAtIndex(row)
            } else {
                self.downloadManager.pauseDownloadTaskAtIndex(row)
            }
        }
        
        
        return downloadsCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    // MARK: - MZDownloadManagerDelegate
    func downloadRequestStarted(_ downloadModel: MZDownloadModel, index: Int) {
        if (mainTable != nil) {
            mainTable.beginUpdates()
            mainTable.insertRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            mainTable.endUpdates()
        }
        
        IMFFunctions.addBadgeNumber(forItemAtIndex: 1, num: downloadManager.downloadingArray.count)
    }
    
    func downloadRequestDidPopulatedInterruptedTasks(_ downloadModels: [MZDownloadModel]) {
        if (mainTable != nil) {
            mainTable.reloadData()
        }
        IMFFunctions.addBadgeNumber(forItemAtIndex: 1, num: downloadManager.downloadingArray.count)
    }
    
    func downloadRequestDidUpdateProgress(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestDidPaused(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestDidResumed(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestCanceled(_ downloadModel: MZDownloadModel, index: Int) {
        if (mainTable != nil) {
            mainTable.beginUpdates()
            mainTable.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            mainTable.endUpdates()
        }
        let downloadsNumber = downloadManager.downloadingArray.count-1;
        if (downloadsNumber == 0) {
            IMFFunctions.clearBadgeNumber(forItemAtIndex: 1)
        } else {
            IMFFunctions.addBadgeNumber(forItemAtIndex: 1, num: downloadsNumber)
        }

        
    }
    
    func downloadRequestFinished(_ downloadModel: MZDownloadModel, index: Int) {
        
        downloadManager.presentNotificationForDownload("Ok", notifBody: "Download did completed")
        
        let desPath = downloadModel.destinationPath
        let destFolderName = (desPath as NSString).lastPathComponent
        let destFolder = FileCDHelper.sharedFile.getFolderByName(folderName: destFolderName)
        
         if (mainTable != nil) {
            mainTable.beginUpdates()
            mainTable.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            mainTable.endUpdates()
        }
        let downloadsNumber = downloadManager.downloadingArray.count-1;
        if (downloadsNumber == 0) {
            IMFFunctions.clearBadgeNumber(forItemAtIndex: 1)
        } else {
            IMFFunctions.addBadgeNumber(forItemAtIndex: 1, num: downloadsNumber)
        }
        DispatchQueue.main.async {
            _ = FileCDHelper.sharedFile.addNewFile(downloadModel: downloadModel, folder: destFolder)
        }
        
    }
    
    func downloadRequestDidFailedWithError(_ error: NSError, downloadModel: MZDownloadModel, index: Int) {
        
    }
    
    func downloadRequestDestinationDoestNotExists(_ downloadModel: MZDownloadModel, index: Int, location: URL) {
        
    }
    
    
}
