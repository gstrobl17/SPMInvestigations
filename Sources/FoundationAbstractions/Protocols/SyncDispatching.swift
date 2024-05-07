import Foundation

public protocol SyncDispatching {
    var syncQueue: DispatchQueue { get }
}

public extension SyncDispatching {
    
    fileprivate var testing: Bool { //swiftlint:disable:this strict_fileprivate
        return ProcessInfo.processInfo.isRunningTests
    }
    
    fileprivate var currentQueueName: String? { //swiftlint:disable:this strict_fileprivate
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
    }
    
    fileprivate var isRunningOnQueueAlready: Bool { //swiftlint:disable:this strict_fileprivate
        guard let name = currentQueueName else { return false }
        return syncQueue.label == name
    }
    
    func executeWithBarrierSync(_ code: () -> Void) {
        if testing == true {
            code()
        } else {
            if isRunningOnQueueAlready {
                code()
            } else {
                syncQueue.sync(flags: .barrier) {
                    code()
                }
            }
        }
    }
    
    func executeWithSync(_ code: () -> Void) {
        if testing == true {
            code()
        } else {
            if isRunningOnQueueAlready {
                code()
            } else {
                syncQueue.sync {
                    code()
                }
            }
        }
    }
    
    func executeWithAsync(_ code: @escaping () -> Void) {
        if testing == true {
            code()
        } else {
            syncQueue.async {
                code()
            }
        }
    }
    
    func executeWithAsync(delayInMilliseconds delay: Int, code: @escaping () -> Void) {
        if testing == true {
            code()
        } else {
            let deadline = DispatchTime.now() + DispatchTimeInterval.milliseconds(delay)
            syncQueue.asyncAfter(deadline: deadline) {
                code()
            }
        }
    }

}
