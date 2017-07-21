import UIKit

class VSourceVideoBar:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    private let kContentTop:CGFloat = 20
    private let kContentHeight:CGFloat = 44
    private let kBackWidth:CGFloat = 60
    private let kBackEdgeRight:CGFloat = 20
    
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
        
        let colourTop:UIColor = UIColor(
            red:0.9137254901960784,
            green:0.38823529411764707,
            blue:0.09019607843137255,
            alpha:1)
        let colourBottom:UIColor = UIColor(
            red:1,
            green:0.5921568627450979,
            blue:0.36078431372549025,
            alpha:1)
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:colourTop,
            colourBottom:colourBottom)
        
        let buttonBack:UIButton = UIButton()
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        buttonBack.setImage(
            #imageLiteral(resourceName: "assetGenericBack"),
            for:UIControlState.normal)
        buttonBack.imageView!.clipsToBounds = true
        buttonBack.imageView!.contentMode = UIViewContentMode.center
        buttonBack.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:kBackEdgeRight)
        buttonBack.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewGradient)
        addSubview(buttonBack)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:buttonBack,
            constant:kContentHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
}
