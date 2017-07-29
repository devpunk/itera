import UIKit

extension VEditRotateImage
{   
    func layout()
    {
        guard
            
            let image:CGImage = controller.model.edit.sequence?.items.first?.image
            
        else
        {
            return
        }
        
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let usableWidth:CGFloat = canvasWidth - margin2
        let usableHeight:CGFloat = canvasHeight - margin2
        let width:CGFloat = CGFloat(image.width)
        let height:CGFloat = CGFloat(image.height)
        let deltaWidth:CGFloat = width / usableWidth
        let deltaHeight:CGFloat = height / usableHeight
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = width / maxDelta
        let scaledHeight:CGFloat = height / maxDelta
        let remainWidth:CGFloat = canvasWidth - scaledWidth
        let remainHeight:CGFloat = canvasHeight - scaledHeight
        let marginWidth:CGFloat = remainWidth / 2.0
        let marginHeight:CGFloat = remainHeight / 2.0
        
        viewPicture.layoutRight.constant = -marginWidth
        viewPicture.layoutLeft.constant = marginWidth
        viewPicture.layoutTop.constant = marginHeight
        viewPicture.layoutBottom.constant = -marginHeight
    }
    
    func rotate()
    {
        guard
            
            let rotate:CGFloat = controller.model.edit.sequence?.rotate
            
        else
        {
            return
        }
        
        let transform:CGAffineTransform = CGAffineTransform(rotationAngle:rotate)
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.viewPicture.transform = transform
        }
    }
}
