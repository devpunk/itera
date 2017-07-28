import Foundation

class MSave:Model
{
    private(set) var sequence:MEditSequence?
    private let kProjectsFolder:String = "itera"
    
    //MARK: private
    
    private func asyncSave()
    {
        
    }
    
    //MARK: public
    
    func config(sequence:MEditSequence)
    {
        self.sequence = sequence
    }
    
    func save()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
        
            self?.asyncSave()
        }
    }
}
