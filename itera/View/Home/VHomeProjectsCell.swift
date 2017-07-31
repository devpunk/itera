import UIKit

class VHomeProjectsCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kAlphaSelected:CGFloat = 0
    private let kAlphaHighlighted:CGFloat = 0.2
    private let kAlphaStand:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
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
        if isSelected
        {
            imageView.alpha = kAlphaSelected
        }
        else if isHighlighted
        {
            imageView.alpha = kAlphaHighlighted
        }
        else
        {
            imageView.alpha = kAlphaStand
        }
    }
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        imageView.image = model.image
        hover()
    }
}
