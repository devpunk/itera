import UIKit

class VHomeProjects:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeProjectsCell>
{
    private var cellSizeSelected:CGSize?
    private var cellSize:CGSize?
    private var trackScroll:Bool
    private let kCollectionTop:CGFloat = 20
    private let kCollectionBottom:CGFloat = 20
    private let kInterItem:CGFloat = 5
    private let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:CHome)
    {
        trackScroll = true
        
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
    
    override func scrollViewWillBeginDragging(
        _ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    override func scrollViewDidEndScrollingAnimation(
        _ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        if trackScroll
        {
            let midX:CGFloat = collectionView.bounds.midX
            let point:CGPoint = CGPoint(x:midX, y:kCollectionTop)
            
            guard
                
                let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
                
            else
            {
                return
            }
            
            controller.model.selected = indexPath.item
            collectionView.selectItem(
                at:indexPath,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            animateLayout(selected:indexPath)
        }
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.width
        let width_selected:CGFloat = width - VHomeCard.kWidth
        let horizontalMargin:CGFloat = width_selected / 2.0
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:kCollectionTop,
            left:horizontalMargin,
            bottom:kCollectionBottom,
            right:horizontalMargin)
        
        return insets
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:Int = indexPath.item
        
        if item == controller.model.selected
        {
            guard
                
                let cellSizeSelected:CGSize = self.cellSizeSelected
            
            else
            {
                let height:CGFloat = collectionView.bounds.height
                let verticalMargin:CGFloat = kCollectionTop + kCollectionBottom
                let usableHeight:CGFloat = height - verticalMargin
                let cellSizeSelected:CGSize = CGSize(
                    width:VHomeCard.kWidth,
                    height:usableHeight)
                self.cellSizeSelected = cellSizeSelected
                
                return cellSizeSelected
            }
            
            return cellSizeSelected
        }
        else
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
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        if indexPath.item == controller.model.selected
        {
            return false
        }
        
        return true
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        if indexPath.item == controller.model.selected
        {
            return false
        }
        
        return true
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        trackScroll = false
        controller.model.selected = indexPath.item
        animateLayout(selected:indexPath)
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
    
    private func animateLayout(selected:IndexPath)
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.collectionView.collectionViewLayout.invalidateLayout()
        })
        { [weak self] (done:Bool) in
        
            self?.collectionView.scrollToItem(
                at:selected,
                at:UICollectionViewScrollPosition.centeredHorizontally,
                animated:true)
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
        selectCurrent()
    }
}
