import Foundation

class MLoops
{
    var items:[MLoopsItem]
    
    init()
    {
        items = []
    }
    
    //MARK: private
    
    private func asyncLoadFromDb()
    {
        DManager.sharedInstance.fetchManagedObjects(
            entityName:DLoop.entityName)
        { [weak self] (fetched) in
            
            guard
                
                let loops:[DLoop] = fetched as? [DLoop]
                
            else
            {
                self?.items = []
                self?.finishedLoading()
                
                return
            }
            
            var items:[MLoopsItem] = []
            
            for loop:DLoop in loops
            {
                let item:MLoopsItem = MLoopsItem(loop:loop)
                items.append(item)
            }
            
            self?.items = items
            self?.finishedLoading()
        }
    }
    
    private func finishedLoading()
    {
        
    }
    
    //MARK: public
    
    func loadFromDb()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoadFromDb()
        }
    }
}