//
//  AddServerInteractor.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 17/09/20.
//  Copyright (c) 2020. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddServerBusinessLogic {
    var statusTypes: [String] { get }
    func addServer(request: AddServer.AddServer.Request)
}

protocol AddServerDataStore {
  //var name: String { get set }
}

class AddServerInteractor: AddServerBusinessLogic, AddServerDataStore {
    var presenter: AddServerPresentationLogic?
    var serversWorker = ServersWorker(serversStore: ServersCoreData())
    
    var statusTypes = [
        StatusTypes(status: .online).toString(),
        StatusTypes(status: .offline).toString()
    ]
    

    func addServer(request: AddServer.AddServer.Request) {
      let serverToCreate = buildServerFromServerFormFields(request.serverFormFields)
        
        
      serversWorker.createServer(serverToCreate: serverToCreate) { (server: Server?) in
        let response = AddServer.AddServer.Response(server: server)
        self.presenter?.presentAddedServer(response: response)
      }
    }
  
    private func buildServerFromServerFormFields(_ serverFormFields: AddServer.ServerFormFields) -> Server {
        return Server(name: serverFormFields.name, status: serverFormFields.status, url: serverFormFields.url)
    }

}
