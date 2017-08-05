import UIKit

class CSourceImageImport:Controller<VSourceImageImport, MSourceImageImport>
{
    private let kImportIndex:Int = 2
    private let kImagesIndex:Int = 1
    
    init(items:[MSourceImageItem])
    {
        super.init()
        model.config(item:item, framesPerSecond:framesPerSecond)
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
        
        model.importVideo(controller:self)
    }
    
    override func didReceiveMemoryWarning()
    {
        model.cancelImport()
        
        let message:String = String.localizedController(
            key:"CSourceVideoImport_memoryWarning")
        VAlert.messageFail(message:message)
        
        cancel()
    }
    
    //MARK: private
    
    private func asyncUpdateProgress(percent:CGFloat)
    {
        guard
            
            let view:VSourceVideoImport = self.view as? VSourceVideoImport
            
        else
        {
            return
        }
        
        view.viewProgress.updateProgress(percent:percent)
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
    
    func updateProgress(percent:CGFloat)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncUpdateProgress(percent:percent)
        }
    }
}
