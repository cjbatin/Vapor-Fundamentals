//
//  RoomsController.swift
//  
//
//  Created by Christopher Batin on 07/09/2022.
//

import Vapor
import Fluent

struct RoomsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let roomsRoute = routes.grouped("api", "rooms")
        roomsRoute.post(use: createHandler)
        roomsRoute.get(use: getAllHandler)
        roomsRoute.get(":roomID", use: getHandler)
        roomsRoute.put(":roomID", use: updateHandler)
        roomsRoute.delete(":roomID", use: deleteHandler)
    }
    func createHandler(_ req: Request) async throws -> Room {
        let room = try req.content.decode(Room.self)
        try await room.save(on: req.db)
        return room
    }
    func getAllHandler(_ req: Request) async throws -> [Room] {
        try await Room.query(on: req.db).all()
    }
    func getHandler(_ req: Request) async throws -> Room {
        guard let room = try await Room.find(req.parameters.get("roomID"),
                                             on: req.db) else {
            throw Abort(.notFound)
        }
        return room
    }
    func updateHandler(_ req: Request) async throws -> Room {
        let update = try req.content.decode(Room.self)
        guard let room = try await Room.find(req.parameters.get("roomID"),
                                             on: req.db) else {
            throw Abort(.notFound)
        }
        room.name = update.name
        room.capacity = update.capacity
        try await room.save(on: req.db)
        return room
    }
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let room = try await Room.find(req.parameters.get("roomID"),
                                             on: req.db) else {
            throw Abort(.notFound)
        }
        try await room.delete(on: req.db)
        return HTTPStatus.noContent
    }
}


