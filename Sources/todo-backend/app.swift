import Foundation
import FluentSQLiteDriver
import Hummingbird
import HummingbirdFluent
import HummingbirdFoundation

func runApp(_ arguments: HummingbirdArguments) throws {
    let app = HBApplication(configuration: .init(address: .hostname(arguments.hostname, port: arguments.port)))
    // set encoder and decoder
    app.encoder = JSONEncoder()
    app.decoder = JSONDecoder()
    // middleware
    app.middleware.add(HBLogRequestsMiddleware(.debug))
    app.middleware.add(HBCORSMiddleware(
        allowOrigin: .originBased,
        allowHeaders: ["Content-Type"],
        allowMethods: [.GET, .OPTIONS, .POST, .DELETE, .PATCH]
    ))

    // add Fluent
    app.addFluent()
    // add sqlite database
    app.fluent.databases.use(.sqlite(.memory), as: .sqlite)
    // add migrations
    app.fluent.migrations.add(CreateTodo())
    // always migrate as SQLite is running in memory
    try app.fluent.migrate().wait()


    app.router.get("/") { _ in
        return "Hello"
    }
    let todoController = TodoController()
    todoController.addRoutes(to: app.router.group("todos"))

    app.start()
    app.wait()
}
