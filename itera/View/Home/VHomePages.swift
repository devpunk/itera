import UIKit

class VHomePages:View<VHome, MHome, CHome>
{
    private weak var viewControl:UIPageControl!
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        let viewControl:UIPageControl = UIPageControl()
        viewControl.translatesAutoresizingMaskIntoConstraints = false
        viewControl.addTarget(
            self,
            action:#selector(selectorValueChanged(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewControl)
        
        NSLayoutConstraint.equals(
            view:viewControl,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: selectors
    
    func selectorValueChanged(sender viewControl:UIPageControl)
    {
        controller.model.selected = viewControl.currentPage
        
        guard
        
            let view:VHome = controller.view as? VHome
        
        else
        {
            return
        }
        
        view.upateSelection()
    }
    
    //MARK: public
    
    func refresh()
    {
        let model:MHome = controller.model
        viewControl.numberOfPages = model.items.count
        viewControl.currentPage = model.selected
    }
}
