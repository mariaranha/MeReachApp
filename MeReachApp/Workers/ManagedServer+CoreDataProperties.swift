//
//  ManagedServer+CoreDataProperties.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 18/09/20.
//
//

import Foundation
import CoreData


extension ManagedServer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedServer> {
        return NSFetchRequest<ManagedServer>(entityName: "ManagedServer")
    }

    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var url: String?

}
