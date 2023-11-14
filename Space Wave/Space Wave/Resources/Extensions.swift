import Foundation
import UIKit

extension UIView {
    var width: CGFloat { 
        frame.size.width }
    
    var height: CGFloat { 
        frame.size.height }
    
    var left: CGFloat {
        frame.origin.x }
    
    var top: CGFloat {
        frame.origin.y }
    
    var bottom: CGFloat {
        top + height }
    
    var right: CGFloat {
        left + width }
}
