import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    weak var movingCorner:VEditCropImageCorner?
    weak var viewPicture:VEditCropImagePicture!
    weak var cornerTopLeft:VEditCropImageCornerTopLeft!
    weak var cornerTopRight:VEditCropImageCornerTopRight!
    weak var cornerBottomLeft:VEditCropImageCornerBottomLeft!
    weak var cornerBottomRight:VEditCropImageCornerBottomRight!
    let margin2:CGFloat
    let kMargin:CGFloat = 20
    let kCornerSize:CGFloat = 40
    let kMinCornerSeparation:CGFloat = 50
    let kBorderWidth:CGFloat = 1
    
    required init(controller:CEditCrop)
    {
        margin2 = kMargin + kMargin
        
        super.init(controller:controller)
        backgroundColor = UIColor.black
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func touchesBegan(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesBegan(touches:touches)
    }
    
    override func touchesMoved(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesMoved(touches:touches)
    }
    
    override func touchesCancelled(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesCancelled(touches:touches)
    }
    
    override func touchesEnded(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesEnded(touches:touches)
    }
}
