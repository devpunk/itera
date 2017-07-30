import UIKit

class VHomeProjectsCell:UICollectionViewCell
{
    private weak var model:MHomeItem?
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
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
    
    //MARK: public
    
    func config(model:MHomeItem)
    {
        self.model = model
        
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
