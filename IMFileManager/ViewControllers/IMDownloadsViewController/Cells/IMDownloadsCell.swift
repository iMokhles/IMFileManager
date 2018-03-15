//
//  IMDownloadsCell.swift
//  IMFileManager
//
//  Created by iMokhles on 30/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit
import MBCircularProgressBar
import LGButton

class IMDownloadsCell: UITableViewCell {
    
    @IBOutlet var progressView: MBCircularProgressBarView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var downloadedLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var toggleButton: LGButton!
    @IBOutlet var cancelButton: LGButton!
    
    var toggleButtonBlock: ((_ state: NSInteger, _ downloadModel: MZDownloadModel, _ downloadCell: IMDownloadsCell, _ row: NSInteger, _ section: NSInteger) -> Void)?
    var cancelButtonBlock: ((_ downloadModel: MZDownloadModel, _ downloadCell: IMDownloadsCell, _ row: NSInteger, _ section: NSInteger) -> Void)?

    var cellIndexPath: IndexPath!
    var cellDownloadModel: MZDownloadModel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCellForRowAtIndexPath(_ indexPath : IndexPath, downloadModel: MZDownloadModel) {
        
        self.cellIndexPath = indexPath
        self.cellDownloadModel = downloadModel
        
        let fileName = downloadModel.fileName
        let progressValue = downloadModel.progress
        
        var remainingTime: String = ""
        if downloadModel.progress == 1.0 {
            remainingTime = "Please wait..."
        } else if let _ = downloadModel.remainingTime {
            if (downloadModel.remainingTime?.hours)! > 0 {
                remainingTime = "\(downloadModel.remainingTime!.hours) H"
            }
            if (downloadModel.remainingTime?.minutes)! > 0 {
                remainingTime = remainingTime + "\(downloadModel.remainingTime!.minutes) M"
            }
            if (downloadModel.remainingTime?.seconds)! > 0 {
                remainingTime = remainingTime + "\(downloadModel.remainingTime!.seconds) s"
            }
        } else {
            remainingTime = "Calculating..."
        }
        
        var fileSize = "Getting information..."
        if let _ = downloadModel.file?.size {
            fileSize = String(format: "%.f %@", (downloadModel.file?.size)!, (downloadModel.file?.unit)!)
        }
        
        var speed = "Calculating..."
        if let _ = downloadModel.speed?.speed {
            speed = String(format: "%.2f %@/sec", (downloadModel.speed?.speed)!, (downloadModel.speed?.unit)!)
        }
        
        var downloadedFileSize = "Calculating..."
        if let _ = downloadModel.downloadedFile?.size {
            downloadedFileSize = String(format: "%.2f %@", (downloadModel.downloadedFile?.size)!, (downloadModel.downloadedFile?.unit)!)
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0) {
                self.progressView.value = CGFloat(progressValue*100)
            }
            self.titleLabel.text = fileName
            self.downloadedLabel.text = String(format: "%@/%@", downloadedFileSize,fileSize)
            self.timeLabel.text = remainingTime
            self.statusLabel.text = String(format: "%@", speed)
        }
    }
    @IBAction func toggleButtonTapped(_ sender: LGButton) {
        if (sender.titleString == "Resume") {
            if let callback = self.toggleButtonBlock {
                sender.titleString = "Pause"
                callback(1, self.cellDownloadModel, self, self.cellIndexPath.row, self.cellIndexPath.section)
            }
        } else if (sender.titleString == "Pause") {
            if let callback = self.toggleButtonBlock {
                sender.titleString = "Resume"
                callback(2, self.cellDownloadModel, self, self.cellIndexPath.row, self.cellIndexPath.section)
            }
        }
    }
    @IBAction func cancelButtonTapped(_ sender: LGButton) {
        if let callback = self.cancelButtonBlock {
            callback(self.cellDownloadModel, self, self.cellIndexPath.row, self.cellIndexPath.section)
        }
    }
}
