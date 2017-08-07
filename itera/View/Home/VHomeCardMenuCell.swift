import UIKit

class VHomeCardMenuCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kAlphaSelected:CGFloat = 0.1
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    private func notAvailable()
    {
        isUserInteractionEnabled = false
        imageView.alpha = kAlphaSelected
    }
    
    private func available()
    {
        isUserInteractionEnabled = true
        imageView.alpha = kAlphaNotSelected
    }
    
    //MARK: internal
    
    func config(model:MHomeMenuProtocol, item:MHomeItem?)
    {
        imageView.image = model.icon
        
        guard
        
            let item:MHomeItem = item
            
        else
        {
            return
        }
        
        let isAvailable:Bool = model.available(item:item)
        
        if isAvailable
        {
            available()
        }
        else
        {
            notAvailable()
        }
        
        hover()
    }
}
