import UIKit

class VHomeCard:View<VHome, MHome, CHome>
{
    static let kWidth:CGFloat = 214
    weak var layoutTop:NSLayoutConstraint!
    private weak var viewDisplay:VHomeCardDisplay!
    let kHeight:CGFloat = 320
    private let kDisplayHeight:CGFloat = 260
    private let kDisplayTop:CGFloat = 12
    private let kDisplayMarginHorizontal:CGFloat = 9
    
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
        
        let viewDisplay:VHomeCardDisplay = VHomeCardDisplay(
            controller:controller)
        self.viewDisplay = viewDisplay
        
        addSubview(background)
        addSubview(viewDisplay)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewDisplay,
            toView:self,
            constant:kDisplayTop)
        NSLayoutConstraint.height(
            view:viewDisplay,
            constant:kDisplayHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDisplay,
            toView:self,
            margin:kDisplayMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
