//
//  FlickrPhotosWithTagTVC.m
//  SPoT
//
//  Created by Michael Sena on 2/20/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import "FlickrPhotosWithTagTVC.h"
#import "FlickrFetcher.h"

@interface FlickrPhotosWithTagTVC ()

@end

@implementation FlickrPhotosWithTagTVC

- (void)setTag:(NSString *)tag
{
    _tag = tag;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.tag = @"classroom";
    
    NSMutableArray *photosWithTag = [[NSMutableArray alloc] init];

    
    for (NSDictionary *photo in [FlickrFetcher stanfordPhotos])
    {
        for (NSString *tag in [[[photo objectForKey:FLICKR_TAGS] description] componentsSeparatedByString:@" "])
        {
            if ([tag isEqualToString:self.tag]) {
                [photosWithTag addObject:photo];
            }
        }
    }
    
	self.photos = photosWithTag;
    
}

@end
