//
//  RecentImages.h
//  SPoT
//
//  Created by Michael Sena on 2/21/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RecentImages : NSObject

+ (void)addImage:(NSDictionary *)image;
+ (NSArray *)getImages;

@end
