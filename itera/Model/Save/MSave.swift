import Foundation

class MSave:Model
{
    private(set) var sequence:MEditSequence?
    
    //MARK: public
    
    func config(sequence:MEditSequence)
    {
        self.sequence = sequence
    }
}
