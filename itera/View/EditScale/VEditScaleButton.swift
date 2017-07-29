import UIKit

class VEditScaleButton:UIButton
{
    init(title:String)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(
            UIColor.colourBackgroundDark.withAlphaComponent(0.5),
            for:UIControlState.normal)
        setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        setTitle(
            title,
            for:UIControlState.normal)
        titleLabel!.font = UIFont.medium(size:15)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
