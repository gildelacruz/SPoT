//
//  RecentsTVC.m
//  SPoT
//
//  Created by Michael Sena on 2/21/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import "RecentsTVC.h"
#import "RecentImages.h"

@interface RecentsTVC ()

@end

@implementation RecentsTVC

- (void)viewWillAppear:(BOOL)animated
{
    self.photos = [RecentImages getImages];
}
@end
