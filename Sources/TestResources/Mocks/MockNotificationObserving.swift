@testable import FoundationAbstractions
import UIKit

public class MockNotificationObserving: NotificationObserving {

    public init() { }

    // MARK: - Variables for Trackings Method Invocation

    public struct Method: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled = Method(rawValue: 1 << 0)
        public static let removeObserverObserverCalled = Method(rawValue: 1 << 1)
        public static let removeObserverObserverNameANameObjectAnObjectCalled = Method(rawValue: 1 << 2)
        public static let addObserverForNameNameObjectObjQueueUsingBlockCalled = Method(rawValue: 1 << 3)
    }
    private(set) public var calledMethods = Method()

    public struct MethodParameter: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) { self.rawValue = rawValue }
        public static let observer = MethodParameter(rawValue: 1 << 0)
        public static let aSelector = MethodParameter(rawValue: 1 << 1)
        public static let aName = MethodParameter(rawValue: 1 << 2)
        public static let anObject = MethodParameter(rawValue: 1 << 3)
        public static let name = MethodParameter(rawValue: 1 << 4)
        public static let obj = MethodParameter(rawValue: 1 << 5)
        public static let queue = MethodParameter(rawValue: 1 << 6)
        public static let block = MethodParameter(rawValue: 1 << 7)
    }
    private(set) public var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) public var observer: Any?
    private(set) public var aSelector: Selector?
    private(set) public var aName: NSNotification.Name?
    private(set) public var anObject: Any?
    private(set) public var name: NSNotification.Name?
    private(set) public var obj: Any?
    private(set) public var queue: OperationQueue?
    private(set) public var block: (@Sendable (Notification) -> Void)?

    // MARK: - Variables to Use as Method Return Values

    public var addObserverForNameNameObjectObjQueueUsingBlockReturnValue: NSObjectProtocol = NSObject()
    public var notificationForAddObserverBlock = Notification(name: UIApplication.didBecomeActiveNotification)

    // MARK: - Variables to Use to Control Completion Handlers

    public var shouldCallBlock = false

    public func reset() {
        calledMethods = []
        assignedParameters = []
        observer = nil
        aSelector = nil
        aName = nil
        anObject = nil
        name = nil
        obj = nil
        queue = nil
        block = nil
    }

    // MARK: - Methods for Protocol Conformance

    public func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        calledMethods.insert(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled)
        self.observer = observer
        assignedParameters.insert(.observer)
        self.aSelector = aSelector
        assignedParameters.insert(.aSelector)
        self.aName = aName
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
    }

    public func removeObserver(_ observer: Any) {
        calledMethods.insert(.removeObserverObserverCalled)
        self.observer = observer
        assignedParameters.insert(.observer)
    }

    public func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?) {
        calledMethods.insert(.removeObserverObserverNameANameObjectAnObjectCalled)
        self.observer = observer
        assignedParameters.insert(.observer)
        self.aName = aName
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
    }

    public func addObserver(forName name: NSNotification.Name?,
                     object obj: Any?,
                     queue: OperationQueue?,
                     using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol {
        calledMethods.insert(.addObserverForNameNameObjectObjQueueUsingBlockCalled)
        self.name = name
        assignedParameters.insert(.name)
        self.obj = obj
        assignedParameters.insert(.obj)
        self.queue = queue
        assignedParameters.insert(.queue)
        self.block = block
        assignedParameters.insert(.block)
        if shouldCallBlock {
            block(notificationForAddObserverBlock)
        }
        return addObserverForNameNameObjectObjQueueUsingBlockReturnValue
    }

}

extension MockNotificationObserving.Method: CustomStringConvertible {
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

        if self.contains(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled) {
            handleFirst()
            value += ".addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled"
        }
        if self.contains(.removeObserverObserverCalled) {
            handleFirst()
            value += ".removeObserverObserverCalled"
        }
        if self.contains(.removeObserverObserverNameANameObjectAnObjectCalled) {
            handleFirst()
            value += ".removeObserverObserverNameANameObjectAnObjectCalled"
        }
        if self.contains(.addObserverForNameNameObjectObjQueueUsingBlockCalled) {
            handleFirst()
            value += ".addObserverForNameNameObjectObjQueueUsingBlockCalled"
        }

        value += "]"
        return value
    }
}

extension MockNotificationObserving.MethodParameter: CustomStringConvertible {
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

        if self.contains(.observer) {
            handleFirst()
            value += ".observer"
        }
        if self.contains(.aSelector) {
            handleFirst()
            value += ".aSelector"
        }
        if self.contains(.aName) {
            handleFirst()
            value += ".aName"
        }
        if self.contains(.anObject) {
            handleFirst()
            value += ".anObject"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }
        if self.contains(.obj) {
            handleFirst()
            value += ".obj"
        }
        if self.contains(.queue) {
            handleFirst()
            value += ".queue"
        }
        if self.contains(.block) {
            handleFirst()
            value += ".block"
        }

        value += "]"
        return value
    }
}
