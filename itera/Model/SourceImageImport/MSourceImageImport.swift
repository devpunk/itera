import UIKit

class MSourceImageImport:Model, MSourceImageImportFactoryDelegate
{
    private(set) var items:[MSourceImageItem]?
    private weak var controller:CSourceImageImport?
    private var factory:MSourceImageImportFactory?
    
    //MARK: private
    
    private func asyncImportImages()
    {
        guard
            
            let items:[MSourceImageItem] = self.items
        
        else
        {
            return
        }
        
        factory = MSourceImageImportFactory(
            items:items,
            delegate:self)
        
        self.items = nil
    }
    
    //MARK: internal
    
    func config(items:[MSourceImageItem])
    {
        self.items = items
    }
    
    func importImages(controller:CSourceImageImport)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncImportImages()
        }
    }
    
    //MARK: factory delegate
    
    func importSequenceReady(sequence:MEditSequence)
    {
        controller?.imagesImported(sequence:sequence)
    }
    
    func importError()
    {
        let error:String = String.localizedModel(key:"MSourceImageImport_error")
        VAlert.messageFail(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.cancel()
        }
    }
    
    func importProgress(percent:CGFloat, image:UIImage?)
    {
        controller?.updateProgress(percent:percent, image:image)
    }
}
