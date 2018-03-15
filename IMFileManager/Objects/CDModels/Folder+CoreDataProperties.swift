//
//  Folder+CoreDataProperties.swift
//  
//
//  Created by iMokhles on 19/01/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Folder {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var path: String?
    @NSManaged public var protected: Bool
    @NSManaged public var is_main: Bool
    @NSManaged public var size: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var parent_id: Int64    
}
