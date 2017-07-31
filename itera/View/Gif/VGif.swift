import UIKit

class VGif:UIView
{
    let queueGif:DispatchQueue
    private var displayLink:CADisplayLink?
    private var frames:[VGifFrame]
    private var currentFrame:Int
    private let kQueueLabel:String = "iturbide.itera.gif"
    
    init()
    {
        queueGif = DispatchQueue(
            label:kQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        frames = []
        currentFrame = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: action
    
    func actionDisplayLink(sender displayLink:CADisplayLink)
    {
        print("update")
    }
    
    //MARK: private
    
    private func factoryDisplayLink()
    {
        displayLink = CADisplayLink(
            target:self,
            selector:#selector(actionDisplayLink(sender:)))
        displayLink?.add(
            to:RunLoop.main,
            forMode:RunLoopMode.commonModes)
    }
    
    //MARK: public
    
    func framesLoaded(frames:[VGifFrame])
    {
        self.frames = frames
        factoryDisplayLink()
    }
}
