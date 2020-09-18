//
//  ServersCoreData.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 18/09/20.
//

import Foundation
import CoreData
import UIKit

class ServersCoreData: ServersStoreProtocol{
    
    // MARK: - Managed object contexts
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext
    
    // MARK: - Object lifecycle
    
    init(){
        mainManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        privateManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    deinit
    {
      do {
        try self.mainManagedObjectContext.save()
      } catch {
        fatalError("Error deinitializing main managed object context")
      }
    }
    
    // MARK: - CRUD operations
    
    func fetchServers(completionHandler: @escaping (() throws -> [Server]) -> Void)
    {
      privateManagedObjectContext.perform {
        do {
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedServer")
          let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedServer]
          let servers = results.map { $0.toServer() }
          completionHandler { return servers }
        } catch {
          completionHandler { throw ServersStoreError.CannotFetch("Cannot fetch servers") }
        }
      }
    }
    
    func createServer(serverToCreate: Server, completionHandler: @escaping (() throws -> Server?) -> Void)
    {
      privateManagedObjectContext.perform {
        do {
          let managedServer = NSEntityDescription.insertNewObject(forEntityName: "ManagedServer", into: self.privateManagedObjectContext) as! ManagedServer
          let server = serverToCreate
          managedServer.fromServer(server: server)
          try self.privateManagedObjectContext.save()
          completionHandler { return server }
        } catch {
          completionHandler { throw ServersStoreError.CannotCreate("Cannot create server") }
        }
      }
    }
    
    func deleteServer(serverToDelete: Server, completionHandler: @escaping (() throws -> Server?) -> Void)
    {
      privateManagedObjectContext.perform {
        do {
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedServer")
            fetchRequest.predicate = NSPredicate(format: "name == %@", serverToDelete.name)
          let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedServer]
          if let managedServer = results.first {
            let server = managedServer.toServer()
            self.privateManagedObjectContext.delete(managedServer)
            do {
              try self.privateManagedObjectContext.save()
              completionHandler { return server }
            } catch {
                completionHandler { throw ServersStoreError.CannotDelete("Cannot delete server with name \(serverToDelete.name)") }
            }
          } else {
            throw ServersStoreError.CannotDelete("Cannot fetch server with name \(serverToDelete.name) to delete")
          }
        } catch {
          completionHandler { throw ServersStoreError.CannotDelete("Cannot fetch server with name \(serverToDelete.name) to delete") }
        }
      }
    }

}
