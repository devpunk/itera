import UIKit

class VHomeProjects:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeProjectsCell>
{
    private let kCollectionTop:CGFloat = 200
    private let kCellSize:CGFloat = 70
    private let kInterItem:CGFloat = 5
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
            flow.itemSize = CGSize(
                width:kCellSize,
                height:kCellSize)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let height:CGFloat = collectionView.bounds.height
        let cellTop:CGFloat = kCellSize + kCollectionTop
        let remainHeight:CGFloat = height - cellTop
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:remainHeight,
            right:0)
        
        return insets
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let cell:VHomeProjectsCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeItem
    {
        let item:MHomeItem = controller.model.items[index.item]
        
        return item
    }
}
