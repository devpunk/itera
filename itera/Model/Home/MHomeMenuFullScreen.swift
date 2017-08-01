import UIKit

class MHomeMenuFullScreen:MHomeMenuProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericFullScreen")
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
        
        controller.openFullScreen(item:item)
    }
}
