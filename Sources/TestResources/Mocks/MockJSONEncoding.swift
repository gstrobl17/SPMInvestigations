@testable import FoundationAbstractions
import Foundation

public class MockJSONEncoding: JSONEncoding {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let encodeValueCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        static let value = MethodParameter(rawValue: 1 << 0)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var value: Any?

    // MARK: - Variables to Use as Method Return Values

    //swiftlint:disable implicitly_unwrapped_optional
    public var encodeValueReturnValue: Data!
    //swiftlint:enable implicitly_unwrapped_optional

    public var errorToThrow: Error!
    public var encodeValueShouldThrowError = false


    public func reset() {
        calledMethods = []
        assignedParameters = []
        value = nil
    }

    // MARK: - Methods for Protocol Conformance

    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        calledMethods.insert(.encodeValueCalled)
        self.value = value
        assignedParameters.insert(.value)
        if encodeValueShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return encodeValueReturnValue
    }

}

extension MockJSONEncoding.Method: CustomStringConvertible {
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

        if self.contains(.encodeValueCalled) {
            handleFirst()
            value += ".encodeValueCalled"
        }

        value += "]"
        return value
    }
}

extension MockJSONEncoding.MethodParameter: CustomStringConvertible {
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

        if self.contains(.value) {
            handleFirst()
            value += ".value"
        }

        value += "]"
        return value
    }
}
