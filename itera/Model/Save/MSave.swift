import UIKit
import CoreData

class MSave:Model
{
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
        
        scaleSequence(sequence:sequence)
        cropSequence(sequence:sequence)
        rotateSequence(sequence:sequence)
        factoryGif(sequence:sequence, path:path)
    }
    
    private func saveToCD(
        path:URL,
        duration:TimeInterval)
    {
        DManager.sharedInstance?.create(entity:DProject.self)
        { [weak self] (data:NSManagedObject?) in
            
            guard
            
                let project:DProject = data as? DProject
            
            else
            {
                return
            }
            
            project.save(path:path, duration:duration)
            self?.controller?.close()
        }
    }
    
    //MARK: internal
    
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
            
            let path:URL = self.path,
            let duration:TimeInterval = sequence?.duration
        
        else
        {
            controller?.close()
            
            return
        }
        
        saveToCD(path:path, duration:duration)
    }
}
