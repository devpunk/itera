import UIKit

class VHomeCardMenu:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeCardMenuCell>
{
    private let kCellWidth:CGFloat = 60
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.height
        let size:CGSize = CGSize(
            width:kCellWidth,
            height:height)
        
        return size
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.menu.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeMenuProtocol = modelAtIndex(index:indexPath)
        let cell:VHomeCardMenuCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeMenuProtocol
    {
        let item:MHomeMenuProtocol = controller.model.menu[index.item]
        
        return item
    }
}
