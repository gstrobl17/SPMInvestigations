//
//  File.swift
//  
//
//  Created by Greg Strobl on 5/6/24.
//

import Foundation

public protocol NotificationPosting {

    func post(name aName: NSNotification.Name, object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?)

}
