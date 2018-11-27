//
//  NetworkRequestManager.m
//  FunacademyEducation
//
//  Created by 清 on 2018/11/13.
//  Copyright © 2018 清. All rights reserved.
//

#import "NetworkRequestManager.h"

@interface NetworkRequestManager ()
@property (nonatomic,copy) ResponseSuccess success;
@property (nonatomic,copy) ResponseFailure failure;
@end

@implementation NetworkRequestManager

+(instancetype)manager{
    NetworkRequestManager * manager = [[NetworkRequestManager alloc]init];
    return manager;
}
+(AFHTTPSessionManager *)sessionManager{
    
    static AFHTTPSessionManager * sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer.timeoutInterval = 10;
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    });
    return sessionManager;
}
-(void)POST_URL_HttpHeader:(NSString *)header url:(NSString *)url params:(NSMutableDictionary *)params withLoading:(BOOL)isLoading isFailureAlter:(BOOL)isAlter successBlock:(ResponseSuccess)success failureBlock:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    [params setValue:@"ios_zarten" forKey:@"ComeFrom"];
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    NSLog(@"--url--->%@",[NSString stringWithFormat:@"%@%@",header,url]);
    NSLog(@"--params-->%@",params);
    [session POST:[NSString stringWithFormat:@"%@%@",header,url] parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----success--->%@",responseObject);
        BOOL isOk = NO;
        if (responseObject) {
            NSString * result = responseObject[@"result"];
            if ([result isEqualToString:@"success"]) {
                isOk = YES;
            }
        }
        if (isOk == YES) {
            success(task,responseObject);
        }else{
            NSString * message = @"";
            if (responseObject[@"message"]) {
                message = responseObject[@"message"];
            }
            failure(task,message,nil);
            if (isAlter == YES) {
                [LoadDataSuggest showFailWith:message];
            }
        }
        
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----->>error--->%@",error);
        failure(task,@"",error);
        [laoding loadingDisappear];
        if (isAlter == YES) {
            [LoadDataSuggest showFailWith:@"网络错误"];
        }
    }];
}

-(void)GET_URL_HttpHeader:(NSString *)header url:(NSString *)url withLoading:(BOOL)isLoading isFailureAlter:(BOOL)isAlter successBlock:(ResponseSuccess)success failureBlock:(ResponseFailure)failure{
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    [session GET:[NSString stringWithFormat:@"%@%@",header,url] parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----success--->%@",responseObject);
        BOOL isOk = NO;
        if (responseObject) {
            NSString * result = responseObject[@"result"];
            if ([result isEqualToString:@"success"]) {
                isOk = YES;
            }
        }
        if (isOk == YES) {
            success(task,responseObject);
        }else{
            NSString * message = @"";
            if (responseObject[@"message"]) {
                message = responseObject[@"message"];
            }
            failure(task,message,nil);
            if (isAlter == YES) {
                [LoadDataSuggest showFailWith:message];
            }
        }
        
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----->>error--->%@",error);
        failure(task,@"",error);
        [laoding loadingDisappear];
        if (isAlter == YES) {
            [LoadDataSuggest showFailWith:@"网络错误"];
        }
    }];
}

-(void)POST_IMAGEURL_HttpHeader:(NSString *)header url:(NSString *)url params:(NSMutableDictionary *)params  imageArry:(nullable NSArray *)imageArray withLoading:(BOOL)isLoading isFailureAlter:(BOOL)isAlter success:(_Nullable ResponseSuccess)success failure:(_Nullable ResponseFailure)failure{
    
    TJLoading * laoding;
    if (isLoading) {
        laoding = [TJLoading LoadingAppear];
    }
    [params setValue:@"ios_zarten" forKey:@"ComeFrom"];
    AFHTTPSessionManager * session = [NetworkRequestManager sessionManager];
    NSLog(@"--url--->%@",[NSString stringWithFormat:@"%@%@",header,url]);
    NSLog(@"--params-->%@",params);
    
    [session POST:[NSString stringWithFormat:@"%@%@",header,url] parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageArray.count; i++) {
            UIImage *image = imageArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateString];
            //该方法的参数
             //1. appendPartWithFileData：要上传的照片[二进制流]
             //2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             //3. fileName：要保存在服务器上的文件名
             //4. mimeType：上传的文件的类型
         
            [formData appendPartWithFileData:imageData name:@"File" fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
     
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----success--->%@",responseObject);
        BOOL isOk = NO;
        if (responseObject) {
            NSString * result = responseObject[@"result"];
            if ([result isEqualToString:@"success"]) {
                isOk = YES;
            }
        }
        if (isOk == YES) {
            success(task,responseObject);
        }else{
            NSString * message = @"";
            if (responseObject[@"message"]) {
                message = responseObject[@"message"];
            }
            failure(task,message,nil);
            if (isAlter == YES) {
                [LoadDataSuggest showFailWith:message];
            }
        }
        
        [laoding loadingDisappear];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----->>error--->%@",error);
        failure(task,@"",error);
        [laoding loadingDisappear];
        if (isAlter == YES) {
            [LoadDataSuggest showFailWith:@"网络错误"];
        }
    }];
    
}
@end
