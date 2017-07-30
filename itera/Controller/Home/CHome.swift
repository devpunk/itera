import Foundation

class CHome:Controller<VHome, MHome>
{
    override func modelRefresh()
    {
        
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        model.load()
    }
    
    //MARK: public
    
    func openNew()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CNew = CNew()
        parent.centreOver(controller:controller)
    }
}
