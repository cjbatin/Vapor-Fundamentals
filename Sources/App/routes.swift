import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: RoomsController())
    try app.register(collection: WebsiteController())
}
