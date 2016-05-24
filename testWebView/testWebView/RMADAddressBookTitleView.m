//
//  RMADAddressBookTitleView.m
//  testWebView
//
//  Created by Robert on 15/11/6.
//  Copyright © 2015年 NationSky. All rights reserved.
//

#import "RMADAddressBookTitleView.h"

@interface RMADAddressBookTitleView ()

@end

@implementation RMADAddressBookTitleView

- (void)addButton {
    if (self.titles.count != 0 && self.images.count != 0) {
        
        CGFloat buttonWidth = self.bounds.size.width / self.titles.count;
        CGFloat buttonHeight = self.bounds.size.height;
        
        for (int i = 0; i < self.titles.count; i++) {
            
            NSString *title = self.titles[i];
            NSString *image = self.images[i];
            NSString *selectedImage = self.selectedImages[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(0 + i * buttonWidth, 0, buttonWidth, buttonHeight);
//            [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [self addSubview:button];
        }
        
    }
}

- (void)tapButton:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(RMADAddressBookTitleView:didTapButtonIndex:)]) {
        [self.delegate RMADAddressBookTitleView:self didTapButtonIndex:btn.tag];
    }
}

- (void)drawRect:(CGRect)rect {
//    self.backgroundColor = [UIColor redColor];
    [self addButton];
}

@end
