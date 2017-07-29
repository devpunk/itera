import UIKit

class VEditRotateControls:
    View<VEditRotate, MEditRotate, CEditRotate>
{
    private weak var layoutRotateRightLeft:NSLayoutConstraint!
    private let kButtonsSize:CGFloat = 60
    
    required init(controller:CEditRotate)
    {
        super.init(controller:controller)
        
        let buttonRotateLeft:UIButton = UIButton()
        buttonRotateLeft.translatesAutoresizingMaskIntoConstraints = false
        buttonRotateLeft.setImage(
            #imageLiteral(resourceName: "assetGenericRotateLeft").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRotateLeft.setImage(
            #imageLiteral(resourceName: "assetGenericRotateLeft").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRotateLeft.imageView!.clipsToBounds = true
        buttonRotateLeft.imageView!.contentMode = UIViewContentMode.center
        buttonRotateLeft.imageView!.tintColor = UIColor.colourBackgroundGray
        buttonRotateLeft.addTarget(
            self,
            action:#selector(actionRotateLeft(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonRotateRight:UIButton = UIButton()
        buttonRotateRight.translatesAutoresizingMaskIntoConstraints = false
        buttonRotateRight.setImage(
            #imageLiteral(resourceName: "assetGenericRotateRight").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRotateRight.setImage(
            #imageLiteral(resourceName: "assetGenericRotateRight").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRotateRight.imageView!.clipsToBounds = true
        buttonRotateRight.imageView!.contentMode = UIViewContentMode.center
        buttonRotateRight.imageView!.tintColor = UIColor.colourBackgroundGray
        buttonRotateRight.addTarget(
            self,
            action:#selector(actionRotateRight(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonRotateLeft)
        addSubview(buttonRotateRight)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonRotateRight,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonRotateRight,
            constant:kButtonsSize)
        layoutRotateRightLeft = NSLayoutConstraint.leftToLeft(
            view:buttonRotateRight,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonRotateLeft,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonRotateLeft,
            constant:kButtonsSize)
        NSLayoutConstraint.rightToLeft(
            view:buttonRotateLeft,
            toView:buttonRotateRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let width_2:CGFloat = width / 2.0
        layoutRotateRightLeft.constant = width_2
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionRotateLeft(sender button:UIButton)
    {
        controller.model.rotateLeft()
        updateRotation()
    }
    
    func actionRotateRight(sender button:UIButton)
    {
        controller.model.rotateRight()
        updateRotation()
    }
    
    //MARK: private
    
    private func updateRotation()
    {
        guard
        
            let view:VEditRotate = controller.view as? VEditRotate
        
        else
        {
            return
        }
        
        view.viewImage.rotate()
    }
}
