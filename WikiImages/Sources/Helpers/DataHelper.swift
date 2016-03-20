//
//  DataHelper.swift
//  WikiImages
//
//  Created by Alexandre Santos on 20/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

import WikiAPI
import IDMPhotoBrowser

struct DataHelper {
    
    static func convertWikiImageIntoIDMPhoto(image:WikiImage) -> IDMPhoto {
        let photo = IDMPhoto(URL: image.url)
        photo.caption = image.descriptionText
        return photo
    }
    
    static func convertPagesIntoIDMPhotos(pages: RLMArray) -> [IDMPhoto] {
        var photos = [IDMPhoto]()
        for i in 0...pages.count-1 {
            if let item = pages.objectAtIndex(i) as? WikiPage {
                let photo = DataHelper.convertWikiImageIntoIDMPhoto(item.image)
                photos.append(photo)
            }
        }
        return photos
    }
}