import Foundation

class CSourceImage:Controller<VSourceImage, MSourceImage>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.checkAuth()
    }
    
    override func modelRefresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            guard
                
                let view:VSourceImage = self?.view as? VSourceImage
                
            else
            {
                return
            }
            
            view.refresh()
        }
    }
    
    //MARK: internal
    
    func back()
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.pop(horizontal:ControllerParent.Horizontal.right)
    }
}
