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
            let size:CGSize = CGSize(
                width:width,
                height:height)
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
        
        context.rotate(by:rotate)
        context.translateBy(x:0, y:rect.height)
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
