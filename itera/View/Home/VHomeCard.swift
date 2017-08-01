import UIKit

class VHomeCard:View<VHome, MHome, CHome>
{
    static let kWidth:CGFloat = 200
    weak var layoutTop:NSLayoutConstraint!
    let kHeight:CGFloat = 250
    private let kBaseMargin:CGFloat = 1
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        alpha = 0
        backgroundColor = UIColor.black
        
        let viewBase:UIView = UIView()
        viewBase.isUserInteractionEnabled = false
        viewBase.translatesAutoresizingMaskIntoConstraints = false
        viewBase.clipsToBounds = true
        viewBase.backgroundColor = UIColor.white
        
        addSubview(viewBase)
        
        NSLayoutConstraint.equals(
            view:viewBase,
            toView:self,
            margin:kBaseMargin)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
