import UIKit

class VEditScaleImage:View<VEditScale, MEditScale, CEditScale>
{
    weak var viewOriginal:VEditScaleImageOriginal!
    weak var viewScaled:VEditScaleImageScaled!
    let margin2:CGFloat
    let kMargin:CGFloat = 30
    
    required init(controller:CEditScale)
    {
        margin2 = kMargin + kMargin
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
