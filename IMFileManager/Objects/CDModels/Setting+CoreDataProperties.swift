//
//  Setting+CoreDataProperties.swift
//  
//
//  Created by iMokhles on 19/01/2018.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Setting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setting> {
        return NSFetchRequest<Setting>(entityName: "Setting")
    }

    @NSManaged public var key: String?
    @NSManaged public var type: String?
    @NSManaged public var value: String?

}
