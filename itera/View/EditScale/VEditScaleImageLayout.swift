import UIKit

extension VEditScaleImage
{
    func layout()
    {
        constraintImage()
        updateScale()
    }
    
    func updateScale()
    {
        guard
            
            let scale:CGFloat = controller.model.edit.sequence?.scale
            
        else
        {
            return
        }
        
        scaledTo(scale:scale)
    }
    
    //MARK: private
    
    private func constraintImage()
    {
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let usableWidth:CGFloat = canvasWidth - margin2
        let usableHeight:CGFloat = canvasHeight - margin2
        let width:CGFloat = controller.model.originalWidth
        let height:CGFloat = controller.model.originalHeight
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
    
    private func scaledTo(scale:CGFloat)
    {
        let scaledWidth:CGFloat = controller.model.scaledWidth
        let scaledHeight:CGFloat = controller.model.scaledHeight
        let usableWidth:CGFloat = scaledWidth - scaledMargin2
        let usableHeight:CGFloat = scaledHeight - scaledMargin2
        let width:CGFloat = scale * usableWidth
        let height:CGFloat = scale * usableHeight
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
