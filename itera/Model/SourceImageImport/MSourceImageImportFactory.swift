import UIKit
import Photos

class MSourceImageImportFactory
{
    var maxImageSize:CGSize
    private weak var delegate:MSourceImageImportFactoryDelegate?
    private var items:[MSourceImageItem]
    private var images:[CGImage]
    private var itemIndex:Int
    private var totalItems:Int
    private let kDelay:TimeInterval = 0.25
    private let kInitialItemIndex:Int = -1
    
    init(
        items:[MSourceImageItem],
        delegate:MSourceImageImportFactoryDelegate)
    {
        self.items = items
        self.delegate = delegate
        images = []
        totalItems = items.count
        itemIndex = kInitialItemIndex
        maxImageSize = CGSize.zero
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.recursiveCheck()
        }
    }
    
    private func delayRecursiveImport()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kDelay)
        { [weak self] in
            
            self?.recursiveImport()
        }
    }
    
    private func recursiveImport()
    {
        let item:MSourceImageItem = items[itemIndex]
        
        item.requestData
        { [weak self] (data:Data?) in
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.dataReceived(data:data)
            }
        }
    }
    
    private func dataReceived(data:Data?)
    {
        parseData(data:data)
        recursiveCheck()
    }
    
    private func parseData(data:Data?)
    {
        guard
        
            let data:Data = data,
            let image:UIImage = UIImage(data:data),
            let cgImage:CGImage = image.cgImage
        
        else
        {
            return
        }
        
        images.append(cgImage)
    }
    
    private func createSequence()
    {
        let sequence:MEditSequence = MSourceImageImportFactory.factorySequence(
            images:images)
        
        delegate?.importSequenceReady(sequence:sequence)
    }
    
    //MARK: internal
    
    func recursiveCheck()
    {
        itemIndex += 1
        
        if itemIndex >= totalItems
        {
            createSequence()
        }
        else
        {
            let index:CGFloat = CGFloat(itemIndex)
            let total:CGFloat = CGFloat(totalItems)
            let image:UIImage? = items[itemIndex].image
            let progress:CGFloat = index / total
            
            delegate?.importProgress(
                percent:progress,
                image:image)
            delayRecursiveImport()
        }
    }
}
