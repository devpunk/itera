import UIKit

class VSourceImageBar:
    View<VSourceImage, MSourceImage, CSourceImage>
{
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 60
    private let kBackEdgeRight:CGFloat = 20
    private let kBorderHeight:CGFloat = 1
    private let kNextRight:CGFloat = -16
    private let kNextWidth:CGFloat = 120
    
    required init(controller:CSourceImage)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.white
        
        let border:VBorder = VBorder(
            colour:UIColor.colourBackgroundGray)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:16)
        labelTitle.textColor = UIColor.black
        labelTitle.text = String.localizedView(
            key:"VSourceImageBar_labelTitle")
        
        let labelNext:UILabel = UILabel()
        labelNext.isUserInteractionEnabled = false
        labelNext.translatesAutoresizingMaskIntoConstraints = false
        labelNext.backgroundColor = UIColor.clear
        labelNext.textAlignment = NSTextAlignment.right
        labelNext.font = UIFont.bold(size:14)
        labelNext.textColor = UIColor.black
        labelNext.text = String.localizedView(
            key:"VSourceImageBar_labelNext")
        
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
            action:#selector(selectorBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonNext:UIButton = UIButton()
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.addTarget(
            self,
            action:#selector(selectorNext(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(labelTitle)
        addSubview(labelNext)
        addSubview(buttonBack)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonBack,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonBack,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonBack,
            constant:kBackWidth)
        
        NSLayoutConstraint.topToTop(
            view:labelNext,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:labelNext,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:labelNext,
            toView:self,
            constant:kNextRight)
        NSLayoutConstraint.width(
            view:labelNext,
            constant:kNextWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonNext,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonNext,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonNext,
            constant:kNextWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: selectors
    
    func selectorBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func selectorNext(sender button:UIButton)
    {
        controller.next()
    }
}
