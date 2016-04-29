//
//  thumbCollectionViewCell.m
//  flickerDemo
//
//  Created by Sujith Chandran on 29/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "thumbCollectionViewCell.h"

@implementation thumbCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.backgroundColor=[UIColor lightGrayColor];
    //self.clipsToBounds = true;
    
    

    // drop shadow for UI
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.6];
    [self.layer setShadowRadius:3.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    //imageview
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageview];
    
    //patch
    UIView *patchView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    
    patchView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    [self addSubview:patchView];
    
    //label
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, self.frame.size.height - 20, self.frame.size.width - 8, 20)];
  
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.minimumScaleFactor = 0.7;
    [self addSubview:self.titleLabel];
    
   
    
    
}
@end
