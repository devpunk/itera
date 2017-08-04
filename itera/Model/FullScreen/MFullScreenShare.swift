import UIKit

class MFullScreenShare:MFullScreenProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericShare")
        }
    }
    
    func selected(controller:CFullScreen)
    {
    }
}
