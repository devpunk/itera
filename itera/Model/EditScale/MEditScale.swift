import UIKit

class MEditScale:Model
{
    private(set) weak var edit:MEdit!
    var scaledWidth:CGFloat
    var scaledHeight:CGFloat
    var originalWidth:CGFloat
    var originalHeight:CGFloat
    
    required init()
    {
        scaledWidth = 0
        scaledHeight = 0
        originalWidth = 0
        originalHeight = 0
        
        super.init()
    }
    
    //MARK: public
    
    func config(edit:MEdit)
    {
        self.edit = edit
        
        guard
        
            let image:CGImage = edit.sequence?.items.first?.image
        
        else
        {
            return
        }
        
        originalWidth = CGFloat(image.width)
        originalHeight = CGFloat(image.height)
    }
}
