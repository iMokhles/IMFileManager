//
//  IMFoldersViewController.swift
//  IMFileManager
//
//  Created by iMokhles on 10/02/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation
import UIKit

class IMFoldersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var diskSpaceLabel: UILabel!
    
    var publicFolder: Folder!
    fileprivate var filesArray: [File]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view, typically from a nib.
        getAllFiles()
        setupDiskSpaceFooter()
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAllFiles() {
        let allFis = FileCDHelper.sharedFile.getAllFiles(forFolder: publicFolder)
        filesArray = allFis
        print("\(filesArray)")
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }
    private func setupDiskSpaceFooter() -> Void {
        diskSpaceLabel.text = "Free Space: \(IMDiskHelper().freeDiskSpaceInGB)"
    }
    
    // MARK: - UITabelViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesArray.count
    }
    
    // MARK: - UITabelViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fileCell = tableView.dequeueReusableCell(withIdentifier: "fileCell") as! IMFileCell
        
        let file = filesArray[indexPath.row]
        fileCell.configureCell(withFile: file)
        
        return fileCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let file = self.filesArray[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            FileCDHelper.sharedFile.deleteFile(fileId: Int(file.id))
            self.filesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let share = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            IMFFunctions.showUpdateNameAlert(viewC: self, completion: { (newName) in
                FileCDHelper.sharedFile.updateFileName(name: newName!, fileId: Int(file.id))
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        share.backgroundColor = UIColor.lightGray
        
        var protectedString = ""
        if (file.protected == true) {
            protectedString = "Unlock"
        } else {
            protectedString = "Lock"
        }
        let protected = UITableViewRowAction(style: .default, title: protectedString) { (action, indexPath) in
            if (file.protected == true) {
                file.protected = false
            } else {
                file.protected = true
            }
        }
        protected.backgroundColor = UIColor.black
        
        return [delete, share, protected]
        
    }
    
}
