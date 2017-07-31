import UIKit

class VGifFrame
{
    let image:CGImage
    let duration:TimeInterval
    let timestamp:TimeInterval
    
    init(image:CGImage, duration:TimeInterval)
    {
        self.image = image
        self.duration = duration
        timestamp = 0
    }
}
