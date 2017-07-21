import UIKit

class MSourceItemVideo:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetCreateVideo")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceVideo_title")
        }
    }
    
    var controller:UIViewController.Type
    {
        get
        {
            return CSourceVideo.self
        }
    }
}
