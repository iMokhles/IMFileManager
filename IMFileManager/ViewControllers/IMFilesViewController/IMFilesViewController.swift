//
//  IMFilesViewController.swift
//  IMFileManager
//
//  Created by iMokhles on 28/12/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

import Foundation
import UIKit

class IMFilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTable: UITableView!
    @IBOutlet var diskSpaceLabel: UILabel!

    fileprivate var filesArray: [File]!
    fileprivate var foldersArray: [Folder]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view, typically from a nib.
        getAllFolders()
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
        filesArray = CDCrud.sharedCrud.readAllObjects(entityName: "File") as! [File]
    }
    private func getAllFolders() {
        let allFds = FolderCDHelper.sharedFolder.getAllFolders()
        foldersArray = allFds
        print("\(foldersArray)")
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
        return foldersArray.count
//        return filesArray.count
    }
    
    // MARK: - UITabelViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fileCell = tableView.dequeueReusableCell(withIdentifier: "fileCell") as! IMFileCell
        
//        let file = filesArray[indexPath.row]
        let folder = foldersArray[indexPath.row]

        fileCell.configureCell(withFolder: folder)
        
        return fileCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        foldersVC
        let folder = self.foldersArray[indexPath.row]
        if (folder.protected == false) {
            let foldersVC = self.storyboard?.instantiateViewController(withIdentifier: "foldersVC") as! IMFoldersViewController
            
            foldersVC.publicFolder = folder
            
            navigationController?.pushViewController(foldersVC, animated: true)
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let folder = self.foldersArray[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            FolderCDHelper.sharedFolder.deleteFolder(folderId: Int(folder.id))
            self.foldersArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            IMFFunctions.showUpdateNameAlert(viewC: self, completion: { (newName) in
                FolderCDHelper.sharedFolder.updateFolderName(name: newName!, folderId: Int(folder.id))
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        edit.backgroundColor = UIColor.lightGray
        
        var protectedString = ""
        if (folder.protected == true) {
            protectedString = "Unlock"
        } else {
            protectedString = "Lock"
        }
        let protected = UITableViewRowAction(style: .default, title: protectedString) { (action, indexPath) in
            if (folder.protected == true) {
                folder.protected = false
            } else {
                folder.protected = true
            }
        }
        protected.backgroundColor = UIColor.black
        
        if (folder.is_main == true) {
            return [edit, protected]
        } else {
            return [delete, edit, protected]
        }
        
        
    }
    
}
