//
//  ArticlesCollectionViewDataSource.swift
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

import UIKit
import SDWebImage
import WikiAPI

class ArticlesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var articles:[WikiArticle]
    
    static let CellIdentifier = "ArticleCollectionViewCellID"
    static let HeaderIdentifiel = "ArticleCollectionHeaderViewID"
    
    init(articles:[WikiArticle]) {
        self.articles = articles
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.articles.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let article = self.articles[section]
        return Int(article.pages.count)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ArticlesCollectionViewDataSource.HeaderIdentifiel, forIndexPath: indexPath) as? ArticleCollectionHeaderView {
            
            let article = self.articles[indexPath.section]
            view.titleLabel.text = article.title
            view.rankLabel.text = "Rank: \(article.rank)"
            view.viewsLabel.text = "Views: \(article.views)"
            let df = NSDateFormatter()
            df.dateFormat = "yyyy/MM/dd"
            if let date = df.dateFromString(article.date) {
                df.dateStyle = .MediumStyle
                view.dateLabel.text = df.stringFromDate(date)
            }
            else {
                view.dateLabel.text = nil
            }
            
           return view
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ArticlesCollectionViewDataSource.CellIdentifier, forIndexPath: indexPath) as? ArticleCollectionViewCell {
            let article = self.articles[indexPath.section]
            let page = article.pages[indexPath.item]
            cell.nameLabel.text = page.title
            cell.imageView.sd_setImageWithURL(page.image.url, placeholderImage: UIImage(named: "image-placeholder"))
            return cell
        }
        return UICollectionViewCell()
    }
}
