import UIKit

class VHomePages:View<VHome, MHome, CHome>
{
    private weak var viewControl:UIPageControl!
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewControl:UIPageControl = UIPageControl()
        viewControl.isUserInteractionEnabled = false
        viewControl.translatesAutoresizingMaskIntoConstraints = false
        self.viewControl = viewControl
        
        addSubview(viewControl)
        
        NSLayoutConstraint.equals(
            view:viewControl,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func refresh()
    {
        let model:MHome = controller.model
        viewControl.numberOfPages = model.items.count
        viewControl.currentPage = model.selected
    }
}
