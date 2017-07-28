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
    
    //MARK: public
    
    func okay()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent,
            let view:VEditScale = self.view as? VEditScale
            
        else
        {
            return
        }
        
//        model.exportCrop(viewImage:view.viewImage)
        parent.dismissAnimateOver(completion:nil)
    }
}
