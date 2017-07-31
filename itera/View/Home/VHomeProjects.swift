import UIKit

class VHomeProjects:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeProjectsCell>
{
    private var cellSizeSelected:CGSize
    private var cellSize:CGSize
    private let kCollectionTop:CGFloat = 255
    private let kCellSize:CGFloat = 105
    private let kCellSelectedWidth:CGFloat = 200
    private let kInterItem:CGFloat = 5
    
    required init(controller:CHome)
    {
        cellSizeSelected = CGSize(
            width:kCellSelectedWidth,
            height:kCellSize)
        cellSize = CGSize(
            width:kCellSize,
            height:kCellSize)
        
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumLineSpacing = kInterItem
            flow.minimumInteritemSpacing = kInterItem
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
        let width:CGFloat = collectionView.bounds.width
        let height:CGFloat = collectionView.bounds.height
        let width_selected:CGFloat = width - kCellSelectedWidth
        let horizontalMargin:CGFloat = width_selected / 2.0
        let cellTop:CGFloat = kCellSize + kCollectionTop
        let remainHeight:CGFloat = height - cellTop
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kCollectionTop,
            left:horizontalMargin,
            bottom:remainHeight,
            right:horizontalMargin)
        
        return insets
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:Int = indexPath.item
        let size:CGSize
        
        if item == controller.model.selected
        {
            size = cellSizeSelected
        }
        else
        {
            size = cellSize
        }
        
        return size
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
    
    private func selectCurrent()
    {
        let selected:Int = controller.model.selected
        let count:Int = controller.model.items.count
        
        if selected < count
        {
            let index:IndexPath = IndexPath(
                item:selected,
                section:0)
            
            collectionView.selectItem(
                at:index,
                animated:true,
                scrollPosition:
                UICollectionViewScrollPosition.centeredHorizontally)
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
}
