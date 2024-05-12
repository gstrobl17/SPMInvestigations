@testable import FoundationAbstractions
import Foundation

public class MockNetworkDataFetching: NetworkDataFetching {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let dataForRequestDelegateCalled = Method(rawValue: 1 << 0)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let request = MethodParameter(rawValue: 1 << 0)
        public static let delegate = MethodParameter(rawValue: 1 << 1)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var request: URLRequest?
    private(set) public var delegate: URLSessionTaskDelegate?

    // MARK: - Variables to Use as Method Return Values

    public var dataForRequestDelegateReturnValue: (Data, URLResponse)!

    public var errorToThrow: Error!
    public var dataForRequestDelegateShouldThrowError = false


    public func reset() {
        calledMethods = []
        assignedParameters = []
        request = nil
        delegate = nil
    }

    // MARK: - Methods for Protocol Conformance

    public func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        calledMethods.insert(.dataForRequestDelegateCalled)
        self.request = request
        assignedParameters.insert(.request)
        self.delegate = delegate
        assignedParameters.insert(.delegate)
        if dataForRequestDelegateShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return dataForRequestDelegateReturnValue
    }

}

extension MockNetworkDataFetching.Method: CustomStringConvertible {
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

        if self.contains(.dataForRequestDelegateCalled) {
            handleFirst()
            value += ".dataForRequestDelegateCalled"
        }

        value += "]"
        return value
    }
}

extension MockNetworkDataFetching.MethodParameter: CustomStringConvertible {
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
        if self.contains(.delegate) {
            handleFirst()
            value += ".delegate"
        }

        value += "]"
        return value
    }
}
