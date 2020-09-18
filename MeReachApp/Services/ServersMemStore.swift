////
////  ServersMemStore.swift
////  MeReachApp
////
////  Created by Marina Miranda Aranha on 17/09/20.
////
//
//import Foundation
//
//class ServersMemStore: ServersStoreProtocol
//{
//    
//  // MARK: - Data
//  
//  static var servers = [Server(name: "Google", status: "online"),
//                        Server(name: "Amazon", status: "offline")]
//  
//  // MARK: - CRUD operations - Optional error
//  
//  func fetchServers(completionHandler: @escaping ([Server], ServersStoreError?) -> Void)
//  {
//    completionHandler(type(of: self).servers, nil)
//  }
//
//  func createServer(serverToCreate: Server, completionHandler: @escaping (Server?, ServersStoreError?) -> Void)
//  {
//    let server = serverToCreate
//    type(of: self).servers.append(server)
//    completionHandler(server, nil)
//  }
//  
////  func deleteOrder(id: String, completionHandler: @escaping (Order?, OrdersStoreError?) -> Void)
////  {
////    if let index = indexOfOrderWithID(id: id) {
////      let order = type(of: self).orders.remove(at: index)
////      completionHandler(order, nil)
////      return
////    }
////    completionHandler(nil, OrdersStoreError.CannotDelete("Cannot fetch order with id \(id) to delete"))
////  }
////
//  // MARK: - CRUD operations - Generic enum result type
//  
////  func fetchOrders(completionHandler: @escaping OrdersStoreFetchOrdersCompletionHandler)
////  {
////    completionHandler(OrdersStoreResult.Success(result: type(of: self).orders))
////  }
////
////  func fetchOrder(id: String, completionHandler: @escaping OrdersStoreFetchOrderCompletionHandler)
////  {
////    let order = type(of: self).orders.filter { (order: Order) -> Bool in
////      return order.id == id
////      }.first
////    if let order = order {
////      completionHandler(OrdersStoreResult.Success(result: order))
////    } else {
////      completionHandler(OrdersStoreResult.Failure(error: OrdersStoreError.CannotFetch("Cannot fetch order with id \(id)")))
////    }
////  }
//  
////  func createOrder(orderToCreate: Order, completionHandler: @escaping OrdersStoreCreateOrderCompletionHandler)
////  {
////    var order = orderToCreate
////    generateOrderID(order: &order)
////    calculateOrderTotal(order: &order)
////    type(of: self).orders.append(order)
////    completionHandler(OrdersStoreResult.Success(result: order))
////  }
////
////  func updateOrder(orderToUpdate: Order, completionHandler: @escaping OrdersStoreUpdateOrderCompletionHandler)
////  {
////    if let index = indexOfOrderWithID(id: orderToUpdate.id) {
////      type(of: self).orders[index] = orderToUpdate
////      let order = type(of: self).orders[index]
////      completionHandler(OrdersStoreResult.Success(result: order))
////    } else {
////      completionHandler(OrdersStoreResult.Failure(error: OrdersStoreError.CannotUpdate("Cannot update order with id \(String(describing: orderToUpdate.id)) to update")))
////    }
////  }
////
////  func deleteOrder(id: String, completionHandler: @escaping OrdersStoreDeleteOrderCompletionHandler)
////  {
////    if let index = indexOfOrderWithID(id: id) {
////      let order = type(of: self).orders.remove(at: index)
////      completionHandler(OrdersStoreResult.Success(result: order))
////      return
////    }
////    completionHandler(OrdersStoreResult.Failure(error: OrdersStoreError.CannotDelete("Cannot delete order with id \(id) to delete")))
////  }
//  
//  // MARK: - CRUD operations - Inner closure
//  
//  func fetchServers(completionHandler: @escaping (() throws -> [Server]) -> Void)
//  {
//    completionHandler { return type(of: self).servers }
//  }
//
//  func createServer(serverToCreate: Server, completionHandler: @escaping (() throws -> Server?) -> Void)
//  {
//    let server = serverToCreate
//    type(of: self).servers.append(server)
//    completionHandler { return server }
//  }
//  
////  func deleteOrder(id: String, completionHandler: @escaping (() throws -> Order?) -> Void)
////  {
////    if let index = indexOfOrderWithID(id: id) {
////      let order = type(of: self).orders.remove(at: index)
////      completionHandler { return order }
////    } else {
////      completionHandler { throw OrdersStoreError.CannotDelete("Cannot fetch order with id \(id) to delete") }
////    }
////  }
//
//}
//
