import Foundation

class MHome:Model
{
    private(set) var items:[MHomeItem]
    
    required init()
    {
        items = []
        
        super.init()
    }
}
