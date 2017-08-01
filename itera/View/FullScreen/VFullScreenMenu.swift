import UIKit

class VFullScreenMenu:VCollection<
    VFullScreen,
    MFullScreen,
    CFullScreen,
    VFullScreenMenuCell>
{
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        
        let border:VBorder = VBorder(colour:UIColor.colourBackgroundDark)
        
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
