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
    
    private func asyncDone()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.pop(vertical:ControllerParent.Vertical.bottom)
    }
    
    //MARK: public
    
    func done()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncDone()
        }
    }
}
