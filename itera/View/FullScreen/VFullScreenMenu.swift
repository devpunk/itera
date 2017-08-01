import UIKit

class VFullScreenMenu:VCollection<
    VFullScreen,
    MFullScreen,
    CFullScreen,
    VFullScreenMenuCell>
{
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        
        let border:VBorder = VBorder(colour:UIColor.colourBackgroundDark)
        
        addSubview(border)
        
        NSLayoutConstraint.topToTop(
            view:border,toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
