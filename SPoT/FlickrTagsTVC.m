//
//  FlickrTagTVC.m
//  SPoT
//
//  Created by Michael Sena on 2/20/13.
//  Copyright (c) 2013 seaDevelopment. All rights reserved.
//

#import "FlickrTagsTVC.h"
#import "FlickrFetcher.h"

@interface FlickrTagsTVC ()

@end

@implementation FlickrTagsTVC
@synthesize tags = _tags;
- (void)setTags:(NSArray *)tags
{
    _tags = tags;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Select Tag"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setTag:)]) {
                    NSString *tag = [self.tags objectAtIndex:indexPath.row][@"title"];
                    [segue.destinationViewController performSelector:@selector(setTag:) withObject:tag];
                    [segue.destinationViewController setTitle:[self tagTitleForRow:indexPath.row]];
                }
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (NSString *)tagTitleForRow:(NSUInteger)row
{
    return [[self.tags[row][@"title"] description] capitalizedString];
}

- (NSString *)tagSubTitleForRow:(NSUInteger)row
{
    return [self.tags[row][@"count"] description];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Tag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self tagTitleForRow:indexPath.row];
    cell.detailTextLabel.text = [self tagSubTitleForRow:indexPath.row];
    
    return cell;
}

@end
