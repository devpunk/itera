import UIKit

class VSaveBottom:View<VSave, MSave, CSave>
{
    private let kTitleHeight:CGFloat = 30
    private let kSubtitleHeight:CGFloat = 60
    
    required init(controller:CSave)
    {
        super.init(controller:controller)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.medium(size:17)
        labelTitle.textColor = UIColor.white
        labelTitle.text = String.localizedView(
            key:"VSaveBottom_labelTitle")
        
        let labelSubtitle:UILabel = UILabel()
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.isUserInteractionEnabled = false
        labelSubtitle.backgroundColor = UIColor.clear
        labelSubtitle.textAlignment = NSTextAlignment.center
        labelSubtitle.font = UIFont.regular(size:14)
        labelSubtitle.textColor = UIColor(white:1, alpha:0.8)
        labelSubtitle.numberOfLines = 0
        labelSubtitle.text = String.localizedView(
            key:"VSaveBottom_labelSubtitle")
        
        addSubview(labelTitle)
        addSubview(labelSubtitle)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelSubtitle,
            toView:labelTitle)
        NSLayoutConstraint.height(
            view:labelSubtitle,
            constant:kSubtitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSubtitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
