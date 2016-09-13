//
//  BaseView.m
//  MicroDriver
//
//  Created by Chen on 14-8-22.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) loadXIB
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    UIView *view = [views lastObject];
    view.tag = VIEW_TAG;
    
    
    [view setFrame:self.bounds];
    
    NSLog(@"loadXIB self frame = %@",NSStringFromCGRect(self.bounds));

    [self addSubview:view];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
