//
//  Rooms.swift
//  
//
//  Created by Christopher Batin on 07/09/2022.
//

import Fluent
import Vapor

final class Room: Model, Content {
    static let schema = "rooms"

    @ID
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "capacity")
    var capacity: Int

    init() { }

    init(id: UUID? = nil, name: String, capacity: Int) {
        self.id = id
        self.name = name
        self.capacity = capacity
    }
}
