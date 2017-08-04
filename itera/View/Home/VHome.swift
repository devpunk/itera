import UIKit

class VHome:ViewMain
{
    var cardLeftMargin:CGFloat?
    weak var viewProjects:VHomeProjects!
    weak var viewCard:VHomeCard?
    let kProjectsHeight:CGFloat = 360
    let kGradientHeight:CGFloat = 250
    let kMenuHeight:CGFloat = 120
    let kCardMinTop:CGFloat = 40
    let kCardMidMinTop:CGFloat = 80
    let kCardMaxTop:CGFloat = 180
    let kCardMidMaxTop:CGFloat = 100
    let kAnimationDuration:TimeInterval = 0.3
    let kAnimationFastDuration:TimeInterval = 0.1
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func displayNewCard()
    {
        guard
            
            let viewCard:VHomeCard = factoryCard()
            
        else
        {
            return
        }
        
        layoutIfNeeded()
        animateCardChangeFirst(viewCard:viewCard)
    }
    
    private func animateCardChangeFirst(viewCard:VHomeCard)
    {
        self.viewCard?.layoutTop.constant = kCardMidMaxTop
        viewCard.layoutTop.constant = kCardMinTop
        
        UIView.animate(
            withDuration:kAnimationDuration,
       animations:
        { [weak self] in
            
            viewCard.alpha = 1
            self?.viewCard?.alpha = 0
            self?.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.animateCardChangeSecond(viewCard:viewCard)
        }
    }
    
    private func animateCardChangeSecond(viewCard:VHomeCard)
    {
        self.viewCard?.removeFromSuperview()
        self.viewCard = viewCard
        viewCard.layoutTop.constant = kCardMidMinTop
        
        UIView.animate(
            withDuration:kAnimationFastDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    private func animateCardDisappear()
    {
        self.viewCard?.layoutTop.constant = kCardMidMaxTop
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.viewCard?.alpha = 0
            self?.layoutIfNeeded()
        })
        { [weak self] (done:Bool) in
            
            self?.viewCard?.removeFromSuperview()
        }
    }
    
    //MARK: public
    
    func viewWillDisappear()
    {
        viewCard?.viewDisplay.forcePause()
    }
    
    func refresh()
    {
        viewProjects.refresh()
    }
    
    func updateCard()
    {
        guard
        
            let controller:CHome = self.controller as? CHome
        
        else
        {
            return
        }
        
        if let _:MHomeItem = controller.model.currentItem()
        {
            displayNewCard()
        }
        else
        {
            animateCardDisappear()
        }
    }
}
