//
//  File+CoreDataProperties.swift
//  
//
//  Created by iMokhles on 19/01/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension File {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var deletable: Bool
    @NSManaged public var ext: String?
    @NSManaged public var id: Int64
    @NSManaged public var mime: String?
    @NSManaged public var name: String?
    @NSManaged public var path: String?
    @NSManaged public var protected: Bool
    @NSManaged public var is_folder: Bool
    @NSManaged public var size: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var folder_id: Int64
    
}

