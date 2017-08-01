import UIKit

class VFullScreenDisplay:View<VFullScreen, MFullScreen, CFullScreen>
{
    private weak var viewGif:VGif!
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        
        let path:URL = controller.model.item.path
        let viewGif:VGif = VGif.withURL(url:path)
        viewGif.contentMode = UIViewContentMode.scaleAspectFit
        self.viewGif = viewGif
        
        addSubview(viewGif)
        
        NSLayoutConstraint.equals(
            view:viewGif,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
