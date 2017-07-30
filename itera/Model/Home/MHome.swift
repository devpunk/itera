import Foundation

class MHome:Model
{
    private(set) var items:[MHomeItem]
    
    required init()
    {
        items = []
        
        super.init()
    }
    
    //MARK: public
    
    func itemsLoaded(items:[MHomeItem])
    {
        self.items = items
        delegate?.modelRefresh()
    }
}
