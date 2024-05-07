@testable import FoundationAbstractions
import Foundation

public class MockDataTaskCreating: DataTaskCreating {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static let createDataTaskWithRequestCalled = Method(rawValue: 1)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let request = MethodParameter(rawValue: 1)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var request: URLRequest?

    // MARK: - Variables to Use as Method Return Values

    //swiftlint:disable implicitly_unwrapped_optional
    public var createDataTaskWithRequestReturnValue: DataTask!
    //swiftlint:enable implicitly_unwrapped_optional

    public func reset() {
        calledMethods = []
        assignedParameters = []
        request = nil
    }

    // MARK: - Methods for Protocol Conformance

    public func createDataTask(with request: URLRequest) -> DataTask {
        calledMethods.insert(.createDataTaskWithRequestCalled)
        self.request = request
        assignedParameters.insert(.request)
        return createDataTaskWithRequestReturnValue
    }

}

extension MockDataTaskCreating.Method: CustomStringConvertible {
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

        if self.contains(.createDataTaskWithRequestCalled) {
            handleFirst()
            value += ".createDataTaskWithRequestCalled"
        }

        value += "]"
        return value
    }
}

extension MockDataTaskCreating.MethodParameter: CustomStringConvertible {
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

        if self.contains(.request) {
            handleFirst()
            value += ".request"
        }

        value += "]"
        return value
    }
}
