import UIKit

class VSave:ViewMain
{
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
            red:0.011764705882352896,
            green:0.7137254901960783,
            blue:0.7450980392156863,
            alpha:1)
        
        let colourBottom:UIColor = UIColor(
            red:0.12941176470588237,
            green:0.49019607843137286,
            blue:0.7137254901960784,
            alpha:1)
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:colourTop,
            colourBottom:colourBottom)
        
        addSubview(viewGradient)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
    }
}
