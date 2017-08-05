import UIKit

class VSourceImageList:VCollection<
    VSourceImage,
    MSourceImage,
    CSourceImage,
    VSourceImageListCell>
{
    private var cellSize:CGSize?
    private let kCellsPerRow:CGFloat = 3
    private let kCollectionMargin:CGFloat = 10
    private let kCollectionBottom:CGFloat = 20
    
    required init(controller:CSourceImage)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            let topMargin:CGFloat = VSourceImage.kBarHeight + kCollectionMargin
            
            flow.minimumLineSpacing = kCollectionMargin
            flow.minimumInteritemSpacing = kCollectionMargin
            flow.sectionInset = UIEdgeInsets(
                top:topMargin,
                left:kCollectionMargin,
                bottom:kCollectionBottom,
                right:kCollectionMargin)
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
            let subtractWidth:CGFloat = (kCellsPerRow + 1) * kCollectionMargin
            let usableWidth:CGFloat = width - subtractWidth
            let cellWidth:CGFloat = usableWidth / kCellsPerRow
            let cellSize:CGSize = CGSize(width:cellWidth, height:cellWidth)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
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
        let item:MSourceImageItem = modelAtIndex(index:indexPath)
        let cell:VSourceImageListCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        guard
        
            let cell:UICollectionViewCell = collectionView.cellForItem(at:indexPath)
        
        else
        {
            return false
        }
        
        if cell.isSelected
        {
            return false
        }
        
        return true
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        controller.model.selectedCount += 1
        let item:MSourceImageItem = modelAtIndex(index:indexPath)
        item.selected(
            selectedIndex:controller.model.selectedCount)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSourceImageItem
    {
        let item:MSourceImageItem = controller.model.items[index.item]
        
        return item
    }
}
