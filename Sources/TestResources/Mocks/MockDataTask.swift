@testable import FoundationAbstractions
import Foundation

public class MockDataTask: NSObject, DataTask {

    public override init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let cancelCalled = Method(rawValue: 1 << 0)
        public static let resumeCalled = Method(rawValue: 1 << 1)
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

extension MockDataTask: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
               ],
               displayStyle: .none
        )
    }
}
