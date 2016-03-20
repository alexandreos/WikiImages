//
//  WikiImage.m
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

#import "WikiImage.h"

@implementation WikiImage
@synthesize url = _url;

/*
 {
 "url": "https://upload.wikimedia.org/wikipedia/commons/f/f8/Jon_Bernthal_2014.jpg",
 "descriptionurl": "https://commons.wikimedia.org/wiki/File:Jon_Bernthal_2014.jpg",
 "descriptionshorturl": "https://commons.wikimedia.org/w/index.php?curid=37669186",
 "extmetadata": {
 "DateTime": {
 "value": "2015-01-04 14:42:24",
 "source": "mediawiki-metadata",
 "hidden": ""
 },
 "ObjectName": {
 "value": "Jon Bernthal 2014",
 "source": "mediawiki-metadata",
 "hidden": ""
 },
 "CommonsMetadataExtension": {
 "value": 1.2,
 "source": "extension",
 "hidden": ""
 },
 "Categories": {
 "value": "Extracted images|Flickr images reviewed by trusted users|Fury (2014 film)|Jon Bernthal",
 "source": "commons-categories",
 "hidden": ""
 },
 "Assessments": {
 "value": "",
 "source": "commons-categories",
 "hidden": ""
 },
 "ImageDescription": {
 "value": "Actor Jon Bernthal, who plays the part of \u201cCoon-Ass/Grady Travis, gives interviews with the media on the \u201cRed Carpet\u201d during the world premiere of the movie Fury at the Newseum in Washington D.C. (Department of Defense photo by Marvin Lynchard)",
 "source": "commons-desc-page"
 },
 "DateTimeOriginal": {
 "value": "2014-10-15 17:03",
 "source": "commons-desc-page"
 },
 "Credit": {
 "value": "<a rel=\"nofollow\" class=\"external text\" href=\"https://www.flickr.com/photos/dodnewsfeatures/15408783930/\">141015-D-FW736-071</a>",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "Artist": {
 "value": "<a rel=\"nofollow\" class=\"external text\" href=\"https://www.flickr.com/people/127934495@N07\">DoD News Features</a>",
 "source": "commons-desc-page"
 },
 "LicenseShortName": {
 "value": "CC BY 2.0",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "UsageTerms": {
 "value": "Creative Commons Attribution 2.0",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "AttributionRequired": {
 "value": "true",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "LicenseUrl": {
 "value": "http://creativecommons.org/licenses/by/2.0",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "Copyrighted": {
 "value": "True",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "Restrictions": {
 "value": "",
 "source": "commons-desc-page",
 "hidden": ""
 },
 "License": {
 "value": "cc-by-2.0",
 "source": "commons-templates",
 "hidden": ""
 }
 }
 }
 */
#pragma mark - Mapping

- (void)mapWithDictionary:(NSDictionary *)dictionary {
    self.name = [dictionary valueForKeyPath:@"extmetadata.ObjectName.value"];
    self.urlString = dictionary[@"url"];
    self.descriptionText = [dictionary valueForKeyPath:@"extmetadata.ImageDescription.value"];
}

#pragma mark - Realm

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"url"];
}

#pragma mark - Properties

- (NSURL *)url {
    // Lazy load
    if(_url == nil && self.urlString) {
        _url = [NSURL URLWithString:self.urlString];
    }
    return _url;
}

- (void)setUrlString:(NSString *)urlString {
    if([_urlString isEqualToString:urlString] == NO) {
        _urlString = urlString;
        _url = nil;
    }
}

@end
