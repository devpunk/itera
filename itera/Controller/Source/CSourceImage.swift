import Foundation

class CSourceImage:Controller<VSourceImage, MSourceImage>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // model.checkAuth()
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
    
    //MARK: private
    
    private func dispatchNext()
    {
        let selectedItems:[MSourceImageItem] = model.factorySelectedIndexesOrdered()
        
        if selectedItems.count > 0
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.openNext(items:selectedItems)
            }
        }
        else
        {
            let message:String = String.localizedController(
                key:"CSourceImage_alertNoImagesSelected")
            VAlert.messageFail(message:message)
        }
    }
    
    private func openNext(items:[MSourceImageItem])
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CSourceImageImport = CSourceImageImport(
            items:items)
        parent.animateOver(controller:controller)
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
    
    func next()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.dispatchNext()
        }
    }
}
