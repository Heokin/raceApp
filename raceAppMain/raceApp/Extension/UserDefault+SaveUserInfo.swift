
import UIKit

extension UserDefaults {
    func keepUser(forKey key: String) {
        do {
            let data = try JSONEncoder().encode(ViewController.user)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
}
