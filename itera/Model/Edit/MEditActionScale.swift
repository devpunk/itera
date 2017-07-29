import UIKit

class MEditActionScale:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericScale")
        }
    }
    
    func selected(edit:MEdit) -> UIViewController
    {
        let controller:CEditScale = CEditScale(edit:edit)
        
        return controller
    }
}
