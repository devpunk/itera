import UIKit

protocol MHomeMenuProtocol
{
    var icon:UIImage { get }
    
    func selected(controller:CHome)
    func available(item:MHomeItem) -> Bool
}
