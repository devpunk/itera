import UIKit

class VSaveProgress:View<VSave, MSave, CSave>
{
    private weak var viewBar:VSaveProgressBar!
    
    required init(controller:CSave)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewBar:VSaveProgressBar = VSaveProgressBar(
            controller:controller)
        self.viewBar = viewBar
        
        let viewThumb:VSaveProgressThumb = VSaveProgressThumb(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewThumb)
        
        NSLayoutConstraint.equals(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewThumb,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func updateProgress(percent:CGFloat)
    {
        viewBar.update(percent:percent)
    }
}
