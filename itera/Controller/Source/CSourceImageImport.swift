import UIKit

class CSourceImageImport:Controller<VSourceImageImport, MSourceImageImport>
{
    private let kImportIndex:Int = 2
    private let kImagesIndex:Int = 1
    
    init(items:[MSourceImageItem])
    {
        super.init()
        model.config(items:items)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.importImages(controller:self)
    }
    
    override func didReceiveMemoryWarning()
    {
        let message:String = String.localizedController(
            key:"CSourceImageImport_memoryWarning")
        VAlert.messageFail(message:message)
        
        cancel()
    }
    
    //MARK: private
    
    private func asyncUpdateProgress(percent:CGFloat, image:UIImage?)
    {
        guard
            
            let view:VSourceImageImport = self.view as? VSourceImageImport
            
        else
        {
            return
        }
        
        view.viewProgress.updateProgress(
            percent:percent,
            image:image)
    }
    
    private func popAll()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.popSilent(removeIndex:kImportIndex)
        parent.popSilent(removeIndex:kImagesIndex)
    }
    
    private func popAllPushEdit(sequence:MEditSequence)
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CEdit = CEdit(sequence:sequence)
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
        { [weak self] in
            
            self?.popAll()
        }
    }
    
    //MARK: internal
    
    func cancel()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
    
    func imagesImported(sequence:MEditSequence)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.popAllPushEdit(sequence:sequence)
        }
    }
    
    func updateProgress(percent:CGFloat, image:UIImage?)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncUpdateProgress(percent:percent, image:image)
        }
    }
}
