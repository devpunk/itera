import UIKit

class VEditRotateImagePicture:
    View<VEditRotate, MEditRotate, CEditRotate>
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 3
    
    required init(controller:CEditRotate)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.colourBackgroundDark.cgColor
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        guard
        
            let cgImage:CGImage = controller.model.edit.sequence?.items.first?.image
        
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
}
