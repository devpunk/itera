import UIKit

extension VEditScaleImage
{
    func layout()
    {
        constraintImage()
        importLayout()
    }
    
    //MARK: private
    
    private func constraintImage()
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
        
        controller.model.scaledWidth = scaledWidth
        controller.model.scaledHeight = scaledHeight
        
        viewOriginal.layoutRight.constant = -marginWidth
        viewOriginal.layoutLeft.constant = marginWidth
        viewOriginal.layoutTop.constant = marginHeight
        viewOriginal.layoutBottom.constant = -marginHeight
    }
    
    private func importLayout()
    {
        guard
        
            let scale:CGFloat = controller.model.edit.sequence?.scale
        
        else
        {
            return
        }
        
        if scale < 1
        {
            let scaledWidth:CGFloat = controller.model.scaledWidth
            let scaledHeight:CGFloat = controller.model.scaledHeight
            let width:CGFloat = scale * scaledWidth
            let height:CGFloat = scale * scaledHeight
            let remainWidth:CGFloat = scaledWidth - width
            let remainHeight:CGFloat = scaledHeight - height
            let marginHorizontal:CGFloat = remainWidth / 2.0
            let marginVertical:CGFloat = remainHeight / 2.0
            
            viewScaled.layoutTop.constant = marginVertical
            viewScaled.layoutBottom.constant = -marginVertical
            viewScaled.layoutLeft.constant = marginHorizontal
            viewScaled.layoutRight.constant = -marginHorizontal
        }
    }
}
