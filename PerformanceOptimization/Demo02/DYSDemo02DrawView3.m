//
//  DYSDemo02DrawView3.m
//  PerformanceOptimization
//
//  Created by DingYusong on 2018/12/8.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo02DrawView3.h"
#define BRUSH_SIZE 32

@interface DYSDemo02DrawView3 ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DYSDemo02DrawView3

- (void)dys_setUp {
    self.strokes = [NSMutableArray new];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self dys_setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self dys_setUp];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self dys_addBrushWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self dys_addBrushWithPoint:point];
}

- (void)dys_addBrushWithPoint:(CGPoint)point {
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (NSValue *value in self.strokes) {
        CGPoint point = [value CGPointValue];
        
        CGRect imageRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
        
        UIImage *image = [UIImage imageNamed:@"Chalk"];
        
        [image drawInRect:imageRect];
    }
}


@end
