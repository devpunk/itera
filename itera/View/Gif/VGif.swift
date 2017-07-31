import UIKit

class VGif:UIView
{
    var currentFrame:Int
    private(set) var frames:[VGifFrame]
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
