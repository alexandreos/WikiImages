//
//  VCHome.swift
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

import UIKit
import WikiAPI
import IDMPhotoBrowser

class VCHome: UICollectionViewController {

    private var refreshControl: UIRefreshControl!
    private var dataSource = ArticlesCollectionViewDataSource(articles: WikiAPIClient.storedArticlesFromYesterday() ?? [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Yesterday's Top Article Images"

        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.blackColor()
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: .ValueChanged)
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.addSubview(self.refreshControl)
        
        self.collectionView?.dataSource = self.dataSource
        
        if self.dataSource.articles.count == 0 {
            self.refreshControl?.beginRefreshing()
            self.refreshData()
        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Present image browser
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ArticleCollectionViewCell
        let article = self.dataSource.articles[indexPath.section]
        let photos = article.pages.map { DataHelper.convertWikiImageIntoIDMPhoto($0.image) }
        let photoBrowser = IDMPhotoBrowser(photos: photos, animatedFromView: cell.imageView)
        photoBrowser.view.tintColor = UIColor.whiteColor()
        photoBrowser.setInitialPageIndex(UInt(indexPath.item))
        self.presentViewController(photoBrowser, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        let article = self.dataSource.articles[indexPath.section]
        if !article.isExpanding && !article.hasLoaded {
            // Load Expanded information about the article
            WikiAPIClient.expandArticle(article){ (expandedArticle, error) -> Void in
                guard let expandedArticle = expandedArticle else {
                    print("Oops, something went wrong: \(error)")
                    return
                }
                self.dataSource.articles[indexPath.section] = expandedArticle
                collectionView.reloadSections(NSIndexSet(index: indexPath.section))
            }
        }
    }
    
    // MARK: - Private Methods
    
    func refreshData() {
        WikiAPIClient.topArticlesFromYesterdayWithCompletionHandler { (articles, error) -> Void in
            self.refreshControl?.endRefreshing()
            guard let articles = articles else {
                // Some error happened
                print("Error: \(error)")
                return
            }
            
            self.dataSource.articles = articles
            self.collectionView?.reloadData()
        }
    }

}
