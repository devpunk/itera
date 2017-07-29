import UIKit

class VEditRotateControls:
    View<VEditRotate, MEditRotate, CEditRotate>
{
    required init(controller:CEditRotate)
    {
        super.init(controller:controller)
        
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
