import UIKit

extension MSave
{
    func rotateSequence(sequence:MEditSequence)
    {
        let rotate:CGFloat = sequence.rotate
        
        if rotate != 0
        {
            guard
                
                let firstImage:CGImage = sequence.items.first?.image
                
            else
            {
                return
            }
            
            let width:CGFloat = CGFloat(firstImage.width)
            let height:CGFloat = CGFloat(firstImage.height)
            let absRotate:CGFloat = abs(rotate)
            let size:CGSize
            
            if absRotate == CGFloat.pi
            {
                size = CGSize(
                    width:width,
                    height:height)
            }
            else
            {
                size = CGSize(
                    width:height,
                    height:width)
            }
            
            let rect:CGRect = CGRect(
                x:0,
                y:0,
                width:width,
                height:height)
            
            rotateImages(
                sequence:sequence,
                rotate:rotate,
                size:size,
                rect:rect)
        }
    }
    
    //MARK: private
    
    private func rotateImages(
        sequence:MEditSequence,
        rotate:CGFloat,
        size:CGSize,
        rect:CGRect)
    {
        let items:[MEditSequenceItem] = sequence.items
        
        for item:MEditSequenceItem in items
        {
            let image:CGImage = item.image
            
            guard
                
                let newImage:CGImage = rotateImage(
                    image:image,
                    rotate:rotate,
                    size:size,
                    rect:rect)
                
            else
            {
                return
            }
            
            item.update(image:newImage)
        }
    }
    
    private func rotateImage(
        image:CGImage,
        rotate:CGFloat,
        size:CGSize,
        rect:CGRect) -> CGImage?
    {
        UIGraphicsBeginImageContext(size)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        let width_2:CGFloat = size.width / 2.0
        let height_2:CGFloat = size.height / 2.0
        
        context.translateBy(x:width_2, y:height_2)
        context.rotate(by:rotate)
        context.translateBy(x:-rect.midX, y:rect.midY)
        context.scaleBy(x:1, y:-1)
        context.draw(image, in:rect)
        
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
