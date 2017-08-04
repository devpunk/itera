import UIKit

extension VHome
{
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
}
