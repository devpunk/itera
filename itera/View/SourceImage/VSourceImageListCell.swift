import UIKit

class VSourceImageListCell:UICollectionViewCell
{
    private weak var model:MSourceImageItem?
    private weak var imageView:UIImageView!
    private weak var baseBlur:UIView!
    private let kBlurAlpha:CGFloat = 0.996
    private let kAlphaSelected:CGFloat = 0.5
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        baseBlur.alpha = kBlurAlpha
        self.baseBlur = baseBlur
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.clipsToBounds = true
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        baseBlur.addSubview(blur)
        addSubview(imageView)
        addSubview(baseBlur)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        
        NSLayoutConstraint.equals(
            view:baseBlur,
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
    
    private func refresh()
    {
        imageView.image = model?.image
    }
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            baseBlur.isHidden = false
            imageView.alpha = kAlphaSelected
        }
        else
        {
            baseBlur.isHidden = true
            imageView.alpha = kAlphaNotSelected
        }
    }
    
    //MARK: internal
    
    func config(model:MSourceImageItem)
    {
        self.model = model
        refresh()
        
        if model.image == nil
        {
            model.requestImage
            { [weak self] in
                
                self?.refresh()
            }
        }
        
        hover()
    }
}
