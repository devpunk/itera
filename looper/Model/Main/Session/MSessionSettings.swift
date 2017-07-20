import Foundation

extension MSession
{
    //MARK: private
    
    private func asyncLoadSession()
    {
        DManager.sharedInstance?.fetchData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data?.first as? DSettings
            
            else
            {
                self.createSession()
                
                return
            }
            
            settings.addTtl()
            
            self.settingsLoaded(settings:settings)
        }
    }
    
    private func createSession()
    {
        DManager.sharedInstance?.createData(
            entityName:DSettings.entityName)
        { (data) in
            
            guard
            
                let settings:DSettings = data as? DSettings
            
            else
            {
                return
            }
            
            self.settingsLoaded(settings:settings)
        }
    }
    
    
    
    private func shouldAddThumbnail(
        thumbnail:MPerkThumbnailProtocol,
        perks:[DPerk]) -> Bool
    {
        let identifier:String = thumbnail.identifier()
        
        for perk:DPerk in perks
        {
            if perk.identifier == identifier
            {
                return false
            }
        }
        
        return true
    }
    
    private func addPerk(perk:MPerkProtocol, dispatchGroup:DispatchGroup)
    {
        if let perkFree:MPerkFreeProtocol = perk as? MPerkFreeProtocol
        {
            addPerkFree(perk:perkFree, dispatchGroup:dispatchGroup)
        }
        else if let perkPurchase:MPerkPurchaseProtocol = perk as? MPerkPurchaseProtocol
        {
            addPerkPurchase(perk:perkPurchase, dispatchGroup:dispatchGroup)
        }
    }
    
    private func addPerkFree(perk:MPerkFreeProtocol, dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let optionsClass:String = optionsClassFor(perk:perk)
        
        DManager.sharedInstance?.createData(
            entityName:DOptionFree.entityName)
        { (data) in
            
            guard
            
                let option:DOptionFree = data as? DOptionFree
            
            else
            {
                return
            }
            
            option.gameId = perk.gameId
            option.optionsClass = optionsClass
            option.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
    
    private func addPerkPurchase(perk:MPerkPurchaseProtocol, dispatchGroup:DispatchGroup)
    {
        dispatchGroup.enter()
        
        let optionsClass:String = optionsClassFor(perk:perk)
        
        DManager.sharedInstance?.createData(
            entityName:DOptionPurchase.entityName)
        { (data) in
            
            guard
                
                let option:DOptionPurchase = data as? DOptionPurchase
                
            else
            {
                return
            }
            
            option.gameId = perk.gameId
            option.optionsClass = optionsClass
            option.purchaseId = perk.purchaseId
            option.settings = self.settings
            
            dispatchGroup.leave()
        }
    }
    
    private func optionsClassFor(perk:MPerkProtocol) -> String
    {
        let objectClass:AnyClass = object_getClass(perk.optionsClass)
        let classString:String = NSStringFromClass(objectClass)
        
        return classString
    }
    
    private func finishLoadingSession()
    {
        DManager.sharedInstance?.save()
        
        NotificationCenter.default.post(
            name:Notification.sessionLoaded,
            object:nil)
    }
    
    //MARK: public
    
    func loadSession()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncLoadSession()
        }
    }
}
