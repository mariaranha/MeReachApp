//
//  Server.swift
//  MeReachApp
//
//  Created by Marina Miranda Aranha on 16/09/20.
//

import Foundation

struct Server: Equatable{
    var name: String
    var status: String
    var url: String
}

struct StatusTypes {
    enum StatusSeed: Int {
        case online = 0
        case offline = 1
    }
    var status: StatusSeed
  
    func toString() -> String {
        switch status {
        case .online:
          return "online"
        case .offline:
          return "offline"
        }
    }
}

func ==(lhs: StatusTypes, rhs: StatusTypes) -> Bool{
    return lhs.status == rhs.status
}
