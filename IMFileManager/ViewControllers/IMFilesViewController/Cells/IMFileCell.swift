//
//  IMFileCell.swift
//  IMFileManager
//
//  Created by iMokhles on 19/01/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation
import UIKit

class IMFileCell: UITableViewCell {
    
    @IBOutlet var fileIconView: UIImageView!
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var fileSizeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withFile file:File) -> Void {
        
        var iconImage: UIImage? = nil
        
        if (file.is_folder) {
            iconImage = UIImage(named: "folder_icon_iPhone")
            fileSizeLabel.text = "folder"
        } else {
            if (file.ext != nil) {
                iconImage = UIImage(named: String(format: "%@_iPhone", file.ext!))
            } else {
                iconImage = UIImage(named: "unknown")
            }
            fileSizeLabel.text = String(format: "%@ %@", MZUtility.calculateFileSizeInUnit(Int64(file.size!)!), MZUtility.calculateUnit(Int64(file.size!)!))
        }
        
        fileIconView.image = iconImage
        fileNameLabel.text = file.name
    }
    
    func configureCell(withFolder folder:Folder) -> Void {
        
        let iconImage = UIImage(named: "folder_icon_iPhone")
        fileIconView.image = iconImage
        fileNameLabel.text = folder.name
        fileSizeLabel.text = "folder"
    }
}
