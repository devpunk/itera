import UIKit

extension VHome
{
    func factoryViews()
    {
        guard
            
            let controller:CHome = controller as? CHome
            
        else
        {
            return
        }
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientDark,
            colourBottom:UIColor.colourGradientLight)
        
        let viewProjects:VHomeProjects = VHomeProjects(
            controller:controller)
        self.viewProjects = viewProjects
        
        let viewMenu:VHomeMenu = VHomeMenu(controller:controller)
        
        let viewSwipper:VHomeSwipper = VHomeSwipper(
            controller:controller)
        
        addSubview(viewGradient)
        addSubview(viewProjects)
        addSubview(viewSwipper)
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
        
        NSLayoutConstraint.equals(
            view:viewSwipper,
            toView:self)
    }
    
    func factoryCard() -> VHomeCard?
    {
        guard
            
            let controller:CHome = self.controller as? CHome
            
        else
        {
            return nil
        }
        
        let cardLeft:CGFloat
        
        if let cardLeftMargin:CGFloat = self.cardLeftMargin
        {
            cardLeft = cardLeftMargin
        }
        else
        {
            let width:CGFloat = bounds.width
            let remainCard:CGFloat = width - VHomeCard.kWidth
            cardLeft = remainCard / 2.0
            self.cardLeftMargin = cardLeft
        }
        
        let viewCard:VHomeCard = VHomeCard(
            controller:controller)
        
        addSubview(viewCard)
        
        viewCard.layoutTop = NSLayoutConstraint.topToTop(
            view:viewCard,
            toView:self,
            constant:kCardMaxTop)
        NSLayoutConstraint.height(
            view:viewCard,
            constant:viewCard.kHeight)
        NSLayoutConstraint.width(
            view:viewCard,
            constant:VHomeCard.kWidth)
        NSLayoutConstraint.leftToLeft(
            view:viewCard,
            toView:self,
            constant:cardLeft)
        
        return viewCard
    }
}
