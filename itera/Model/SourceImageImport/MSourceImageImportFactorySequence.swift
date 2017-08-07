import UIKit

extension MSourceImageImportFactory
{
    class func factorySequence(
        images:[CGImage]) -> MEditSequence
    {
        var items:[MEditSequenceItem] = []
        
        for image:CGImage in images
        {
            let item:MEditSequenceItem = MEditSequenceItem(
                image:image)
            items.append(item)
        }
        
        let countImages:Int = images.count
        let duration:TimeInterval = TimeInterval(countImages)
        let sequence:MEditSequence = MEditSequence(
            items:items,
            duration:duration)
        
        return sequence
    }
}
