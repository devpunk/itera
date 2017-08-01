import UIKit

class VHomeCardBottom:View<VHome, MHome, CHome>
{
    private let kCornerRadius:CGFloat = 4
    private let kBaseTop:CGFloat = 10
    private let kBaseBottom:CGFloat = 10
    private let kBaseMarginHorizontal:CGFloat = -2
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        layer.cornerRadius = kCornerRadius
        
        let viewBase:UIView = UIView()
        viewBase.isUserInteractionEnabled = false
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.clipsToBounds = true
        viewBase.backgroundColor = UIColor.white
        viewBase.layer.borderWidth = kBorderWidth
        viewBase.layer.borderColor = UIColor.colourBackgroundGray.cgColor
        
        addSubview(viewBase)
        
        NSLayoutConstraint.topToTop(
            view:viewBase,
            toView:self,
            constant:kBaseTop)
        NSLayoutConstraint.bottomToBottom(
            view:viewBase,
            toView:self,
            constant:kBaseBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBase,
            toView:self,
            margin:kBaseMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
