import Foundation

public extension ProcessInfo {
    
    @objc var isRunningTests: Bool {
        return environment["XCTestConfigurationFilePath"] != nil
    }
    
}
