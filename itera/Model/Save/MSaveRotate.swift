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
            
            rotateImages(
                sequence:sequence,
                rotate:rotate)
        }
    }
    
    //MARK: private
    
    private func rotateImages(
        sequence:MEditSequence,
        rotate:CGFloat)
    {
        let items:[MEditSequenceItem] = sequence.items
        
        for item:MEditSequenceItem in items
        {
            let image:CGImage = item.image
            
            guard
                
                let newImage:CGImage = drawImage(
                    image:image,
                    size:size,
                    drawRect:rect)
                
            else
            {
                return
            }
            
            item.update(image:newImage)
        }
    }
}
