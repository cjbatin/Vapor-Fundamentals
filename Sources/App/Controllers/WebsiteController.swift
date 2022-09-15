//
//  WebsiteController.swift
//  
//
//  Created by Christopher Batin on 09/09/2022.
//

import Vapor
import Leaf

struct WebsiteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexHandler)
    }

    struct IndexContext: Encodable {
        let title: String
        let rooms: [Room]
    }

    func indexHandler(_ req: Request) async throws -> View {
        let rooms = try await Room.query(on: req.db).all()
        let context = IndexContext(title: "Rooms", rooms: rooms)
        return try await req.view.render("index", context)
    }
}

