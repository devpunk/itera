import UIKit

class VFullScreenMenuCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kAlphaSelect:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
            alpha = kAlphaSelect
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MFullScreenProtocol)
    {
        imageView.image = model.icon
        hover()
    }
}
