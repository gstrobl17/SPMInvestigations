import Foundation

public protocol NotificationObserving {
    
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)
    
    func removeObserver(_ observer: Any)

    func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?)

    func addObserver(forName name: NSNotification.Name?,
                     object obj: Any?,
                     queue: OperationQueue?,
                     using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol
}
