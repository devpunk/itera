import UIKit

class CNew:Controller<VNew, MNew>
{
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
            
            let view:VNew = self.view as? VNew
            
        else
        {
            return
        }
        
        view.viewWillAppear()
    }
    
    //MARK: public
    
    func cancel()
    {
        guard
            
            let view:VNew = self.view as? VNew,
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        view.viewWillDisappear()
        parent.dismissAnimateOver(completion:nil)
    }
    
    func open(item:MSourceProtocol)
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controllerType:UIViewController.Type = item.controller
        let controller:UIViewController = controllerType.init()
        
        parent.dismissAnimateOver
        {
            parent.push(
                controller:controller,
                horizontal:ControllerParent.Horizontal.right)
        }
    }
}
