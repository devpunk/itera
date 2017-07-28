import UIKit

class MEditSequenceItem
{
    private(set) var image:CGImage
    
    init(image:CGImage)
    {
        self.image = image
    }
    
    //MARK: public
    
    func update(image:CGImage)
    {
        self.image = image
    }
}
