import UIKit
import GifHero

class VFullScreenDisplay:
    View<VFullScreen, MFullScreen, CFullScreen>
{
    private weak var viewGif:GifView?
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        
        let path:URL = controller.model.item.path
        
        let viewGif:GifView = GifView()
        viewGif.contentMode = UIViewContentMode.scaleAspectFit
        viewGif.url = path
        viewGif.animating = true
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
    
    //MARK: internal
    
    func releaseGif()
    {
        viewGif?.removeFromSuperview()
    }
}
