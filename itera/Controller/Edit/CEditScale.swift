import Foundation

class CEditScale:Controller<VEditScale, MEditScale>
{
    init(edit:MEdit)
    {
        super.init()
        model.config(edit:edit)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
            
            let view:VEditScale = self.view as? VEditScale
            
        else
        {
            return
        }
        
        view.viewDidAppear()
    }
    
    //MARK: internal
    
    func okay()
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
