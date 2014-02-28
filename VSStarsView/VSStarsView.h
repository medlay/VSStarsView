//
//  VSStars.h
//
//  Created by Vasyl Skrypii on 02.10.13.

#import <UIKit/UIKit.h>

@interface VSStarsView : UIView

@property (nonatomic) float         value; //Number of the filled stars. Approximation for the fractional number.
@property (nonatomic) int           starsCount;
@property (nonatomic) int           raysCount;
@property (nonatomic) float         starsDistanceFactor;
@property (nonatomic) UIColor       *color;

@end
