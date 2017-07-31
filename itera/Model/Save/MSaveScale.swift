import UIKit

extension MSave
{
    func scaleSequence(sequence:MEditSequence)
    {
        let scale:CGFloat = sequence.scale
        
        if scale < 1
        {
            guard
                
                let firstImage:CGImage = sequence.items.first?.image
            
            else
            {
                return
            }
            
            let width:CGFloat = CGFloat(firstImage.width)
            let height:CGFloat = CGFloat(firstImage.height)
            let scaledWidth:CGFloat = floor(width * scale)
            let scaledHeight:CGFloat = floor(height * scale)
            let size:CGSize = CGSize(
                width:scaledWidth,
                height:scaledHeight)
            let rect:CGRect = CGRect(
                x:0,
                y:0,
                width:scaledWidth,
                height:scaledHeight)
            
            scaleImages(
                sequence:sequence,
                size:size,
                rect:rect)
        }
    }
    
    //MARK: private
    
    private func scaleImages(
        sequence:MEditSequence,
        size:CGSize,
        rect:CGRect)
    {
        let items:[MEditSequenceItem] = sequence.items
        
        for item:MEditSequenceItem in items
        {
            let image:CGImage = item.image
            
            guard
                
                let newImage:CGImage = image.resize(
                    canvasSize:size,
                    imageRect:rect)
                
            else
            {
                return
            }
            
            item.update(image:newImage)
        }
    }
}
