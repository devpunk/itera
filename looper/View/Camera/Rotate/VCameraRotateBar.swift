import UIKit

class VCameraRotateBar:UIView
{
    private weak var controller:CCameraRotate!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kButtonTop:CGFloat = 20
    private let kButtonWidth:CGFloat = 120
    
    convenience init(controller:CCameraRotate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor.genericLight,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.genericLight.withAlphaComponent(0.2),
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VCameraRotateBar_buttonClose", comment:""),
            for:UIControlState.normal)
        button.titleLabel!.font = UIFont.bold(size:16)
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(button)
        
        let constraintsBorderHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        
        let layoutButtonTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:button,
            toView:self,
            constant:kButtonTop)
        let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:button,
            toView:self)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
        let layoutButtonWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:button,
            constant:kButtonWidth)
        
        addConstraints(constraintsBorderHorizontal)
        
        addConstraints([
            layoutBorderBottom,
            layoutBorderHeight,
            layoutButtonTop,
            layoutButtonBottom,
            layoutButtonLeft,
            layoutButtonWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutButtonLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.save()
    }
}
