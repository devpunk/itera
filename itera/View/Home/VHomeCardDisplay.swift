import UIKit
import GifHero

class VHomeCardDisplay:View<VHome, MHome, CHome>
{
    private(set) weak var viewGif:GifView?
    private weak var item:MHomeItem?
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 4
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
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
            action:#selector(selectorUpInside(sender:)),
            for:UIControlEvents.touchUpInside)
        button.addTarget(
            self,
            action:#selector(selectorUpOutside(sender:)),
            for:UIControlEvents.touchUpOutside)
        button.addTarget(
            self,
            action:#selector(selectorDown(sender:)),
            for:UIControlEvents.touchDown)
        
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
    
    func selectorUpInside(sender button:UIButton)
    {
        guard
        
            let viewGif:GifView = self.viewGif
        
        else
        {
            return
        }
        
        let animating:Bool = viewGif.animating
        viewGif.animating = !animating
        viewGif.alpha = kAlphaNotSelected
    }
    
    func selectorUpOutside(sender button:UIButton)
    {
        viewGif?.alpha = kAlphaNotSelected
    }
    
    func selectorDown(sender button:UIButton)
    {
        viewGif?.alpha = kAlphaSelected
    }
    
    //MARK: public
    
    func forcePause()
    {
        viewGif?.animating = false
    }
    
    func prepareForDelete()
    {
        viewGif?.removeFromSuperview()
    }
}
