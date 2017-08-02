import UIKit

class VFullScreen:ViewMain
{
    private(set) weak var viewDisplay:VFullScreenDisplay!
    private let kMenuHeight:CGFloat = 60
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CFullScreen = controller as? CFullScreen
        
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
    
    private func factoryViews(controller:CFullScreen)
    {
        let viewDisplay:VFullScreenDisplay = VFullScreenDisplay(
            controller:controller)
        self.viewDisplay = viewDisplay
        
        let viewMenu:VFullScreenMenu = VFullScreenMenu(
            controller:controller)
        
        addSubview(viewDisplay)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToTop(
            view:viewDisplay,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:viewDisplay,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDisplay,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
    }
}
