import UIKit

extension VGif
{
    override func draw(_ rect:CGRect)
    {
        print("draw")
        
        guard
        
            let frame:VGifFrame = currentFrame(),
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        print("draw 2")
        
        draw(
            frame:frame,
            context:context,
            rect:rect)
    }
    
    //MARK: private
    
    private func draw(
        frame:VGifFrame,
        context:CGContext,
        rect:CGRect)
    {
        let image:CGImage = frame.image
        let imageRect:CGRect = drawRect(
            rect:rect,
            image:image)
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
