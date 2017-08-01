import UIKit

class VGif:UIView
{
    var imageRect:CGRect?
    var indexFrame:Int
    private(set) var frames:[VGifFrame]
    private weak var displayLink:CADisplayLink?
    
    init()
    {
        frames = []
        indexFrame = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        contentMode = UIViewContentMode.scaleAspectFill
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
    
    override func layoutSubviews()
    {
        imageRect = nil
        
        super.layoutSubviews()
    }
    
    override var contentMode:UIViewContentMode
    {
        didSet
        {
            imageRect = nil
        }
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
        asyncNeedsDisplay()
        displayLink = factoryDisplayLink()
    }
}
