import UIKit

class VEditScaleImageScaled:View<VEditScale, MEditScale, CEditScale>
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 2
    
    required init(controller:CEditScale)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.colourBackgroundGray
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.colourBackgroundDark.cgColor
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
