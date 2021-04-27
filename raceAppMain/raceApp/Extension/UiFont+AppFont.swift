
import Foundation
import UIKit

extension UIFont{
    
    static func perfect(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
}
