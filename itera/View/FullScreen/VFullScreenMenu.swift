import UIKit

class VFullScreenMenu:VCollection<
    VFullScreen,
    MFullScreen,
    CFullScreen,
    VFullScreenMenuCell>
{
    private var cellSize:CGSize?
    private let kBorderHeight:CGFloat = 1
    private let kCellWidth:CGFloat = 60
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        let border:VBorder = VBorder(colour:UIColor.colourBackgroundDark)
        insertSubview(border, belowSubview:collectionView)

        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
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
        let countCells:CGFloat = CGFloat(controller.model.menu.count)
        let cellsWidth:CGFloat = countCells * kCellWidth
        let remainWidth:CGFloat = width - cellsWidth
        let marginHorizontal:CGFloat = remainWidth / 2.0
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:marginHorizontal,
            bottom:0,
            right:marginHorizontal)
        
        return insets
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
            let cellSize:CGSize = CGSize(width:kCellWidth, height:height)
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
        let item:MHomeItem = controller.model.item
        let model:MFullScreenProtocol = modelAtIndex(index:indexPath)
        let cell:VFullScreenMenuCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:model, item:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        super.collectionView(
            collectionView,
            didSelectItemAt:indexPath)
        let item:MFullScreenProtocol = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MFullScreenProtocol
    {
        let item:MFullScreenProtocol = controller.model.menu[index.item]
        
        return item
    }
}
