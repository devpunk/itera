import UIKit

extension VGif
{
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
            imageRect = drawRect(rect:rect, image:image)
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
    
    private func drawRect(rect:CGRect, image:CGImage) -> CGRect
    {
        let width:CGFloat = rect.width
        let height:CGFloat = rect.height
        let imageWidth:CGFloat = CGFloat(image.width)
        let imageHeight:CGFloat = CGFloat(image.height)
        let ratioWidth:CGFloat = imageWidth / width
        let ratioHeight:CGFloat = imageHeight / height
        let maxRatio:CGFloat = max(ratioWidth, ratioHeight)
        let scaledWidth:CGFloat = imageWidth / maxRatio
        let scaledHeight:CGFloat = imageHeight / maxRatio
        let remainWidth:CGFloat = width - scaledWidth
        let remainHeight:CGFloat = height - scaledHeight
        let marginX:CGFloat = remainWidth / 2.0
        let marginY:CGFloat = remainHeight / 2.0
        let rect:CGRect = CGRect(
            x:marginX,
            y:marginY,
            width:scaledWidth,
            height:scaledHeight)
        
        return rect
    }
}
