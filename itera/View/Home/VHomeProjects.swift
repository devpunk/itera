import UIKit

class VHomeProjects:VCollection<
    VHome,
    MHome,
    CHome,
    VHomeProjectsCell>
{
    private var edgeInsets:UIEdgeInsets?
    private var cellSizeSelected:CGSize?
    private var cellSize:CGSize?
    private var trackScroll:Bool
    private let kCollectionTop:CGFloat = 255
    private let kCollectionBottom:CGFloat = 55
    private let kInterItem:CGFloat = 5
    private let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:CHome)
    {
        trackScroll = true
        
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        
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
            
            makeSelection(index:indexPath)
        }
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
            let width_selected:CGFloat = width - VHomeCard.kWidth
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
        makeScroll(index:indexPath)
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
            
            updateCard()
        }
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
    
    private func makeSelection(index:IndexPath)
    {
        let newSelected:Int = index.item
        
        if controller.model.selected != newSelected
        {
            controller.model.selected = index.item
            collectionView.selectItem(
                at:index,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
            animateLayout(selected:index)
            updateCard()
        }
    }
    
    private func makeScroll(index:IndexPath)
    {
        controller.model.selected = index.item
        animateLayout(selected:index)
        updateCard()
    }
    
    private func centerSelected(index:IndexPath)
    {
        collectionView.scrollToItem(
            at:index,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
    
    private func updateCard()
    {
        guard
        
            let view:VHome = controller.view as? VHome
        
        else
        {
            return
        }
        
        view.updateCard()
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
        selectCurrent()
    }
}
