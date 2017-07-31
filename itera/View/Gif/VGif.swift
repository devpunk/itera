import UIKit

class VGif:UIView
{
    private weak var displayLink:CADisplayLink?
    private var frames:[VGifFrame]
    private var currentFrame:Int
    private let kMaxFramesPerSecond:Int = 20
    
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
    
    //MARK: action
    
    func actionDisplayLink(sender displayLink:CADisplayLink)
    {
    }
    
    //MARK: private
    
    private func factoryDisplayLink()
    {
        let displayLink:CADisplayLink = CADisplayLink(
            target:self,
            selector:#selector(actionDisplayLink(sender:)))
        displayLink.add(
            to:RunLoop.main,
            forMode:RunLoopMode.commonModes)
        
        if #available(iOS 10.0, *)
        {
            displayLink.preferredFramesPerSecond = kMaxFramesPerSecond
        }
        
        self.displayLink = displayLink
    }
    
    //MARK: public
    
    func framesLoaded(frames:[VGifFrame])
    {
        self.frames = frames
        factoryDisplayLink()
    }
}
