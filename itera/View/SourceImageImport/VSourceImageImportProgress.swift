import UIKit

class VSourceImageImportProgress:
    View<VSourceImageImport, MSourceImageImport, CSourceImageImport>
{
    private weak var viewBar:VSourceImageImportProgressBar!
    private weak var viewThumb:VSourceImageImportProgressThumb!
    
    required init(controller:CSourceImageImport)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewBar:VSourceImageImportProgressBar = VSourceImageImportProgressBar(
            controller:controller)
        self.viewBar = viewBar
        
        let viewThumb:VSourceImageImportProgressThumb = VSourceImageImportProgressThumb(
            controller:controller)
        self.viewThumb = viewThumb
        
        addSubview(viewBar)
        addSubview(viewThumb)
        
        NSLayoutConstraint.equals(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewThumb,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func updateProgress(percent:CGFloat, image:CGImage)
    {
        let image:UIImage = UIImage(cgImage:image)
        
        viewBar.update(percent:percent)
        viewThumb.imageView.image = image
    }
}
