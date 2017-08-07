import UIKit

class MHomeMenuShare:MHomeMenuProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericShare")
        }
    }
    
    func selected(controller:CHome)
    {
        guard
            
            let item:MHomeItem = controller.model.currentItem()
            
        else
        {
            return
        }
        
        controller.share(item:item)
    }
    
    func available(item:MHomeItem) -> Bool
    {
        return true
    }
}
