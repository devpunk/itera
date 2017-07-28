import UIKit

class CEdit:Controller<VEdit, MEdit>
{
    private let kIndexController:Int = 1
    
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
    
    //MARK: private
    
    private func confirmDelete()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.pop(horizontal:ControllerParent.Horizontal.right)
    }
    
    //MARK: public
    
    func save()
    {
        guard
        
            let sequence:MEditSequence = model.sequence,
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        let controller:CSave = CSave(sequence:sequence)
        let indexController:Int = kIndexController
        
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
        {
            parent.popSilent(removeIndex:indexController)
        }
    }
    
    func delete()
    {
        let alert:UIAlertController = UIAlertController(
            title:String.localizedController(key:"CEdit_alertDeleteTitle"),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CEdit_alertDeleteCancel"),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CEdit_alertDeleteDelete"),
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
    
    func selected(item:MEditActionProtocol)
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        let controller:UIViewController = item.selected(edit:model)
        
        parent.animateOver(controller:controller)
    }
}
