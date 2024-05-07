@testable import FoundationAbstractions
import Foundation

public class MockDataTask: NSObject, DataTask {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let cancelCalled = Method(rawValue: 1)
        static let resumeCalled = Method(rawValue: 2)
    }
    private(set) public var calledMethods = Method()

    public func reset() {
        calledMethods = []
    }

    // MARK: - Methods for Protocol Conformance

    public func cancel() {
        calledMethods.insert(.cancelCalled)
    }

    public func resume() {
        calledMethods.insert(.resumeCalled)
    }

}

extension MockDataTask.Method: CustomStringConvertible {
    public var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }

        if self.contains(.cancelCalled) {
            handleFirst()
            value += ".cancelCalled"
        }
        if self.contains(.resumeCalled) {
            handleFirst()
            value += ".resumeCalled"
        }

        value += "]"
        return value
    }
}
