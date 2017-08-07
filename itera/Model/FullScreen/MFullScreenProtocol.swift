import UIKit

protocol MFullScreenProtocol
{
    var icon:UIImage { get }
    
    func selected(controller:CFullScreen)
    func available(item:MHomeItem) -> Bool
}
