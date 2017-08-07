import UIKit

class MHomeMenuDelete:MHomeMenuProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericDelete")
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
        
        controller.delete(item:item)
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
