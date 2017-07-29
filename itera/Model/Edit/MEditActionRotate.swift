import UIKit

class MEditActionRotate:MEditActionProtocol
{
    var image:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetGenericRotate")
        }
    }
    
    func selected(edit:MEdit) -> UIViewController
    {
        let controller:CEditRotate = CEditRotate(edit:edit)
        
        return controller
    }
}
