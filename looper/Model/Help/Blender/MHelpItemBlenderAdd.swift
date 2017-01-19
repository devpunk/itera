import UIKit

class MHelpItemBlenderAdd:MHelpItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHelpCameraCapture")
        let title:String = NSLocalizedString("MHelpItemBlenderAdd_title", comment:"")
        
        super.init(
            image:image,
            title:title)
    }
}
