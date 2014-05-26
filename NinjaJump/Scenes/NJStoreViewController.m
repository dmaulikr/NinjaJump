//
//  NJStoreView.m
//  NinjaJump
//
//  Created by Wang Kunzhen on 25/5/14.
//  Copyright (c) 2014 Wang Kunzhen. All rights reserved.
//

#import "NJStoreViewController.h"

@interface NJStoreViewController ()
@property NSMutableArray *data;
@property NJStore *store;
@end

@implementation NJStoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self addGestureRecognizers];
    _data = [NSMutableArray array];
    [_data addObject:@"shuriken"];
    [_data addObject:@"mine"];
    [_data addObject:@"fireScroll"];
    [_data addObject:@"thunderScroll"];
    [_data addObject:@"windScroll"];
    [_data addObject:@"medikit"];
    [_data addObject:@"iceScroll"];
}

- (void)addGestureRecognizers
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapHandler
{
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Item" forIndexPath:indexPath];
    UIImageView *view = (UIImageView *)[cell viewWithTag:100];
    view.image = [UIImage imageNamed:[_data objectAtIndex:indexPath.row]];
    view.layer.cornerRadius = 50.0f;
    view.layer.borderWidth = 2.0f;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    
    return cell;
}

@end