//
//  FlickStanfordTagsTVC.m
//  SPoT
//
//  Created by Michael Sena on 2/20/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import "FlickStanfordTagsTVC.h"
#import "FlickrFetcher.h"

@interface FlickStanfordTagsTVC ()

@end

@implementation FlickStanfordTagsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSCountedSet *countedTags = [[NSCountedSet alloc] init];
    NSMutableArray *tagList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photo in [FlickrFetcher stanfordPhotos])
    {
        for (NSString *tag in [[[photo objectForKey:FLICKR_TAGS] description] componentsSeparatedByString:@" "])
        {
            [countedTags addObject:tag];
        }
    }
    for (NSString *tag in countedTags)
    {
        NSNumber *count = [[NSNumber alloc] initWithUnsignedLong:[countedTags countForObject:tag]];
        NSDictionary *tagWCount = @{ @"title": tag,
                                     @"count": count };
        if (![tagWCount[@"title"] isEqualToString:@"cs193pspot"] &&
            ![tagWCount[@"title"] isEqualToString:@"portrait"] &&
            ![tagWCount[@"title"] isEqualToString:@"landscape"])
        {
            [tagList addObject:tagWCount];
        }
    }

    self.tags = tagList;
}

@end
