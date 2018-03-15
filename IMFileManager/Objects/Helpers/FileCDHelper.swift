//
//  FileCDHelper.swift
//  IMFileManager
//
//  Created by iMokhles on 19/01/2018.
//  Copyright © 2018 iMokhles. All rights reserved.
//

import Foundation

class FileCDHelper: CDCrud {
    
    fileprivate let entityName = "File"
    
    static var sharedFile: FileCDHelper = {
        let shared = FileCDHelper()
        return shared
    }()
    
    func getLastFileId() -> Int64 {
        let lastFile = readLastObject(entityName: self.entityName) as! File
        return lastFile.id
    }
    func getAllFiles() -> [File] {
        let allFiles = readAllObjects(entityName: self.entityName) as! [File]
        return allFiles
    }
    func getAllFiles(forFolder folder:Folder) -> [File] {
        let allFiles = readAllObjects(entityName: self.entityName, predicate: String(format: "folder_id == %d", folder.id)) as! [File]
        return allFiles
    }
    func getFolderByName(folderName: String) -> File {
        let folder = readObjectWhereKey(entityName: self.entityName, predicate: String(format: "name = '%@' AND is_folder = 1", folderName)) as! File
        return folder
    }
    func addNewFile(downloadModel: MZDownloadModel, folder: File? = nil) -> File {
        
        var props = [String:Any]()
        
        props["name"] = downloadModel.fileName;
        if (folder != nil) {
            props["folder_id"] = folder?.id;
        }
        props["path"] = downloadModel.destinationPath+"/"+downloadModel.fileName;
        props["mime"] = downloadModel.fileName.getExtension()!;
        props["ext"] = downloadModel.fileName.getExtension()!;
        props["size"] = "";

        return createNewObjectWithProperties(entityName: self.entityName, properties: props) as! File
        
    }
    
    func addNewFolder(folderName: String, fullPath: String, parent: Folder? = nil) -> File {
        
        var props = [String:Any]()
        
        props["name"] = folderName;
        props["path"] = fullPath;
        props["size"] = ""
        props["is_folder"] = true
        if (parent != nil) {
            props["folder_id"] = parent?.id
        }
        
        return createNewObjectWithProperties(entityName: self.entityName, properties: props) as! File
        
    }
    
    func addNewFolderInFolder(folderName: String, fullPath: String, parent: File? = nil) -> File {
        
        var props = [String:Any]()
        
        props["name"] = folderName;
        props["path"] = fullPath;
        props["size"] = ""
        props["is_folder"] = true
        if (parent != nil) {
            props["folder_id"] = parent?.id
        }
        
        return createNewObjectWithProperties(entityName: self.entityName, properties: props) as! File
        
    }
    
    func updateFileName(name:String, fileId:Int) -> Void {
        updateObjectWithId(entityName: self.entityName, id: fileId, properties: [
            "name": name
            ])
    }
    func deleteFile(fileId:Int) -> Void {
        let fileObject = readObject(entityName: self.entityName, id: fileId)
        deleteObject(fileObject!)
    }
}
