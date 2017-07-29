import UIKit

class MEditSequence
{
    let items:[MEditSequenceItem]
    var duration:TimeInterval
    var crop:MEditSequenceCrop
    var scale:CGFloat
    
    init(items:[MEditSequenceItem], duration:TimeInterval)
    {
        self.items = items
        self.duration = duration
        scale = 1
        crop = MEditSequenceCrop(
            top:0,
            bottom:0,
            left:0,
            right:0)
    }
}
