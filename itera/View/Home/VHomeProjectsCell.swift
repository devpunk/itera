import UIKit

class VHomeProjectsCell:UICollectionViewCell
{
    static let kImageSize:CGFloat = 50
    private weak var imageView:UIImageView!
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.borderWidth = kBorderWidth
        imageView.layer.borderColor = UIColor.colourBackgroundDark.cgColor
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:VHomeProjectsCell.kImageSize)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        imageView.image = model.image
    }
}
