//
//  TJToolsClass.m
//  CJGDShop
//
//  Created by ZQY on 16/11/23.
//  Copyright © 2016年 ZQY. All rights reserved.
//

#import "TJToolsClass.h"

@implementation TJToolsClass
//返回默认图片
+(UIImage *)getPlaceholderImage{
    return [UIImage imageNamed:@""];
}
//返回默认图片
+(UIImage *)getHeaderPlaceholderImage{
    return [UIImage imageNamed:@"lmorentouxiang"];
}
//返回一段文字的size
+(CGSize)getTextSize:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;    
}
// timestamp 时间戳
+ (NSTimeInterval)timestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    return timestamp;
}
//date转为日期格式
+(NSString *)dateChangeToStringformat:(NSDate *)date withFormatter:(NSString *)formatter{
    //yyyy-MM-dd HH:mm:ss
    if (formatter == nil) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}
@end
