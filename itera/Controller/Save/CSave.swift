import UIKit

class CSave:Controller<VSave, MSave>
{
    init(sequence:MEditSequence)
    {
        super.init()
        model.config(sequence:sequence)
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
        
        model.save(controller:self)
    }
    
    //MARK: private
    
    private func asyncClose()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.pop(vertical:ControllerParent.Vertical.bottom)
    }
    
    private func asyncExport(url:URL)
    {
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[url],
            applicationActivities:nil)
        
        if let popover:UIPopoverPresentationController = activity.popoverPresentationController
        {
            popover.sourceView = view
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.any
        }
        
        present(activity, animated:true, completion:nil)
    }
    
    private func asyncUpdateProgress(percent:CGFloat)
    {
        guard
            
            let view:VSave = self.view as? VSave
            
        else
        {
            return
        }
        
        view.viewProgress.updateProgress(percent:percent)
    }
    
    //MARK: public
    
    func close()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncClose()
        }
    }
    
    func export(url:URL)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncExport(url:url)
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
