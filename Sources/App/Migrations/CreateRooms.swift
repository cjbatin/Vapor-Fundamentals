//
//  CreateRooms.swift
//  
//
//  Created by Christopher Batin on 07/09/2022.
//

import Fluent

struct CreateRooms: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("rooms")
            .id()
            .field("name", .string, .required)
            .field("capacity", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("rooms").delete()
    }
}
