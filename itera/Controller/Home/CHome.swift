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
    
    override func viewWillDisappear(_ animated:Bool)
    {
        super.viewWillDisappear(animated)
        
        guard
        
            let view:VHome = self.view as? VHome
        
        else
        {
            return
        }
        
        view.viewWillDisappear()
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
    
    private func confirmDelete(item:MHomeItem)
    {
        prepareForDelete()
        
        item.delete
        { [weak self] in
            
            self?.model.load()
        }
    }
    
    private func prepareForDelete()
    {
        guard
            
            let view:VHome = self.view as? VHome
            
        else
        {
            return
        }
        
        view.viewCard?.viewDisplay.prepareForDelete()
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
    
    func openFullScreen(item:MHomeItem)
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CFullScreen = CFullScreen(item:item)
        parent.animateOver(controller:controller)
    }
    
    func share(item:MHomeItem)
    {
        let url:URL = item.path
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
    
    func delete(item:MHomeItem)
    {
        let alert:UIAlertController = UIAlertController(
            title:String.localizedController(key:"CHome_alertDeleteTitle"),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CHome_alertDeleteCancel"),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CHome_alertDeleteDelete"),
            style:UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmDelete(item:item)
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
