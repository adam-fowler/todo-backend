import Foundation
import FluentPostgresDriver
import Hummingbird
import HummingbirdFluent
import HummingbirdFoundation

func runApp(_ arguments: HummingbirdArguments) throws {
    let env = HBEnvironment()
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
    guard let databaseURL = env.get("DATABASE_URL") else { fatalError("No DATABASE_URL environment variable") }
    guard var postgresConfig = PostgresConfiguration(url: databaseURL) else {
        fatalError("Failed to create postgres configuration using \(databaseURL)")
    }
    postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
    app.fluent.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    // add migrations
    app.fluent.migrations.add(CreateTodo())
    // always migrate
    try app.fluent.migrate().wait()

    app.router.get("/") { _ in
        return "Hello"
    }
    let todoController = TodoController()
    todoController.addRoutes(to: app.router.group("todos"))

    app.start()
    app.wait()
}
