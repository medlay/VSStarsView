//
//  VSStars.m
//
//  Created by Vasyl Skrypii on 02.16.13.

#import "VSStarsView.h"

static int kDefaultRaysCount = 5;
static float kDefaultStarsDistanceFactor = 6.0;

@interface VSStarsView (){
    float starWidht;
    float externalStarWidth;
    float xCenter;
}

- (void)drawStarAtIndex:(NSUInteger)index inContext:(CGContextRef)context;

@end

@implementation VSStarsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    if (_value > _starsCount) _value = _starsCount;
    if (_raysCount == 0) _raysCount = kDefaultRaysCount;
    if (_starsDistanceFactor == 0) _starsDistanceFactor = kDefaultStarsDistanceFactor;

    starWidht = self.frame.size.width / (_starsCount * _starsDistanceFactor);
    externalStarWidth = M_E * starWidht;
    xCenter = starWidht * (_starsDistanceFactor / 2);
    
    for (NSUInteger i = 0; i < _value; i++)
    {
        [self drawStarAtIndex:i inContext:context];
    }
    
    starWidht *= 0.9;
    externalStarWidth *=0.9;
    
    for (NSUInteger i = _value; i < _starsCount; i++)
    {
        [self drawStarAtIndex:i inContext:context];
    }
}


- (void)drawStarAtIndex:(NSUInteger)i inContext:(CGContextRef)context{
    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextSetStrokeColorWithColor(context, _color.CGColor);
    
    CGContextMoveToPoint(context,
                         xCenter + (externalStarWidth * sin(M_PI / _raysCount * (_raysCount * 2 + 1))),
                         self.frame.size.height / 2 + (externalStarWidth * cos(M_PI / _raysCount * (_raysCount * 2 + 1))));
    
    float alpha = (2 * M_PI) / (2 * _raysCount);
    
    for(int i = 2 * _raysCount + 1; i != 0; i--)
    {
        float radius = i % 2 == 1 ? externalStarWidth : starWidht;
        float omega = alpha * i;
        CGContextAddLineToPoint(context, xCenter + (radius * sin(omega)), self.frame.size.height / 2 + (radius * cos(omega)));
    }
    
    xCenter += _starsDistanceFactor * self.frame.size.width / (_starsCount * _starsDistanceFactor);
    
    CGContextClosePath(context);
    if ((int)_value > i)
        CGContextFillPath(context);
    CGContextStrokePath(context);
}

#pragma mark Setters

- (void)setValue:(float)value{
    _value = value;
    [self setNeedsDisplay];
}

-(void)setStarsCount:(int)starsCount{
    _starsCount = starsCount;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setRaysCount:(int)raysCount{
    _raysCount = raysCount;
    [self setNeedsDisplay];
}


@end
