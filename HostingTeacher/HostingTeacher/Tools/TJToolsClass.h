//
//  TJToolsClass.h
//  CJGDShop
//
//  Created by ZQY on 16/11/23.
//  Copyright © 2016年 ZQY. All rights reserved.
//
/**
 工具类
 */
#import <Foundation/Foundation.h>
@interface TJToolsClass : NSObject

/**
 <#Description#>

 @return 返回默认图片
 */
+(UIImage *)getPlaceholderImage;

//返回默认头像图片
+(UIImage *)getHeaderPlaceholderImage;

/**
 <#Description#>

 @param string <#str description#>
 @param font <#font description#>
 @param width <#white description#>
 @return 返回一段文字的size
 */
+(CGSize)getTextSize:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width;
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;
//date转为日期格式
+(NSString *)dateChangeToStringformat:(NSDate *)date withFormatter:(NSString *)formatter;
@end
