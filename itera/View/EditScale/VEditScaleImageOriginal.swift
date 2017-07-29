import UIKit

class VEditScaleImageOriginal:View<VEditScale, MEditScale, CEditScale>
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CEditScale)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        layer.borderColor = UIColor.colourBackgroundDark.cgColor
        layer.borderWidth = kBorderWidth
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
