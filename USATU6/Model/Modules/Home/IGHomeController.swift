//
//  IGHomeController.swift
//  InstagramStories
//
//  Created by Ranjith Kumar on 9/6/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import UIKit

let DEL_CACHE_ENABLED = false

final class IGHomeController: UIViewController {
    
    private var _view: IGHomeView{return view as! IGHomeView}
    private var viewModel: IGHomeViewModel = IGHomeViewModel()
    
    override func loadView() {
        super.loadView()
        view = IGHomeView(frame: UIScreen.main.bounds)
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Private functions
    @objc private func clearImageCache() {
        IGCache.shared.removeAllObjects()
    }

    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension IGHomeController: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGStoryListCell.reuseIdentifier,for: indexPath) as? IGStoryListCell else { fatalError() }
        let story = viewModel.cellForItemAt(indexPath: indexPath)
        cell.story = story
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let stories = self.viewModel.getStories(), let stories_copy = try? stories.copy() {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex:  indexPath.row-1)
                self.present(storyPreviewScene, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == 0 ? CGSize(width: 100, height: 100) : CGSize(width: 80, height: 100)
    }
}
