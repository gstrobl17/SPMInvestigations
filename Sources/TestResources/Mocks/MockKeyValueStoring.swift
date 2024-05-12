@testable import FoundationAbstractions
import Foundation

public class MockKeyValueStoring: KeyValueStoring {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let stringForKeyKeyCalled = Method(rawValue: 1 << 0)
        public static let boolForKeyKeyCalled = Method(rawValue: 1 << 1)
        public static let doubleForKeyKeyCalled = Method(rawValue: 1 << 2)
        public static let objectForKeyKeyCalled = Method(rawValue: 1 << 3)
        public static let setValueForKeyKeyCalled = Method(rawValue: 1 << 4)
        public static let setValueForKeyKeyCalled1 = Method(rawValue: 1 << 5)
        public static let setValueForKeyKeyCalled2 = Method(rawValue: 1 << 6)
        public static let removeObjectForKeyDefaultNameCalled = Method(rawValue: 1 << 7)
        public static let synchronizeCalled = Method(rawValue: 1 << 8)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let key = MethodParameter(rawValue: 1 << 0)
        public static let value = MethodParameter(rawValue: 1 << 1)
        public static let value1 = MethodParameter(rawValue: 1 << 2)
        public static let value2 = MethodParameter(rawValue: 1 << 3)
        public static let defaultName = MethodParameter(rawValue: 1 << 4)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var key: String?
    private(set) public var value: Any?
    private(set) public var value1: Double?
    private(set) public var value2: Bool?
    private(set) public var defaultName: String?

    // MARK: - Variables to Use as Method Return Values

    public var stringForKeyKeyReturnValue: String?
    public var boolForKeyKeyReturnValue = false
    public var doubleForKeyKeyReturnValue = 0.0
    public var objectForKeyKeyReturnValue: Any?
    public var synchronizeReturnValue = true

    public func reset() {
        calledMethods = []
        assignedParameters = []
        key = nil
        value = nil
        value1 = nil
        value2 = nil
        defaultName = nil
    }

    // MARK: - Methods for Protocol Conformance

    public func string(forKey key: String) -> String? {
        calledMethods.insert(.stringForKeyKeyCalled)
        self.key = key
        assignedParameters.insert(.key)
        return stringForKeyKeyReturnValue
    }

    public func bool(forKey key: String) -> Bool {
        calledMethods.insert(.boolForKeyKeyCalled)
        self.key = key
        assignedParameters.insert(.key)
        return boolForKeyKeyReturnValue
    }

    public func double(forKey key: String) -> Double {
        calledMethods.insert(.doubleForKeyKeyCalled)
        self.key = key
        assignedParameters.insert(.key)
        return doubleForKeyKeyReturnValue
    }

    public func object(forKey key: String) -> Any? {
        calledMethods.insert(.objectForKeyKeyCalled)
        self.key = key
        assignedParameters.insert(.key)
        return objectForKeyKeyReturnValue
    }

    public func set(_ value: Any?, forKey key: String) {
        calledMethods.insert(.setValueForKeyKeyCalled)
        self.value = value
        assignedParameters.insert(.value)
        self.key = key
        assignedParameters.insert(.key)
    }

    public func set(_ value: Double, forKey key: String) {
        calledMethods.insert(.setValueForKeyKeyCalled1)
        self.value1 = value
        assignedParameters.insert(.value1)
        self.key = key
        assignedParameters.insert(.key)
    }

    public func set(_ value: Bool, forKey key: String) {
        calledMethods.insert(.setValueForKeyKeyCalled2)
        self.value2 = value
        assignedParameters.insert(.value2)
        self.key = key
        assignedParameters.insert(.key)
    }

    public func removeObject(forKey defaultName: String) {
        calledMethods.insert(.removeObjectForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    public func synchronize() -> Bool {
        calledMethods.insert(.synchronizeCalled)
        return synchronizeReturnValue
    }

}

extension MockKeyValueStoring.Method: CustomStringConvertible {
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

        if self.contains(.stringForKeyKeyCalled) {
            handleFirst()
            value += ".stringForKeyKeyCalled"
        }
        if self.contains(.boolForKeyKeyCalled) {
            handleFirst()
            value += ".boolForKeyKeyCalled"
        }
        if self.contains(.doubleForKeyKeyCalled) {
            handleFirst()
            value += ".doubleForKeyKeyCalled"
        }
        if self.contains(.objectForKeyKeyCalled) {
            handleFirst()
            value += ".objectForKeyKeyCalled"
        }
        if self.contains(.setValueForKeyKeyCalled) {
            handleFirst()
            value += ".setValueForKeyKeyCalled"
        }
        if self.contains(.setValueForKeyKeyCalled1) {
            handleFirst()
            value += ".setValueForKeyKeyCalled1"
        }
        if self.contains(.setValueForKeyKeyCalled2) {
            handleFirst()
            value += ".setValueForKeyKeyCalled2"
        }
        if self.contains(.removeObjectForKeyDefaultNameCalled) {
            handleFirst()
            value += ".removeObjectForKeyDefaultNameCalled"
        }
        if self.contains(.synchronizeCalled) {
            handleFirst()
            value += ".synchronizeCalled"
        }

        value += "]"
        return value
    }
}

extension MockKeyValueStoring.MethodParameter: CustomStringConvertible {
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

        if self.contains(.key) {
            handleFirst()
            value += ".key"
        }
        if self.contains(.value) {
            handleFirst()
            value += ".value"
        }
        if self.contains(.value1) {
            handleFirst()
            value += ".value1"
        }
        if self.contains(.value2) {
            handleFirst()
            value += ".value2"
        }
        if self.contains(.defaultName) {
            handleFirst()
            value += ".defaultName"
        }

        value += "]"
        return value
    }
}
