import UIKit

extension VEditScaleImage
{
    func factoryViews()
    {
        let viewOriginal:VEditScaleImageOriginal = VEditScaleImageOriginal(
            controller:controller)
        self.viewOriginal = viewOriginal
        
        let viewScaled:VEditScaleImageScaled = VEditScaleImageScaled(
            controller:controller)
        self.viewScaled = viewScaled
        
        addSubview(viewOriginal)
        addSubview(viewScaled)
        
        viewOriginal.layoutTop = NSLayoutConstraint.topToTop(
            view:viewOriginal,
            toView:self)
        viewOriginal.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:viewOriginal,
            toView:self)
        viewOriginal.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewOriginal,
            toView:self)
        viewOriginal.layoutRight = NSLayoutConstraint.rightToRight(
            view:viewOriginal,
            toView:self)
        
        viewScaled.layoutTop = NSLayoutConstraint.topToTop(
            view:viewScaled,
            toView:viewOriginal)
        viewScaled.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:viewScaled,
            toView:viewOriginal)
        viewScaled.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewScaled,
            toView:viewOriginal)
        viewScaled.layoutRight = NSLayoutConstraint.rightToRight(
            view:viewScaled,
            toView:viewOriginal)
    }
}
