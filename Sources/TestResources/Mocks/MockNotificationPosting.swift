@testable import FoundationAbstractions
import Foundation

public class MockNotificationPosting: NotificationPosting {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let postNameANameObjectAnObjectCalled = Method(rawValue: 1 << 0)
        public static let postNameANameObjectAnObjectUserInfoAUserInfoCalled = Method(rawValue: 1 << 1)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let aName = MethodParameter(rawValue: 1 << 0)
        public static let anObject = MethodParameter(rawValue: 1 << 1)
        public static let aUserInfo = MethodParameter(rawValue: 1 << 2)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var aName: NSNotification.Name?
    private(set) public var anObject: Any?
    private(set) public var aUserInfo: [AnyHashable: Any]?

    private(set) public var postedNames = [NSNotification.Name]()

    public func reset() {
        calledMethods = []
        assignedParameters = []
        aName = nil
        anObject = nil
        aUserInfo = nil
        postedNames = []
    }

    // MARK: - Methods for Protocol Conformance

    public func post(name aName: NSNotification.Name, object anObject: Any?) {
        calledMethods.insert(.postNameANameObjectAnObjectCalled)
        self.aName = aName
        postedNames.append(aName)
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
    }

    public func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?) {
        calledMethods.insert(.postNameANameObjectAnObjectUserInfoAUserInfoCalled)
        self.aName = aName
        postedNames.append(aName)
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
        self.aUserInfo = aUserInfo
        assignedParameters.insert(.aUserInfo)
    }

}

extension MockNotificationPosting.Method: CustomStringConvertible {
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

        if self.contains(.postNameANameObjectAnObjectCalled) {
            handleFirst()
            value += ".postNameANameObjectAnObjectCalled"
        }
        if self.contains(.postNameANameObjectAnObjectUserInfoAUserInfoCalled) {
            handleFirst()
            value += ".postNameANameObjectAnObjectUserInfoAUserInfoCalled"
        }

        value += "]"
        return value
    }
}

extension MockNotificationPosting.MethodParameter: CustomStringConvertible {
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

        if self.contains(.aName) {
            handleFirst()
            value += ".aName"
        }
        if self.contains(.anObject) {
            handleFirst()
            value += ".anObject"
        }
        if self.contains(.aUserInfo) {
            handleFirst()
            value += ".aUserInfo"
        }

        value += "]"
        return value
    }
}

extension MockNotificationPosting: CustomReflectable {
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
