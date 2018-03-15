//
//  FolderCDHelper.swift
//  IMFileManager
//
//  Created by iMokhles on 19/01/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation

class FolderCDHelper: CDCrud {
    
    fileprivate let entityName = "Folder"
    
    static var sharedFolder: FolderCDHelper = {
        let shared = FolderCDHelper()
        return shared
    }()
    
    func getLastFolderId() -> Int64 {
        let lastFolder = readLastObject(entityName: self.entityName) as! Folder
        return lastFolder.id
    }
    func getAllFolders() -> [Folder] {
        let allFolders = readAllObjects(entityName: self.entityName, predicate: String(format: "parent_id = '0'")) as! [Folder]
        return allFolders
    }
    func getFolderByName(folderName: String) -> Folder {
        let folder = readObjectWhereKey(entityName: self.entityName, predicate: String(format: "name = '%@'", folderName)) as! Folder
        return folder
    }

    func addNewFolder(folderName: String, fullPath: String, parent: Folder? = nil, is_main: Bool? = false) -> Folder {
        
        var props = [String:Any]()
        
        props["name"] = folderName;
        props["path"] = fullPath;
        props["size"] = ""
        props["is_main"] = is_main
        if (parent != nil) {
            props["parent_id"] = parent?.id
        }
        
        return createNewObjectWithProperties(entityName: self.entityName, properties: props) as! Folder
        
    }
    func updateFolderName(name:String, folderId:Int) -> Void {
        updateObjectWithId(entityName: self.entityName, id: folderId, properties: [
            "name": name,
            ])
    }
    func deleteFolder(folderId:Int) -> Void {
        let folderObject = readObject(entityName: self.entityName, id: folderId)
        deleteObject(folderObject!)
    }
}
