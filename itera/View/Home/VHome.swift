import UIKit

class VHome:ViewMain
{
    private(set) weak var viewProjects:VHomeProjects!
    private let kProjectsHeight:CGFloat = 360
    private let kGradientHeight:CGFloat = 250
    private let kMenuHeight:CGFloat = 120
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
            
            let controller:CHome = controller as? CHome
        
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
    
    private func factoryViews(controller:CHome)
    {
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientDark,
            colourBottom:UIColor.colourGradientLight)
        
        let viewProjects:VHomeProjects = VHomeProjects(
            controller:controller)
        self.viewProjects = viewProjects
        
        let viewMenu:VHomeMenu = VHomeMenu(controller:controller)
        
        addSubview(viewGradient)
        addSubview(viewProjects)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToTop(
            view:viewGradient,
            toView:self)
        NSLayoutConstraint.height(
            view:viewGradient,
            constant:kGradientHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewGradient,
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
        
        NSLayoutConstraint.topToTop(
            view:viewProjects,
            toView:self)
        NSLayoutConstraint.height(
            view:viewProjects,
            constant:kProjectsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewProjects,
            toView:self)
    }
    
    //MARK: public
    
    func refresh()
    {
        viewProjects.collectionView.reloadData()
    }
}
