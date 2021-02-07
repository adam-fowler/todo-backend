import ArgumentParser
import Hummingbird

struct HummingbirdArguments: ParsableCommand {
    static var env = HBEnvironment()
    
    @Option(name: .shortAndLong)
    var hostname: String = "127.0.0.1"

    @Option(name: .shortAndLong)
    var port: Int = env.get("PORT", as: Int.self) ?? 8080

    func run() throws {
        try runApp(self)
    }
}

HummingbirdArguments.main()
