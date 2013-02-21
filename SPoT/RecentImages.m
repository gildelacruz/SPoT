//
//  RecentImages.m
//  SPoT
//
//  Created by Michael Sena on 2/21/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import "RecentImages.h"
#import "FlickrFetcher.h"

#define RECENT_IMAGES_KEY @"Recent_Images"
#define FLICKR_LAST_VIEWED_KEY @"Last_viewed"
#define MAX_RECENT_IMAGES 15

@implementation RecentImages

// Add an object to recent images in NSUserDefaults
// If exists already in the list, then make it most recent
// else, remove oldest
+(void)addImage:(NSDictionary *)image
{
    NSMutableDictionary *mutableImage = [image mutableCopy];
    NSMutableArray *recentImages = [[self getImages] mutableCopy];
    BOOL foundImageInRecentImages = NO;
    
    mutableImage[FLICKR_LAST_VIEWED_KEY] = [NSDate date];
    for (NSDictionary *recentImage in recentImages) {
        if ([recentImage[FLICKR_PHOTO_ID] isEqualToString:mutableImage[FLICKR_PHOTO_ID]]) {
            foundImageInRecentImages = YES;
            [recentImages removeObject:recentImage];
            break;
        }
    }
    if (!foundImageInRecentImages) {
        if ([recentImages count] > MAX_RECENT_IMAGES - 1) {
            [recentImages removeLastObject];
        }
    }
    
    [recentImages insertObject:[mutableImage copy]
                       atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:recentImages
                                              forKey:RECENT_IMAGES_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

+ (NSArray *)getImages
{
    NSArray *recentImages = [[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_IMAGES_KEY];
    if (!recentImages) {
        NSArray *newRecentImages = [[NSArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:recentImages
                                                  forKey:RECENT_IMAGES_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        recentImages = newRecentImages;
    }
    
    NSMutableArray *sortedRecentImages = [[self sortArrayOfDictionaries:recentImages
                                                               usingKey:FLICKR_LAST_VIEWED_KEY
                                                              ascending:NO] mutableCopy];
    while ([sortedRecentImages count] > MAX_RECENT_IMAGES) {
        [sortedRecentImages removeLastObject];
    }
    return [sortedRecentImages copy];
}


+ (NSArray *)sortArrayOfDictionaries:(NSArray *)array
                            usingKey:(NSString *)key
                           ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                                   ascending:ascending];
    return [array sortedArrayUsingDescriptors:@[sortDescriptor]];
}

@end
