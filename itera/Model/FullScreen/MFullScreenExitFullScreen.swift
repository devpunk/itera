import UIKit

class MFullScreenExitFullScreen:MFullScreenProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericExitFullScreen")
        }
    }
    
    func selected(controller:CFullScreen)
    {
        controller.back()
    }
}
