import UIKit

class VEditScaleImage:View<VEditScale, MEditScale, CEditScale>
{
    weak var viewOriginal:VEditScaleImageOriginal!
    weak var viewScaled:VEditScaleImageScaled!
    let margin2:CGFloat
    let scaledMargin2:CGFloat
    let kMargin:CGFloat = 50
    let kScaledMargin:CGFloat = 1
    
    required init(controller:CEditScale)
    {
        margin2 = kMargin + kMargin
        scaledMargin2 = kScaledMargin + kScaledMargin
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
