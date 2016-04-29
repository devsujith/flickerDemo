//
//  PhotoDetailViewController.h
//  flickerDemo
//
//  Created by Sujith Chandran on 29/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoDetailViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic) NSMutableArray *photos;
@property(strong,nonatomic) NSIndexPath *selectedIndex;

@end
