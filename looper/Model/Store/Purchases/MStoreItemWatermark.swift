import UIKit

class MStoreItemWatermark:MStoreItem
{
    private let kStorePurchaseId:MStore.PurchaseId = "iturbide.looper.watermark"
    
    override init()
    {
        let title:String = NSLocalizedString("MStoreItemPlus_title", comment:"")
        let descr:String = NSLocalizedString("MStoreItemPlus_descr", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetGenericPlus")
        
        super.init(
            purchaseId:kStorePurchaseId,
            title:title,
            descr:descr,
            image:image)
    }
    
    override init(
        purchaseId:MStore.PurchaseId,
        title:String,
        descr:String,
        image:UIImage)
    {
        fatalError()
    }
    
    override func purchaseAction()
    {
        MSession.sharedInstance.settings?.hyperboreaPlus = true
        DManager.sharedInstance.save()
        let _:Bool = MSession.sharedInstance.froobValidate()
    }
    
    override func validatePurchase() -> Bool
    {
        var isPurchased:Bool = false
        
        guard
            
            let plus:Bool = MSession.sharedInstance.settings?.hyperboreaPlus
            
            else
        {
            return isPurchased
        }
        
        isPurchased = plus
        
        return isPurchased
    }
}
