//
//  DYSDemo02DrawView.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo02DrawView.h"

@interface DYSDemo02DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DYSDemo02DrawView

- (void)yyi_init {
    _path = [UIBezierPath bezierPath];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self yyi_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self yyi_init];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path moveToPoint:point];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path addLineToPoint:point];
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGRect drawRect = CGRectMake(rect.origin.x, rect.origin.y,rect.size.width, rect.size.height);
//
//    CGContextSetRGBFillColor(context, 100.0f/255.0f, 100.0f/255.0f, 100.0f/255.0f, 1.0f);
//    CGContextFillRect(context, drawRect);

    // Drawing code
    [[UIColor blueColor] setFill];  // changes are here
    UIRectFill(rect);               // and here

    
    
    [[UIColor whiteColor] setFill];
    [[UIColor redColor] setStroke];

    [self.path stroke];    
}


@end
