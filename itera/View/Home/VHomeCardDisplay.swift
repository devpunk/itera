import UIKit

class VHomeCardDisplay:View<VHome, MHome, CHome>
{
    private let kCornerRadius:CGFloat = 5
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
