import Vapor
import Queues

func queues(_ app: Application) throws {
    // MARK: Queues Configuration
    if app.environment != .testing {
        try app.queues.use(
            .redis(url:
                "redis://\(Environment.get("REDIS_USERNAME") ?? ""):\(Environment.get("REDIS_PASSWORD") ?? "")@\(Environment.get("REDIS_HOST") ?? ""):\(Environment.get("DEFAULT_REDIS_PORT") ?? "6379")"
            )
        )
    }
    
    // MARK: Jobs
//    app.queues.add(EmailJob())
}
