import UIKit

class VSourceImageImport:ViewMain
{
    private(set) weak var viewProgress:VSourceImageImportProgress!
    private let kBottomHeight:CGFloat = 200
    private let kProgressTop:CGFloat = 160
    private let kProgressHeight:CGFloat = 200
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        
        guard
            
            let controller:CSourceImageImport = controller as? CSourceImageImport
            
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
    
    private func factoryViews(controller:CSourceImageImport)
    {
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientLight,
            colourBottom:UIColor.colourGradientDark)
        
        let viewBottom:VSourceImageImportBottom = VSourceImageImportBottom(
            controller:controller)
        
        let viewProgress:VSourceImageImportProgress = VSourceImageImportProgress(
            controller:controller)
        self.viewProgress = viewProgress
        
        addSubview(viewGradient)
        addSubview(viewBottom)
        addSubview(viewProgress)
        
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
        
        NSLayoutConstraint.topToTop(
            view:viewProgress,
            toView:self,
            constant:kProgressTop)
        NSLayoutConstraint.height(
            view:viewProgress,
            constant:kProgressHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewProgress,
            toView:self)
    }
}
