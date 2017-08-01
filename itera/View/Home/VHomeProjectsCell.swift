import UIKit

class VHomeProjectsCell:UICollectionViewCell
{
    static let kImageSize:CGFloat = 50
    private weak var imageView:UIImageView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 1
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
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - VHomeProjectsCell.kImageSize
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutImageLeft.constant = marginLeft
        
        super.layoutSubviews()
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
