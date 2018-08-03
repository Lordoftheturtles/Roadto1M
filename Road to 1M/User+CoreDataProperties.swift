//
//  User+CoreDataProperties.swift
//  Road to 1M
//
//  Version 1.5v *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var title: String?

}
