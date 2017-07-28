import UIKit

extension MSave
{
    func cropSequence(sequence:MEditSequence)
    {
        let topPercent:CGFloat = sequence.crop.top
        let bottomPercent:CGFloat = sequence.crop.bottom
        let leftPercent:CGFloat = sequence.crop.left
        let rightPercent:CGFloat = sequence.crop.right
        
        if topPercent != 0 || bottomPercent != 0 || leftPercent != 0 || rightPercent != 0
        {
            let items:[MEditSequenceItem] = sequence.items
            
            guard
                
                let firstImage:CGImage = items.first?.image
            
            else
            {
                return
            }
            
            let imageWidth:CGFloat = CGFloat(firstImage.width)
            let imageHeight:CGFloat = CGFloat(firstImage.height)
            
            let top:CGFloat = topPercent * imageHeight
            let bottom:CGFloat = bottomPercent * imageHeight
            let left:CGFloat = leftPercent * imageWidth
            let right:CGFloat = rightPercent * imageWidth
            
            let topBottom:CGFloat = bottom - top
            let leftRight:CGFloat = right - left
            
            let newHeight:CGFloat = imageHeight + topBottom
            let newWidth:CGFloat = imageWidth + leftRight
            let newSize:CGSize = CGSize(width:newWidth, height:newHeight)
            
            let drawRect:CGRect = CGRect(
                x:-left,
                y:-top,
                width:imageWidth,
                height:imageHeight)
            
            cropImages(
                items:items,
                size:newSize,
                drawRect:drawRect)
        }
    }
    
    //MARK: private
    
    private func cropImages(
        items:[MEditSequenceItem],
        size:CGSize,
        drawRect:CGRect)
    {
        for item:MEditSequenceItem in items
        {
            let original:CGImage = item.image
            
            guard
                
                let cropped:CGImage = cropImage(
                    image:original,
                    size:size,
                    drawRect:drawRect)
            
            else
            {
                continue
            }
            
            item.update(image:cropped)
        }
    }
    
    private func cropImage(
        image:CGImage,
        size:CGSize,
        drawRect:CGRect) -> CGImage?
    {
        UIGraphicsBeginImageContext(size)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
//        context.translateBy(x:0, y:imageSize.height)
//        context.scaleBy(x:1, y:-1)
        context.draw(image, in:drawRect)
        
        guard
            
            let newImage:CGImage = context.makeImage()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
