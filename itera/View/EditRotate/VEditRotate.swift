import UIKit

class VEditRotate:ViewMain
{
    private(set) weak var viewImage:VEditRotateImage!
    private weak var layoutImageHeight:NSLayoutConstraint!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kControlsHeight:CGFloat = 115
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
            
            let controller:CEditRotate = controller as? CEditRotate
            
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
        layoutOkayLeft.constant = okayMarginLeft
        layoutImageHeight.constant = width
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditRotate)
    {
        let viewImage:VEditRotateImage = VEditRotateImage(
            controller:controller)
        self.viewImage = viewImage
        
        let viewOkay:VEditRotateOkay = VEditRotateOkay(
            controller:controller)
        
        let viewControls:VEditRotateControls = VEditRotateControls(
            controller:controller)
        
        addSubview(viewImage)
        addSubview(viewControls)
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
            view:viewControls,
            toView:viewImage)
        NSLayoutConstraint.height(
            view:viewControls,
            constant:kControlsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewControls,
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
    
    //MARK: internal
    
    func viewDidAppear()
    {
        viewImage.layout()
        viewImage.rotate()
    }
}
