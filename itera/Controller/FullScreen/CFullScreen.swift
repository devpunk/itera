import Foundation

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
}
