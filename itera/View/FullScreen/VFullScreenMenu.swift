import UIKit

class VFullScreenMenu:VCollection<
    VFullScreen,
    MFullScreen,
    CFullScreen,
    VFullScreenMenuCell>
{
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CFullScreen)
    {
        super.init(controller:controller)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        
        let blur:VBlur = VBlur.light()
        
        let border:VBorder = VBorder(colour:UIColor.colourBackgroundGray)
        
        insertSubview(blur, belowSubview:collectionView)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
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
}
