import UIKit

class VSourceImageListCell:UICollectionViewCell
{
    private weak var model:MSourceImageItem?
    private weak var imageView:UIImageView!
    private weak var baseBlur:UIView!
    private weak var labelIndex:UILabel!
    private let kBlurAlpha:CGFloat = 0.996
    private let kAlphaSelected:CGFloat = 0.5
    private let kAlphaNotSelected:CGFloat = 1
    private let kIndexRight:CGFloat = -10
    private let kIndexHeight:CGFloat = 30
    private let kIndexWidth:CGFloat = 100
    
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
        
        let labelIndex:UILabel = UILabel()
        labelIndex.backgroundColor = UIColor.clear
        labelIndex.isUserInteractionEnabled = false
        labelIndex.translatesAutoresizingMaskIntoConstraints = false
        labelIndex.textAlignment = NSTextAlignment.right
        labelIndex.textColor = UIColor.black
        labelIndex.font = UIFont.regular(size:16)
        self.labelIndex = labelIndex
        
        baseBlur.addSubview(blur)
        addSubview(imageView)
        addSubview(baseBlur)
        addSubview(labelIndex)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        
        NSLayoutConstraint.equals(
            view:baseBlur,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:labelIndex,
            toView:self)
        NSLayoutConstraint.height(
            view:labelIndex,
            constant:kIndexHeight)
        NSLayoutConstraint.rightToRight(
            view:labelIndex,
            toView:self,
            constant:kIndexRight)
        NSLayoutConstraint.width(
            view:labelIndex,
            constant:kIndexWidth)
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
            baseBlur.isHidden = false
            labelIndex.isHidden = false
            imageView.alpha = kAlphaSelected
        }
        else
        {
            baseBlur.isHidden = true
            labelIndex.isHidden = true
            imageView.alpha = kAlphaNotSelected
        }
    }
    
    //MARK: internal
    
    func refresh()
    {
        guard
        
            let model:MSourceImageItem = self.model
        
        else
        {
            return
        }
        
        imageView.image = model.image
        labelIndex.text = model.selectedIndex
    }
    
    func config(model:MSourceImageItem)
    {
        self.model = model
        model.viewCell = self
        refresh()
        
        if model.image == nil
        {
            model.requestImage()
        }
        
        hover()
    }
}
