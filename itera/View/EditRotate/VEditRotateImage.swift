import UIKit

class VEditRotateImage:View<VEditRotate, MEditRotate, CEditRotate>
{
    private weak var imageView:UIImageView!
    
    required init(controller:CEditRotate)
    {
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
