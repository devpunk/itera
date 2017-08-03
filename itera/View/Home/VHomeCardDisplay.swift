import UIKit
import GifHero

class VHomeCardDisplay:View<VHome, MHome, CHome>
{
    private(set) weak var viewGif:GifView?
    private weak var item:MHomeItem?
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 4
    
    required init(controller:CHome)
    {
        item = controller.model.currentItem()
        
        super.init(controller:controller)
        layer.cornerRadius = kCornerRadius
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = item?.image
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        guard
        
            let path:URL = item?.path
        
        else
        {
            return
        }
        
        let viewGif:GifView = GifView()
        viewGif.url = path
        viewGif.animating = true
        self.viewGif = viewGif
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewGif)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:viewGif,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:button,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: selectors
    
    func actionButton(sender button:UIButton)
    {
        guard
        
            let viewGif:GifView = self.viewGif
        
        else
        {
            return
        }
        
        let animating:Bool = viewGif.animating
        viewGif.animating = !animating
    }
    
    //MARK: public
    
    func forcePause()
    {
        viewGif?.animating = false
    }
}
