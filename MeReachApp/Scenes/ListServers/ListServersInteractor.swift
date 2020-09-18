//
//  ListServersInteractor.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 15/09/20.
//  Copyright (c) 2020. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListServersBusinessLogic {
    func fetchServers(request: ListServers.FetchServers.Request)
    func deleteServer(request: ListServers.DeleteServer.Request)
}

protocol ListServersDataStore {
    var servers: [Server]? { get }
    var serverToEdit: Server? { get set }
}

class ListServersInteractor: ListServersBusinessLogic, ListServersDataStore {
  var presenter: ListServersPresentationLogic?

  var serversWorker = ServersWorker(serversStore: ServersCoreData())
  var servers: [Server]?
  var serverToEdit: Server?
    
    // MARK: - Fetch servers

    func fetchServers(request: ListServers.FetchServers.Request) {
        serversWorker.fetchServers { (servers) -> Void in
        self.servers = servers
        let response = ListServers.FetchServers.Response(servers: servers)
        self.presenter?.presentFetchedServers(response: response)
        }
    }
    
    // MARK: - Delete server
    
    func deleteServer(request: ListServers.DeleteServer.Request) {
      let serverToDelete = buildServerFromServerFormFields(request.serverFormFields)
      
        serversWorker.deleteServer(serverToDelete: serverToDelete) { (server: Server?) in
        self.serverToEdit = server

      }
    }
    
    private func buildServerFromServerFormFields(_ serverFormFields: ListServers.ServerFormFields) -> Server {
        return Server(name: serverFormFields.name, status: serverFormFields.status, url: serverFormFields.url)
    }
}
