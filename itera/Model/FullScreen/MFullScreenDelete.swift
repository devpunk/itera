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
}
