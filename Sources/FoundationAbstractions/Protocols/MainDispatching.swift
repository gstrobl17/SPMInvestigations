import Foundation

public protocol MainDispatching { }

public extension MainDispatching {
    
    func executeAsyncOnMain(_ code: @escaping () -> Void) {
        if ProcessInfo.processInfo.isRunningTests {
            code()
        } else {
            DispatchQueue.main.async {
                code()
            }
        }
    }
    
}
