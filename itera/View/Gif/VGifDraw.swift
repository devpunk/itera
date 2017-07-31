import UIKit

extension VGif
{
    class func scaleImageRect(
        targetRect:CGRect,
        image:CGImage,
        contentMode:UIViewContentMode) -> CGRect
    {
        let width:CGFloat = targetRect.width
        let height:CGFloat = targetRect.height
        let imageWidth:CGFloat = CGFloat(image.width)
        let imageHeight:CGFloat = CGFloat(image.height)
        let ratioWidth:CGFloat = imageWidth / width
        let ratioHeight:CGFloat = imageHeight / height
        let ratio:CGFloat
        
        switch contentMode
        {
        case UIViewContentMode.scaleAspectFit:
            
            ratio = max(ratioWidth, ratioHeight)
            
            break
            
        default:
            
            ratio = min(ratioWidth, ratioHeight)
            
            break
        }
        
        let scaledWidth:CGFloat = imageWidth / ratio
        let scaledHeight:CGFloat = imageHeight / ratio
        let remainWidth:CGFloat = width - scaledWidth
        let remainHeight:CGFloat = height - scaledHeight
        let marginX:CGFloat = remainWidth / 2.0
        let marginY:CGFloat = remainHeight / 2.0
        let draw:CGRect = CGRect(
            x:marginX,
            y:marginY,
            width:scaledWidth,
            height:scaledHeight)
        
        return draw
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let frame:VGifFrame = currentFrame(),
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        let image:CGImage = frame.image
        let imageRect:CGRect
        
        if let rect:CGRect = self.imageRect
        {
            imageRect = rect
        }
        else
        {
            imageRect = VGif.scaleImageRect(
                targetRect:rect,
                image:image,
                contentMode:contentMode)
            self.imageRect = imageRect
        }
        
        draw(
            image:image,
            context:context,
            rect:rect,
            imageRect:imageRect)
    }
    
    //MARK: private
    
    private func draw(
        image:CGImage,
        context:CGContext,
        rect:CGRect,
        imageRect:CGRect)
    {
        context.translateBy(x:0, y:rect.height)
        context.scaleBy(x:1, y:-1)
        context.draw(image, in:imageRect)
    }
}
