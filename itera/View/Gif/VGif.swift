import UIKit

class VGif:UIView
{
    private(set) var frames:[VGifFrame]
    private(set) var currentFrame:Int
    private weak var displayLink:CADisplayLink?
    
    init()
    {
        frames = []
        currentFrame = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        displayLink?.invalidate()
    }
    
    override func removeFromSuperview()
    {
        super.removeFromSuperview()
        
        displayLink?.invalidate()
    }
    
    //MARK: selectors
    
    func updateDisplayLink(sender displayLink:CADisplayLink)
    {
        updateFrame(displayLink:displayLink)
    }
    
    //MARK: public
    
    func framesLoaded(frames:[VGifFrame])
    {
        self.frames = frames
        displayLink = factoryDisplayLink()
    }
}
