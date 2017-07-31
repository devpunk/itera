import UIKit

extension VGif
{
    private static let kMaxFramesPerSecond:Int = 20
    
    func factoryDisplayLink() -> CADisplayLink
    {
        let displayLink:CADisplayLink = CADisplayLink(
            target:self,
            selector:#selector(updateDisplayLink(sender:)))
        displayLink.add(
            to:RunLoop.main,
            forMode:RunLoopMode.commonModes)
        
        if #available(iOS 10.0, *)
        {
            displayLink.preferredFramesPerSecond = VGif.kMaxFramesPerSecond
        }
        
        return displayLink
    }
    
    func updateFrame(displayLink:CADisplayLink)
    {
        let timestamp:TimeInterval = displayLink.timestamp
//        let item:VGifFrame = 
    }
}
