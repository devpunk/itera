import Foundation

class MHome:Model
{
    var selected:Int
    private(set) var items:[MHomeItem]
    
    required init()
    {
        selected = 0
        items = []
        
        super.init()
    }
    
    //MARK: public
    
    func itemsLoaded(items:[MHomeItem])
    {
        self.items = items
        selected = 0
        delegate?.modelRefresh()
    }
}
