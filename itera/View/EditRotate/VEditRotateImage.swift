import UIKit

class VEditRotateImage:View<VEditRotate, MEditRotate, CEditRotate>
{
    weak var viewPicture:VEditRotateImagePicture!
    let margin2:CGFloat
    let kMargin:CGFloat = 50
    let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:CEditRotate)
    {
        margin2 = kMargin + kMargin
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewPicture:VEditRotateImagePicture = VEditRotateImagePicture(
            controller:controller)
        self.viewPicture = viewPicture
        
        addSubview(viewPicture)
        
        viewPicture.layoutTop = NSLayoutConstraint.topToTop(
            view:viewPicture,
            toView:self)
        viewPicture.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:viewPicture,
            toView:self)
        viewPicture.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewPicture,
            toView:self)
        viewPicture.layoutRight = NSLayoutConstraint.rightToRight(
            view:viewPicture,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
