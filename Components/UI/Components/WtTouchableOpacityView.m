//
//  WtTouchableOpacityView.m
//  WtCore
//
//  Created by wtfan on 2018/6/3.
//

#import "WtTouchableOpacityView.h"


@interface WtTouchableOpacityView ()
@property (nonatomic, assign) CGFloat originAlpha;
@end

@implementation WtTouchableOpacityView
- (instancetype)init {
  if (self = [super init]) {
    [self buildConfigs];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildConfigs];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [self buildConfigs];
}

- (void)buildConfigs {
  _activeOpacity = 0.78;
  _duration = 0.25;
}


- (void)setOpaciyTo:(CGFloat)alpha duration:(CGFloat)duration {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  
  self.alpha = alpha;
  
  [UIView commitAnimations];
}

- (void)opacityActive:(CGFloat)duration {
  [self setOpaciyTo:_activeOpacity duration:duration];
}

- (void)opacityInactive:(CGFloat)duration {
  [self setOpaciyTo:_originAlpha duration:duration];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _originAlpha = self.alpha;
  [super touchesBegan:touches withEvent:event];
  [self opacityActive:_duration];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self opacityInactive:_duration];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self opacityInactive:_duration];
}
@end
