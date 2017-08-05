import Foundation

class MEdit:Model
{
    let actions:[MEditActionProtocol]
    private(set) var sequence:MEditSequence?
    
    required init()
    {
        actions = MEdit.factoryActions()
        
        super.init()
    }
    
    //MARK: internal
    
    func config(sequence:MEditSequence)
    {
        self.sequence = sequence
    }
}
