import UIKit

class VHome:ViewMain
{
    private(set) weak var viewProjects:VHomeProjects!
    private(set) weak var viewCard:VHomeCard!
    private weak var layoutCardTop:NSLayoutConstraint!
    private weak var layoutCardLeft:NSLayoutConstraint!
    private let kProjectsHeight:CGFloat = 360
    private let kGradientHeight:CGFloat = 250
    private let kMenuHeight:CGFloat = 120
    private let kCardMinTop:CGFloat = 50
    private let kCardMaxTop:CGFloat = 150
    
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCard:CGFloat = width - VHomeCard.kWidth
        let cardLeft:CGFloat = remainCard / 2.0
        layoutCardLeft.constant = cardLeft
        
        super.layoutSubviews()
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
        
        let viewCard:VHomeCard = VHomeCard(controller:controller)
        
        addSubview(viewGradient)
        addSubview(viewProjects)
        addSubview(viewMenu)
        addSubview(viewCard)
        
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
        
        layoutCardTop = NSLayoutConstraint.topToTop(
            view:viewCard,
            toView:self,
            constant:kCardMaxTop)
        NSLayoutConstraint.height(
            view:viewCard,
            constant:viewCard.kHeight)
        NSLayoutConstraint.width(
            view:viewCard,
            constant:VHomeCard.kWidth)
        layoutCardLeft = NSLayoutConstraint.leftToLeft(
            view:viewCard,
            toView:self)
    }
    
    //MARK: public
    
    func refresh()
    {
        viewProjects.refresh()
    }
}
