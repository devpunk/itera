import UIKit

class VHomeCard:View<VHome, MHome, CHome>
{
    static let kWidth:CGFloat = 214
    let kHeight:CGFloat = 320
    weak var layoutTop:NSLayoutConstraint!
    private(set) weak var viewDisplay:VHomeCardDisplay!
    private let kDisplayHeight:CGFloat = 256
    private let kContentMarginVertical:CGFloat = 12.5
    private let kContentMarginHorizontal:CGFloat = 9.2
    private let kBottomHeight:CGFloat = 60
    private let kMenuHeight:CGFloat = 50
    
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
        
        let viewBottom:VHomeCardBottom = VHomeCardBottom(
            controller:controller)
        
        let viewMenu:VHomeCardMenu = VHomeCardMenu(
            controller:controller)
        
        viewBottom.addSubview(viewMenu)
        addSubview(background)
        addSubview(viewDisplay)
        addSubview(viewBottom)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewDisplay,
            toView:self,
            constant:kContentMarginVertical)
        NSLayoutConstraint.height(
            view:viewDisplay,
            constant:kDisplayHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDisplay,
            toView:self,
            margin:kContentMarginHorizontal)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottom,
            toView:self,
            constant:-kContentMarginVertical)
        NSLayoutConstraint.height(
            view:viewBottom,
            constant:kBottomHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottom,
            toView:self,
            margin:kContentMarginHorizontal)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:viewBottom)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:viewBottom)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
