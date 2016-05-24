//
//  RMADAddressBookTitleView.h
//  testWebView
//
//  Created by Robert on 15/11/6.
//  Copyright © 2015年 NationSky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMADAddressBookTitleView;

@protocol RMADAddressBookTitleViewDelegate <NSObject>

- (void)RMADAddressBookTitleView:(RMADAddressBookTitleView *)RMADAddressBookTitleView didTapButtonIndex:(NSUInteger)index;

@end

@interface RMADAddressBookTitleView : UIView

@property (nonatomic, weak)id<RMADAddressBookTitleViewDelegate>delegate;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) NSArray *selectedImages;

@end
