@testable import FoundationAbstractions
import Foundation

public class MockDateCreating: DateCreating {
    
    public var baseDate = Date(timeIntervalSince1970: 0)

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let now = Method(rawValue: 1)
        static let dateTimeIntervalSinceNowCalled = Method(rawValue: 2)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let timeIntervalSinceNow = MethodParameter(rawValue: 1)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var timeIntervalSinceNow: TimeInterval?

    public func reset() {
        calledMethods = []
        assignedParameters = []
        timeIntervalSinceNow = nil
    }

    // MARK: - Methods for Protocol Conformance

    public var now: Date {
        calledMethods.insert(.now)
        return baseDate
    }

    public func date(timeIntervalSinceNow interval: TimeInterval) -> Date {
        calledMethods.insert(.dateTimeIntervalSinceNowCalled)
        self.timeIntervalSinceNow = interval
        assignedParameters.insert(.timeIntervalSinceNow)
        return baseDate.addingTimeInterval(interval)
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

        if self.contains(.now) {
            handleFirst()
            value += ".now"
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
