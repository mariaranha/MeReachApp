//
//  ServersWorker.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 17/09/20.
//

import Foundation

class ServersWorker {
    var serversStore: ServersStoreProtocol
  
    init(serversStore: ServersStoreProtocol){
        self.serversStore = serversStore
    }
  
    func fetchServers(completionHandler: @escaping ([Server]) -> Void){
      serversStore.fetchServers { (servers: () throws -> [Server]) -> Void in
        do {
          let servers = try servers()
          DispatchQueue.main.async {
            completionHandler(servers)
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler([])
          }
        }
      }
    }
    
    func createServer(serverToCreate: Server, completionHandler: @escaping (Server?) -> Void){
        serversStore.createServer(serverToCreate: serverToCreate) { (server: () throws -> Server?) -> Void in
          do {
            let server = try server()
            DispatchQueue.main.async {
              completionHandler(server)
            }
          } catch {
            DispatchQueue.main.async {
              completionHandler(nil)
            }
          }
        }
    }
    
    func deleteServer(serverToDelete: Server, completionHandler: @escaping (Server?) -> Void){
        serversStore.deleteServer(serverToDelete: serverToDelete) { (server: () throws -> Server?) -> Void in
            do {
              let server = try server()
              DispatchQueue.main.async {
                completionHandler(server)
              }
            } catch {
              DispatchQueue.main.async {
                completionHandler(nil)
              }
            }
        }
    }

}

protocol ServersStoreProtocol{
    func fetchServers(completionHandler: @escaping (() throws -> [Server]) -> Void)
    func createServer(serverToCreate: Server, completionHandler: @escaping (() throws -> Server?) -> Void)
    func deleteServer(serverToDelete: Server, completionHandler: @escaping (() throws -> Server?) -> Void)
}

// MARK: - CRUD operation results

typealias ServersStoreFetchServerCompletionHandler = (ServersStoreResult<[Server]>) -> Void
typealias ServersStoreCreateServerCompletionHandler = (ServersStoreResult<Server>) -> Void
typealias ServersStoreDeleteServerCompletionHandler = (ServersStoreResult<Server>) -> Void

enum ServersStoreResult<U>{
    case Success(result: U)
    case Failure(error: ServersStoreError)
}

// MARK: - CRUD operation errors

enum ServersStoreError: Equatable, Error{
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotDelete(String)
}

func ==(lhs: ServersStoreError, rhs: ServersStoreError) -> Bool{
    switch (lhs, rhs) {
        case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
        case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
        case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
        default: return false
    }
}

