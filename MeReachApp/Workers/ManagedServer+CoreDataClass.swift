//
//  ManagedServer+CoreDataClass.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 18/09/20.
//
//

import Foundation
import CoreData

@objc(ManagedServer)
public class ManagedServer: NSManagedObject {
    
    func toServer() -> Server
    {
        return Server(name: name!, status: status!, url: url!)
    }
    
    
    func fromServer(server: Server)
    {
        name = server.name
        status = server.status
        url = server.url
    
    }

}
