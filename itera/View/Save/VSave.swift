import UIKit

class VSave:ViewMain
{
    private let kBottomHeight:CGFloat = 150
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        
        guard
        
            let controller:CSave = controller as? CSave
        
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
    
    //MARK: private
    
    private func factoryViews(controller:CSave)
    {
        let colourTop:UIColor = UIColor(
            red:1,
            green:0.5215686274509804,
            blue:0.43529411764705883,
            alpha:1)
        
        let colourBottom:UIColor = UIColor(
            red:0.8627450980392157,
            green:0.3529411764705883,
            blue:0.2588235294117647,
            alpha:1)
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:colourTop,
            colourBottom:colourBottom)
        
        let viewBottom:VSaveBottom = VSaveBottom(
            controller:controller)
        
        addSubview(viewGradient)
        addSubview(viewBottom)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottom,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBottom,
            constant:kBottomHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottom,
            toView:self)
    }
}
