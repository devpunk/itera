import UIKit

class VHome:ViewMain
{
    private(set) weak var viewProjects:VHomeProjects!
    private(set) weak var viewCard:VHomeCard?
    private var cardLeftMargin:CGFloat?
    private let kProjectsHeight:CGFloat = 360
    private let kGradientHeight:CGFloat = 250
    private let kMenuHeight:CGFloat = 120
    private let kCardMinTop:CGFloat = 60
    private let kCardMaxTop:CGFloat = 200
    private let kAnimationDuration:TimeInterval = 0.4
    
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
    
    //MARK: private
    
    private func newCard() -> VHomeCard?
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
    
    //MARK: public
    
    func refresh()
    {
        viewProjects.refresh()
    }
    
    func updateCard()
    {
        guard
            
            let viewCard:VHomeCard = newCard()
        
        else
        {
            return
        }
        
        layoutIfNeeded()
        
        self.viewCard?.layoutTop.constant = kCardMaxTop
        viewCard.layoutTop.constant = kCardMinTop
        
        UIView.animate(withDuration:kAnimationDuration,
        animations:
        { [weak self] in
            
            viewCard.alpha = 1
            self?.viewCard?.alpha = 0
            self?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
            
            self?.viewCard?.removeFromSuperview()
            self?.viewCard = viewCard
        }
    }
}
