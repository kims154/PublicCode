////
////  BBGRequest.m
////  Common
////
////  Created by Damon on 15/4/7.
////  Copyright (c) 2015年 Bubugao. All rights reserved.
////
//
//#import "BBGRequest.h"
//#import "BBGResponse.h"
//#import "BBGCache.h"
//#import "BBGUserRegion.h"
//#import "JSONKit.h"
//#import "BBGConfiguration.h"
//#import "BBGLoginResponse.h"
//#import "BBGSession.h"
//@interface BBGRequest()
//@end
//
//@implementation BBGRequest
//
//- (id)init {
//    self = [super init];
//    if (self) {
//        self.method = BBGHttpMethodPost;
//        self.responseFormat = ResponseDataFormatJson;
//    }
//    return self;
//}
//
//- (void)sendWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure{
//
//    if (self.method == BBGHttpMethodGet) {
//        __weak BBGRequest * weakSelf = self;
//        
//        
//        self.successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
//            if (operation.response) {
//                [[BBGConfiguration sharedInstance] getTimeDifferenceWithServerTime:operation.response.allHeaderFields[@"Date"]];
//            }
//            
//            __strong BBGRequest * strongSelf = weakSelf;
//
//            Class responseClass = [strongSelf responseClass];
//            if(![responseClass isSubclassOfClass:[BBGResponse class]]){
//                @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为BBGResponse的子类" userInfo:nil];
//            }
//            BBGResponse * response = [[responseClass alloc] initWithData:responseObject format:strongSelf.responseFormat];
//            NSLog(@"response:%@",[response description]);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (success) {
//                    success(operation,response);
//                }
//            });
//        };
//        
//        self.failureBlock = ^(AFHTTPRequestOperation *operation,NSError * error) {
//            __strong BBGRequest * strongSelf = weakSelf;
//
//            if (operation.response) {
//                [[BBGConfiguration sharedInstance] getTimeDifferenceWithServerTime:operation.response.allHeaderFields[@"Date"]];
//            }
//            
//            Class responseClass = [strongSelf responseClass];
//            if(![responseClass isSubclassOfClass:[BBGResponse class]]){
//                @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为BBGResponse的子类" userInfo:nil];
//            }
//            if (operation.responseString) {
//                BBGResponse * response= [[responseClass alloc]initWithData:operation.responseData format:strongSelf.responseFormat];
//                NSLog(@"error:%ld",(long)response.errorCode);
//
//                if (failure) {
//                    failure(operation,response.errorMsg,[NSString stringWithFormat:@"%ld",(long)response.errorCode]);
//                }
//            }else{
//                NSLog(@"连接错误：%@",error);
//            }
//            
//            /*!
//             *  @author Damon, 15-04-07 17:04:38
//             *
//             *  统一处理网络出错
//             */
//        };
//        
//        [super send];
//    }else if (self.method == BBGHttpMethodPost || self.method == BBGHttpUploadFile){
//        __weak BBGRequest * weakSelf = self;
//        
//        self.successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
//            //存储服务器时间
//            if (operation.response) {
//                [[BBGConfiguration sharedInstance] getTimeDifferenceWithServerTime:operation.response.allHeaderFields[@"Date"]];
//            }
//            
//            __strong BBGRequest * strongSelf = weakSelf;
//            
//            Class responseClass = [strongSelf responseClass];
//            if(![responseClass isSubclassOfClass:[BBGResponse class]]){
//                @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为BBGResponse的子类" userInfo:nil];
//            }
//            NSDictionary * dic = responseObject;
//            BBGResponse * response = [[responseClass alloc] initWithData:[dic JSONData] format:strongSelf.responseFormat];
//#ifdef DEBUG
//            NSLog(@"response:%@",[response description]);
//#endif
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (response.isError) {
//                    if([response isKindOfClass:[BBGLoginResponse class]]){
//                        [BBGSession sharedInstance].response = response;
//                    }
//                    if (failure) {
//                        failure(operation,response.errorMsg,[NSString stringWithFormat:@"%ld",(long)response.errorCode]);
//                    }
//                }else{
//                    if (success) {
//                        success(operation,response);
//                    }
//                }
//
//            });
//        };
//        
//        self.failureBlock = ^(AFHTTPRequestOperation *operation,NSError * error) {
//            //存储服务器时间
//            if (operation.response) {
//                [[BBGConfiguration sharedInstance] getTimeDifferenceWithServerTime:operation.response.allHeaderFields[@"Date"]];
//            }
//
//            
//            if (operation.responseString.length > 0) {
//                BBGResponse * response = [[BBGResponse alloc]initWithData:operation.responseData format:ResponseDataFormatJson];
//                NSLog(@"%@",operation.responseString);
//                if (failure) {
//                    failure(operation,response.errorMsg,[NSString stringWithFormat:@"%ld",(long)response.errorCode]);
//                }
//            }else{
//                NSLog(@"连接错误：%@",error);
//            }
//            
//            [[BBGLoadingTips sharedInstance] showTips:@"网络或服务器出错"];
//            /*!
//             *  @author Damon, 15-04-07 17:04:38
//             *
//             *  统一处理网络出错
//             */
//        };
//        
//        [super send];
//    }else{
//        @throw [NSException exceptionWithName:@"参数不正确" reason:@"HTTP方法不能为空" userInfo:nil];
//    }
//}
//
//
//
//- (void)buildParameters:(BBGMutableParameters*)parameters {
//    
//    [super buildParameters:parameters];
//}
//
//- (Class)responseClass {
//    @throw [NSException exceptionWithName:@"方法错误" reason:@"必须实现抽象方法" userInfo:nil];
//}
//
//- (void)successWithOperation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject error:(NSError *)error{
//    
//}
//
//- (void)cancelRequest{
//    [self.manager.operationQueue cancelAllOperations];
//}
//
//- (void)dealloc{
//    
//}
//@end
