import UIKit

class MFullScreenDelete:MFullScreenProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericDelete")
        }
    }
    
    func selected(controller:CFullScreen)
    {
        controller.delete()
    }
    
    func available(item:MHomeItem) -> Bool
    {
        guard
            
            let _:DProjectUser = item.project as? DProjectUser
            
        else
        {
            return false
        }
        
        return true
    }
}
