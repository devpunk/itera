import UIKit

class VCameraCropImageThumb:UIImageView
{
    enum Location
    {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    var positionX:CGFloat
    var positionY:CGFloat
    let location:Location
    private weak var layoutTop:NSLayoutConstraint!
    private weak var layoutLeft:NSLayoutConstraint!
    private var size_2:CGFloat
    
    init(location:Location)
    {
        self.location = location
        positionX = 0
        positionY = 0
        size_2 = 0
        
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = true
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        
        state(selected:false)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
 
    func position(positionX:CGFloat, positionY:CGFloat)
    {
        self.positionX = positionX
        self.positionY = positionY
        layoutTop.constant = positionY - size_2
        layoutLeft.constant = positionX - size_2
    }
    
    func initConstraints(size:CGFloat)
    {
        guard
            
            let superview:UIView = self.superview
        
        else
        {
            return
        }
        
        size_2 = size / 2.0
        layoutTop = NSLayoutConstraint.topToTop(
            view:self,
            toView:superview)
        layoutLeft = NSLayoutConstraint.leftToLeft(
            view:self,
            toView:superview)
        NSLayoutConstraint.size(
            view:self,
            constant:size)
    }
    
    func state(selected:Bool)
    {
        if selected
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
        else
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
    }
}