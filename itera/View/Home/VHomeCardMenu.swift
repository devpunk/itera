import UIKit

class VHomeCardMenu:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeCardMenuCell>
{
    private var cellSize:CGSize?
    
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
        guard
        
            let cellSize:CGSize = self.cellSize
        
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let height:CGFloat = collectionView.bounds.height
            let count:CGFloat = CGFloat(controller.model.menu.count)
            let cellWidth:CGFloat = width / count
            let cellSize:CGSize = CGSize(
                width:cellWidth,
                height:height)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
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
        let item:MHomeItem? = controller.model.currentItem()
        let model:MHomeMenuProtocol = modelAtIndex(index:indexPath)
        let cell:VHomeCardMenuCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:model, item:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        super.collectionView(collectionView, didSelectItemAt:indexPath)
        
        let item:MHomeMenuProtocol = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeMenuProtocol
    {
        let item:MHomeMenuProtocol = controller.model.menu[index.item]
        
        return item
    }
}
