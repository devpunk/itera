import Foundation

class CFullScreen:Controller<VFullScreen, MFullScreen>
{
    init(item:MHomeItem)
    {
        super.init()
        model.config(item:item)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var prefersStatusBarHidden:Bool
    {
        get
        {
            return true
        }
    }
    
    //MARK: public
    
    func back()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
}
