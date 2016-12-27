import UIKit

class VCamera:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCamera!
    private weak var collectionView:VCollection!
    private let kHeaderHeight:CGFloat = 160
    private let kFooterHeight:CGFloat = 60
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    private let kCellHeight:CGFloat = 100
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCamera
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.alwaysBounceVertical = true
        collectionView.registerHeader(header:VCameraHeader.self)
        collectionView.registerFooter(footer:VCameraFooter.self)
        collectionView.registerCell(cell:VCameraCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        addConstraints([
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func refresh()
    {
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let size:CGSize
        
        if controller.model.records.isEmpty
        {
            size = CGSize(width:0, height:kFooterHeight)
        }
        else
        {
            size = CGSize.zero
        }
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.records.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header:VCameraHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VCameraHeader.reusableIdentifier,
                for:indexPath) as! VCameraHeader
            header.config(controller:controller)
            reusable = header
        }
        else
        {
            let footer:VCameraFooter = collectionView.dequeueReusableSupplementaryView(
                ofKind:kind,
                withReuseIdentifier:
                VCameraFooter.reusableIdentifier,
                for:indexPath) as! VCameraFooter
            reusable = footer
        }
        
        return reusable
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VCameraCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraCell.reusableIdentifier,
            for:indexPath) as! VCameraCell
        
        return cell
    }
}