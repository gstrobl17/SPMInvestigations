@testable import FoundationAbstractions
import Foundation

public class MockDateCreating: DateCreating {
    
    public init() { }

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    public var _now: Date = Date()

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let nowGetterCalled = Method(rawValue: 1 << 0)
        public static let dateTimeIntervalSinceNowCalled = Method(rawValue: 1 << 1)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let timeIntervalSinceNow = MethodParameter(rawValue: 1 << 0)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var timeIntervalSinceNow: TimeInterval?

    // MARK: - Variables to Use as Method Return Values

    public var dateTimeIntervalSinceNowReturnValue: Date = Date()

    public func reset() {
        calledMethods = []
        assignedParameters = []
        timeIntervalSinceNow = nil
    }

    // MARK: - Properties for Protocol Conformance

    public var now: Date {
        calledMethods.insert(.nowGetterCalled)
        return _now
    }

    // MARK: - Methods for Protocol Conformance

    public func date(timeIntervalSinceNow: TimeInterval) -> Date {
        calledMethods.insert(.dateTimeIntervalSinceNowCalled)
        self.timeIntervalSinceNow = timeIntervalSinceNow
        assignedParameters.insert(.timeIntervalSinceNow)
        return dateTimeIntervalSinceNowReturnValue
    }

}

extension MockDateCreating.Method: CustomStringConvertible {
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

        if self.contains(.nowGetterCalled) {
            handleFirst()
            value += ".nowGetterCalled"
        }
        if self.contains(.dateTimeIntervalSinceNowCalled) {
            handleFirst()
            value += ".dateTimeIntervalSinceNowCalled"
        }

        value += "]"
        return value
    }
}

extension MockDateCreating.MethodParameter: CustomStringConvertible {
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

        if self.contains(.timeIntervalSinceNow) {
            handleFirst()
            value += ".timeIntervalSinceNow"
        }

        value += "]"
        return value
    }
}

extension MockDateCreating: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "assignedParameters": assignedParameters,
               ],
               displayStyle: .none
        )
    }
}
