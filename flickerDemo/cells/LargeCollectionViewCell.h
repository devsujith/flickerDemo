//
//  LargeCollectionViewCell.h
//  flickerDemo
//
//  Created by Sujith Chandran on 29/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property (strong,nonatomic) UIImageView *imageview;
@property (strong,nonatomic) UIScrollView *scroll;
@property (strong,nonatomic) UILabel *titleLabel;

@end
