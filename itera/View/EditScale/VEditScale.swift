import UIKit

class VEditScale:ViewMain
{
    private(set) weak var viewImage:VEditScaleImage!
    private(set) weak var viewSlider:VEditScaleSlider!
    private weak var layoutHalfLeft:NSLayoutConstraint!
    private weak var layoutImageHeight:NSLayoutConstraint!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kSliderHeight:CGFloat = 130
    private let kButtonTop:CGFloat = 10
    private let kButtonHeight:CGFloat = 32
    private let kButtonWidth:CGFloat = 100
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
            
            let controller:CEditScale = controller as? CEditScale
            
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainOkay:CGFloat = width - kOkayWidth
        let okayMarginLeft:CGFloat = remainOkay / 2.0
        let remainHalf:CGFloat = width - kButtonWidth
        let halfMarginLeft:CGFloat = remainHalf / 2.0
        layoutOkayLeft.constant = okayMarginLeft
        layoutImageHeight.constant = width
        layoutHalfLeft.constant = halfMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: selectors
    
    func actionHalf(sender button:UIButton)
    {
        viewSlider.half()
    }
    
    func actionQuarter(sender button:UIButton)
    {
        viewSlider.quarter()
    }
    
    func actionThreeQuarters(sender button:UIButton)
    {
        viewSlider.threeQuarters()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditScale)
    {
        let viewImage:VEditScaleImage = VEditScaleImage(
            controller:controller)
        self.viewImage = viewImage
        
        let viewSlider:VEditScaleSlider = VEditScaleSlider(
            controller:controller)
        self.viewSlider = viewSlider
        
        let viewOkay:VEditScaleOkay = VEditScaleOkay(
            controller:controller)
        
        let buttonHalf:VEditScaleButton = VEditScaleButton(
            title:
            String.localizedView(key:"VEditScale_buttonHalf"))
        buttonHalf.addTarget(
            self,
            action:#selector(actionHalf(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonQuarter:VEditScaleButton = VEditScaleButton(
            title:
            String.localizedView(key:"VEditScale_buttonQuarter"))
        buttonQuarter.addTarget(
            self,
            action:#selector(actionQuarter(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonThreeQuarters:VEditScaleButton = VEditScaleButton(
            title:
            String.localizedView(key:"VEditScale_buttonThreeQuarters"))
        buttonThreeQuarters.addTarget(
            self,
            action:#selector(actionThreeQuarters(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewImage)
        addSubview(buttonHalf)
        addSubview(buttonQuarter)
        addSubview(buttonThreeQuarters)
        addSubview(viewSlider)
        addSubview(viewOkay)
        
        NSLayoutConstraint.topToTop(
            view:viewImage,
            toView:self)
        layoutImageHeight = NSLayoutConstraint.height(
            view:viewImage)
        NSLayoutConstraint.equalsHorizontal(
            view:viewImage,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewSlider,
            toView:viewImage)
        NSLayoutConstraint.height(
            view:viewSlider,
            constant:kSliderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewSlider,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:buttonHalf,
            toView:viewSlider)
        NSLayoutConstraint.height(
            view:buttonHalf,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonHalf,
            constant:kButtonWidth)
        layoutHalfLeft = NSLayoutConstraint.leftToLeft(
            view:buttonHalf,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:buttonQuarter,
            toView:viewSlider)
        NSLayoutConstraint.height(
            view:buttonQuarter,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonQuarter,
            constant:kButtonWidth)
        NSLayoutConstraint.rightToLeft(
            view:buttonQuarter,
            toView:buttonHalf)
        
        NSLayoutConstraint.topToBottom(
            view:buttonThreeQuarters,
            toView:viewSlider)
        NSLayoutConstraint.height(
            view:buttonThreeQuarters,
            constant:kButtonHeight)
        NSLayoutConstraint.width(
            view:buttonThreeQuarters,
            constant:kButtonWidth)
        NSLayoutConstraint.leftToRight(
            view:buttonThreeQuarters,
            toView:buttonHalf)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewOkay,
            toView:self,
            constant:kOkayBottom)
        NSLayoutConstraint.height(
            view:viewOkay,
            constant:kOkayHeight)
        NSLayoutConstraint.width(
            view:viewOkay,
            constant:kOkayWidth)
        layoutOkayLeft = NSLayoutConstraint.leftToLeft(
            view:viewOkay,
            toView:self)
    }
    
    //MARK: public
    
    func viewDidAppear()
    {
        viewImage.layout()
    }
}
