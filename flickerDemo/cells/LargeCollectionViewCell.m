//
//  LargeCollectionViewCell.m
//  flickerDemo
//
//  Created by Sujith Chandran on 29/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "LargeCollectionViewCell.h"

@implementation LargeCollectionViewCell

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
    
    self.backgroundColor=[UIColor whiteColor];
    //self.clipsToBounds = true;
    
    //scrollView
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scroll.maximumZoomScale = 5.0f;
    self.scroll.delegate = self;
    [self addSubview:self.scroll];
    
    
    
    //imageview
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
    
    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.scroll addSubview:self.imageview];
    
    //patch
    UIView *patchView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
    
    patchView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
    [self addSubview:patchView];
    
    //label
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, self.frame.size.height - 40, self.frame.size.width - 8, 40)];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.minimumScaleFactor = 0.7;
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleTapZoom:)];
    
    tap.numberOfTapsRequired = 2;
   
    tap.delaysTouchesBegan = YES;
    
    [self.scroll addGestureRecognizer:tap];
    
    
    
    
    
}

-(void)toggleTapZoom:(UITapGestureRecognizer *)tap{
    
    //double to zoom
    if (tap.state == UIGestureRecognizerStateEnded)
    {
       
        
    
    if(self.scroll.zoomScale > 1)
    {
        
    
      [self.scroll setZoomScale:1 animated:true];
    }
    else
    {
        CGPoint point = [tap locationInView:self.scroll];
        
        
        
        CGRect rect = CGRectMake(point.x - 5, point.y - 5, 10, 10);
       
        
        
    
        [self.scroll zoomToRect:rect animated:true];
    
    }
        
    }
    
    
    
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{   // simple pinch zoom in scroll view
    return self.imageview;
}

@end
