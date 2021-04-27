import UIKit
import Foundation

extension UserDefaults {
    func setValue(_ value: Any?, forKey key: UserDefaultsKeys) {
        setValue(value, forKey: key.rawValue)
    }
}
