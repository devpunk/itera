import UIKit

class VHomeProjects:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeProjectsCell>
{
    private var edgeInsets:UIEdgeInsets?
    private var cellSize:CGSize?
    private let kCollectionTop:CGFloat = 255
    private let kCollectionBottom:CGFloat = 55
    private let kSubtractSelected:CGFloat = 16
    private let kInterItem:CGFloat = 5
    private let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        collectionView.isUserInteractionEnabled = false
        
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
        guard
            
            let edgeInsets:UIEdgeInsets = self.edgeInsets
            
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let width_selected:CGFloat = width - (VHomeCard.kWidth - kSubtractSelected)
            let horizontalMargin:CGFloat = width_selected / 2.0
            let edgeInsets:UIEdgeInsets = UIEdgeInsets(
                top:kCollectionTop,
                left:horizontalMargin,
                bottom:kCollectionBottom,
                right:horizontalMargin)
            self.edgeInsets = edgeInsets
            
            return edgeInsets
        }
        
        return edgeInsets
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
            let height:CGFloat = collectionView.bounds.height
            let verticalMargin:CGFloat = kCollectionTop + kCollectionBottom
            let usableHeight:CGFloat = height - verticalMargin
            let cellSize:CGSize = CGSize(
                width:VHomeProjectsCell.kImageSize,
                height:usableHeight)
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
    
    private func animateLayout(selected:IndexPath)
    {
        UIView.animate(
            withDuration:0,
            animations:
        { [weak self] in
            
            self?.collectionView.collectionViewLayout.invalidateLayout()
        })
        { [weak self] (done:Bool) in
        
            self?.centerSelected(index:selected)
        }
    }
    
    private func centerSelected(index:IndexPath)
    {
        collectionView.scrollToItem(
            at:index,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
    
    //MARK: internal
    
    func refresh()
    {
        collectionView.reloadData()
        selectCurrent()
    }
    
    func selectCurrent()
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
}
