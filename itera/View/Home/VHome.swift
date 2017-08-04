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
    
    //MARK: public
    
    func viewWillDisappear()
    {
        viewCard?.viewDisplay.forcePause()
    }
    
    func refresh()
    {
        viewProjects.refresh()
    }
}
