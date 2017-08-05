import UIKit

extension MSourceImageImportFactory
{
    private static let kDefaultDuration:TimeInterval = 1
    
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
        
        let sequence:MEditSequence = MEditSequence(
            items:items,
            duration:kDefaultDuration)
        
        return sequence
    }
}
