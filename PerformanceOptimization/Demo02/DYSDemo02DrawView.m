//
//  DYSDemo02DrawView.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//

/**
 越画越多，则性能消耗越严重。可以看工程内截图。
 这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。
 */
#import "DYSDemo02DrawView.h"

@interface DYSDemo02DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DYSDemo02DrawView

- (void)yyi_init {
    _path = [UIBezierPath bezierPath];
    _path.lineWidth = 5;
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
    [[UIColor lightGrayColor] setFill];
    UIRectFill(rect);

    [[UIColor whiteColor] setFill];
    [[UIColor redColor] setStroke];

    [self.path stroke];    
}


@end
