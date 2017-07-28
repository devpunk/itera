import UIKit

class VSaveProgressThumb:View<VSave, MSave, CSave>
{
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private let kImageSize:CGFloat = 150
    private let kBorderWidth:CGFloat = 10
    
    required init(controller:CSave)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = kImageSize / 2.0
        imageView.layer.borderWidth = kBorderWidth
        imageView.layer.borderColor = UIColor.white.cgColor
        
        addSubview(imageView)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
        
        guard
        
            let cgImage:CGImage = controller.model.sequence?.items.first?.image
        
        else
        {
            return
        }
        
        let image:UIImage = UIImage(cgImage:cgImage)
        imageView.image = image
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kImageSize
        let remainHeight:CGFloat = height - kImageSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutImageTop.constant = marginTop
        layoutImageLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
}
