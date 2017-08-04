import UIKit

class CFullScreen:Controller<VFullScreen, MFullScreen>
{
    init(item:MHomeItem)
    {
        super.init()
        model.config(item:item)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var prefersStatusBarHidden:Bool
    {
        get
        {
            return true
        }
    }
    
    //MARK: private
    
    private func confirmDelete()
    {
        model.item.delete
        { [weak self] in
            
            self?.deleteDone()
        }
    }
    
    private func deleteDone()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.back()
        }
    }
    
    //MARK: public
    
    func back()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
    
    func share()
    {
        let url:URL = model.item.path
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
    
    func delete()
    {
        let alert:UIAlertController = UIAlertController(
            title:String.localizedController(key:"CFullScreen_alertDeleteTitle"),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CFullScreen_alertDeleteCancel"),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CFullScreen_alertDeleteDelete"),
            style:UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmDelete()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = view
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
}
