import Foundation

class MSave:Model
{
    let kResourceName:String = "ResourceURL"
    let kResourceExtension:String = "plist"
    let kDirectoryKey:String = "directory"
    let kGifExtension:String = ".gif"
    let kDelayGeneration:TimeInterval = 0.25
    private(set) var sequence:MEditSequence?
    private(set) weak var controller:CSave?
    private var path:URL?
    
    //MARK: private
    
    private func asyncSave()
    {
        guard
        
            let sequence:MEditSequence = self.sequence,
            let path:URL = filePath()
        
        else
        {
            savingError()
            
            return
        }
        
        self.path = path
        cropSequence(sequence:sequence)
        factoryGif(sequence:sequence, path:path)
    }
    
    //MARK: public
    
    func config(sequence:MEditSequence)
    {
        self.sequence = sequence
    }
    
    func save(controller:CSave)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
        
            self?.asyncSave()
        }
    }
    
    func savingError()
    {
        let message:String = String.localizedModel(
            key:"MSave_errorMessage")
        VAlert.messageFail(message:message)
        
        controller?.close()
    }
    
    func savingSuccess()
    {
        guard
            
            let path:URL = self.path
        
        else
        {
            controller?.close()
            
            return
        }
        
        controller?.export(url:path)
    }
}
