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
            forMode:RunLoopMode.defaultRunLoopMode)
        
        if #available(iOS 10.0, *)
        {
            displayLink.preferredFramesPerSecond = VGif.kMaxFramesPerSecond
        }
        
        return displayLink
    }
    
    func currentFrame() -> VGifFrame?
    {
        let frame:VGifFrame?
        
        if indexFrame >= 0 && indexFrame < frames.count
        {
            frame = frames[indexFrame]
        }
        else
        {
            frame = nil
        }
        
        return frame
    }
    
    func asyncNeedsDisplay()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.setNeedsDisplay()
        }
    }
    
    func updateFrame(displayLink:CADisplayLink)
    {
        guard
            
            let item:VGifFrame = currentFrame()
        
        else
        {
            return
        }
        
        let timestamp:TimeInterval = displayLink.timestamp
        let itemChange:TimeInterval = item.expectChange()
        
        if timestamp >= itemChange
        {
            nextFrame(timestamp:timestamp)
        }
    }
    
    //MARK: private
    
    private func nextFrame(timestamp:TimeInterval)
    {
        let totalFrames:Int = frames.count
        
        if indexFrame < totalFrames - 1
        {
            indexFrame += 1
        }
        else
        {
            indexFrame = 0
        }
        
        guard
            
            let item:VGifFrame = currentFrame()
            
        else
        {
            return
        }
        
        item.timestamp = timestamp
        
        setNeedsDisplay()
    }
}
