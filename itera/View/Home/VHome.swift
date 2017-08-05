import UIKit

class VHome:ViewMain
{
    weak var viewProjects:VHomeProjects!
    weak var viewCard:VHomeCard?
    weak var viewPages:VHomePages!
    var cardLeftMargin:CGFloat?
    let kProjectsHeight:CGFloat = 360
    let kGradientHeight:CGFloat = 250
    let kMenuHeight:CGFloat = 120
    let kPagesHeight:CGFloat = 90
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
    
    //MARK: internal
    
    func viewWillDisappear()
    {
        viewCard?.viewDisplay.forcePause()
    }
    
    func refresh()
    {
        viewProjects.refresh()
        viewPages.refresh()
        updateCard()
    }
    
    func upateSelection()
    {
        viewProjects.centerCurrent()
        viewPages.refresh()
        updateCard()
    }
}
