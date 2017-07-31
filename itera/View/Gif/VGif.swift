import UIKit

class VGif:UIView
{
    let queueGif:DispatchQueue
    private var frames:[VGifFrame]
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
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
