import UIKit

class VHomeCardDisplay:View<VHome, MHome, CHome>
{
    private weak var item:MHomeItem?
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 5
    
    required init(controller:CHome)
    {
        item = controller.model.currentItem()
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = item?.image
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
