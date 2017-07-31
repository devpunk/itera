import UIKit

class CHome:Controller<VHome, MHome>
{
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        get
        {
            return UIStatusBarStyle.lightContent
        }
    }
    
    override func modelRefresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.refreshView()
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        model.load()
    }
    
    //MARK: private
    
    private func refreshView()
    {
        guard
        
            let view:VHome = self.view as? VHome
        
        else
        {
            return
        }
        
        view.refresh()
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
