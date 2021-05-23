//
//  CalculatorView.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import UIKit

class CalculatorView: BaseView, CustomMenuBarDelegate {
    
    //MARK: Outltes
    var pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var customMenuBar = CustomMenuBar()

    
    //MARK: Setup view
    func setupCustomTabBar(){
        self.addSubview(customMenuBar)
        customMenuBar.delegate = self
        customMenuBar.translatesAutoresizingMaskIntoConstraints = false
        customMenuBar.indicatorViewWidthConstraint.constant = self.frame.width / 5
        customMenuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        customMenuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        customMenuBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        customMenuBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.backgroundColor = .gray
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(UINib(nibName: PageCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: PageCell.reusableIdentifier)
        pageCollectionView.register(UINib(nibName: ProfitrateCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: ProfitrateCell.reusableIdentifier)
        self.addSubview(pageCollectionView)
        pageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.customMenuBar.bottomAnchor).isActive = true
    }
    
    override func setup() {
        self.backgroundColor = .white
        setupCustomTabBar()
        setupPageCollectionView()
    }
    
    override func bindConstraints() {
        
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension CalculatorView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfitrateCell.reusableIdentifier, for: indexPath) as! ProfitrateCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell
            cell.label.text = "\(indexPath.row + 1)번째 뷰"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 5
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension CalculatorView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
