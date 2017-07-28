import Foundation

class MSave:Model
{
    let kResourceName:String = "ResourceURL"
    let kResourceExtension:String = "plist"
    let kDirectoryKey:String = "directory"
    let kGifExtension:String = ".gif"
    private(set) var sequence:MEditSequence?
    private weak var controller:CSave?
    
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
        
        factoryGif(sequence:sequence, path:path)
    }
    
    private func savingError()
    {
        let message:String = String.localizedModel(
            key:"MSave_errorMessage")
        VAlert.messageFail(message:message)
        
        controller?.done()
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
}
