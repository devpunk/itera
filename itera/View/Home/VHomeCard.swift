import UIKit

class VHomeCard:View<VHome, MHome, CHome>
{
    static let kWidth:CGFloat = 214
    weak var layoutTop:NSLayoutConstraint!
    let kHeight:CGFloat = 320
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        alpha = 0
        
        let background:UIImageView = UIImageView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.contentMode = UIViewContentMode.center
        background.image = #imageLiteral(resourceName: "assetGenericCard")
        
        addSubview(background)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
