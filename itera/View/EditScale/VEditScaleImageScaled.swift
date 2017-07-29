import UIKit

class VEditScaleImageScaled:View<VEditScale, MEditScale, CEditScale>
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    
    required init(controller:CEditScale)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.colourBackgroundDark.withAlphaComponent(0.65)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
