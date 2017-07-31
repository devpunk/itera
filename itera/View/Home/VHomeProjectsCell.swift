import UIKit

class VHomeProjectsCell:UICollectionViewCell
{
    private weak var model:MHomeItem?
    private weak var imageView:UIImageView!
    private let kAlphaSelected:CGFloat = 0
    private let kAlphaHighlighted:CGFloat = 0.2
    private let kAlphaStand:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func loadImage()
    {
        guard
        
            let model:MHomeItem = self.model
        
        else
        {
            return
        }
        
        let data:Data?
        
        do
        {
            try data = Data(
                contentsOf:model.path,
                options:Data.ReadingOptions.uncached)
        }
        catch
        {
            data = nil
        }
        
        guard
        
            let loadedData:Data = data,
            let image:UIImage = UIImage(data:loadedData)
        
        else
        {
            return
        }
        
        model.image = image
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.imageLoaded()
        }
    }
    
    private func imageLoaded()
    {
        imageView.image = model?.image
    }
    
    private func hover()
    {
        if isSelected
        {
            imageView.alpha = kAlphaSelected
        }
        else if isHighlighted
        {
            imageView.alpha = kAlphaHighlighted
        }
        else
        {
            imageView.alpha = kAlphaStand
        }
    }
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        self.model = model
        imageView.image = nil
        hover()
        
        guard
        
            let image:UIImage = model.image
        
        else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.loadImage()
            }
            
            return
        }
        
        imageView.image = image
    }
}
