import Foundation

public protocol KeyValueStoring {
    func string(forKey key: String) -> String?
    func bool(forKey key: String) -> Bool
    func double(forKey key: String) -> Double
    func object(forKey key: String) -> Any?
    func set(_ value: Any?, forKey key: String)
    func set(_ value: Double, forKey key: String)
    func set(_ value: Bool, forKey key: String)
    
    func removeObject(forKey defaultName: String)
    
    func synchronize() -> Bool
}
