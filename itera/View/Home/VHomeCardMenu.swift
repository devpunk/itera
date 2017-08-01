import UIKit

class VHomeCardMenu:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeCardMenuCell>
{
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
