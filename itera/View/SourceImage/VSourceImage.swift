import UIKit

class VSourceImage:ViewMain
{
    static let kBarHeight:CGFloat = 64
    
    private weak var spinner:VSpinner!
    private let kPanBack:Bool = true
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
            
            let controller:CSourceImage = controller as? CSourceImage
            
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
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    override var panBack:Bool
    {
        get
        {
            return kPanBack
        }
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceImage)
    {
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VSourceImageBar = VSourceImageBar(controller:controller)
        
        let viewList:VSourceVideoList = VSourceVideoList(controller:controller)
        self.viewList = viewList
        
        addSubview(spinner)
        addSubview(viewList)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewList,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:VSourceVideo.kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
}
