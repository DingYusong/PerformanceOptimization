//
//  DYSDemo02DrawView2.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//
/**
 用CAShapeLayer替代Core Graphics，性能就会得到提高（见清单13.2）.虽然随着路径复杂性的增加，绘制性能依然会下降，但是只有当非常非常浮躁的绘制时才会感到明显的帧率差异。
 */
#import "DYSDemo02DrawView2.h"

@interface DYSDemo02DrawView2 ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DYSDemo02DrawView2

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)yyi_init {
    _path = [UIBezierPath bezierPath];
    _path.lineWidth = 5;
    
    //configure the layer
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
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
    
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
//    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [[UIColor lightGrayColor] setFill];
//    UIRectFill(rect);
//
//    [[UIColor whiteColor] setFill];
//    [[UIColor redColor] setStroke];
//
//    [self.path stroke];
//}

@end
