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
    private let kHalfHeight:CGFloat = 36
    private let kHalfWidth:CGFloat = 120
    
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
        let remainHalf:CGFloat = width - kHalfWidth
        let halfMarginLeft:CGFloat = remainHalf / 2.0
        layoutOkayLeft.constant = okayMarginLeft
        layoutImageHeight.constant = width
        layoutHalfLeft.constant = halfMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionHalf(sender button:UIButton)
    {
        viewSlider.half()
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
        
        let buttonHalf:UIButton = UIButton()
        buttonHalf.translatesAutoresizingMaskIntoConstraints = false
        buttonHalf.setTitleColor(
            UIColor.colourBackgroundDark.withAlphaComponent(0.5),
            for:UIControlState.normal)
        buttonHalf.setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        buttonHalf.setTitle(
            String.localizedView(key:"VEditScale_buttonHalf"),
            for:UIControlState.normal)
        buttonHalf.titleLabel!.font = UIFont.medium(size:15)
        buttonHalf.addTarget(
            self,
            action:#selector(actionHalf(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewImage)
        addSubview(buttonHalf)
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
            constant:kHalfHeight)
        NSLayoutConstraint.width(
            view:buttonHalf,
            constant:kHalfWidth)
        layoutHalfLeft = NSLayoutConstraint.leftToLeft(
            view:buttonHalf,
            toView:self)
        
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
