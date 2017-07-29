import UIKit

extension VEditScaleImage
{
    func layout()
    {
        constraintImage()
//        importLayout()
    }
    
    //MARK: private
    
    private func constraintImage()
    {
        guard
            
            let image:UIImage = viewPicture.image
            
        else
        {
            return
        }
        
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let usableWidth:CGFloat = canvasWidth - imageMargin2
        let usableHeight:CGFloat = canvasHeight - imageMargin2
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let deltaWidth:CGFloat = width / usableWidth
        let deltaHeight:CGFloat = height / usableHeight
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let scaledWidth:CGFloat = width / maxDelta
        let scaledHeight:CGFloat = height / maxDelta
        let remainWidth:CGFloat = canvasWidth - scaledWidth
        let remainHeight:CGFloat = canvasHeight - scaledHeight
        let marginWidth:CGFloat = remainWidth / 2.0
        let marginHeight:CGFloat = remainHeight / 2.0
        
        controller.model.scaledWidth = scaledWidth
        controller.model.scaledHeight = scaledHeight
        
        viewPicture.layoutRight.constant = -marginWidth
        viewPicture.layoutLeft.constant = marginWidth
        viewPicture.layoutTop.constant = marginHeight
        viewPicture.layoutBottom.constant = -marginHeight
    }
}
