//
//  DCache.h
//  PublicCode
//
//  Created by Damon on 15/5/17.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  缓存类型
 */
typedef enum {
    DCacheTypeNone = 0,
    DCacheTypeAPI,
    DCacheTypeImage,
    DCacheTypeStartupAd,
    DCacheTypeStatistics,
    DCacheTypeTodayLike,
    DCacheTypeRegions,
    DCacheTypeSearchHistory,//搜索历史
    DCacheTypeUserAddressList
} DCacheType;

/*!
 *  缓存策略
 */
@interface DCachePolicy : NSObject<NSCopying>

+(id)cachePolicyWithCacheType:(DCacheType)cacheType;

-(id)initWithCacheType:(DCacheType)cacheType;

/*!
 *  缓存类型
 */
@property(nonatomic, assign) DCacheType cacheType;

/*!
 *  失效日期
 */
@property(nonatomic, strong) NSDate* expDate;

/*!
 *  是否使用文件缓存
 */
@property(nonatomic, assign) BOOL useFileCache;

@end

/*!
 *  缓存管理类
 */
@interface DCache : NSObject

/*!
 *  查询缓存
 *
 *  @param key key
 *
 *  @return 返回某类型的所有数据。如果缓存不存在或已经失效，返回nil
 */
+ (id)queryCache:(NSString *)key;

/*!
 *  查询缓存，返回某类型的所有数据
 *
 *  @param type DCacheType-缓存类型
 *
 *  @return 返回某类型的所有数据
 */
+ (NSArray *)queryCacheForType:(DCacheType)type;

/*!
 *  查询缓存，返回某类型的所有数据
 *
 *  @param type     DCacheType-缓存类型
 *  @param maxCount 最大返回数量
 *
 *  @return 返回某类型的所有数据
 */
+ (NSArray *)queryCacheForType:(DCacheType)type maxCount:(NSInteger)maxCount;

/*!
 *  查询某类型数据条数
 *
 *  @param type DCacheType-缓存类型
 *
 *  @return 某类型数据条数
 */
+ (NSInteger)queryCacheCountForType:(DCacheType)type;

/*!
 *  缓存数据的路径
 *
 *  @return 缓存数据的路径
 */
+ (NSString *)dbPath;

/*!
 *  清除图片缓存
 *
 *
 */
+ (void)clearCache;

/*!
 *  缓存量达到峰值，清除指定大小的图片缓存
 *
 *  @param maxsize    最大缓存量
 *  @param clearsize  删除的缓存量
 *
 */
+ (void)clearCacheWithMaxSize:(long)maxsize clearSize:(long)clearsize;

/*!
 *  缓存数据的锁
 *
 *  @return 缓存数据的锁
 */
+ (NSLock *)dbLock;

/*!
 *  添加缓存
 *
 *  @param key key
 *  @param obj object
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj;
/*!
 *  添加缓存
 *
 *  @param key    key
 *  @param obj    object
 *  @param policy 缓存策略
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj policy:(DCachePolicy*)policy;
/*!
 *  添加缓存
 *
 *  @param key  key
 *  @param obj  object
 *  @param type DCacheType-缓存类型
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(DCacheType)type;
/*!
 *  添加缓存
 *
 *  @param key     key
 *  @param obj     object
 *  @param type    DCacheType-缓存类型
 *  @param expDate 失效日期
 */
+ (void)addCache:(NSString *)key obj:(id <NSCoding>)obj type:(DCacheType)type expDate:(NSDate *)expDate;

/*!
 *  删除指定key缓存
 *
 *  @param key key
 */
+ (void)removeCacheForKey:(NSString *)key;

/*!
 *  删除指定type缓存
 *
 *  @param type DCacheType-缓存类型
 */
+ (void)removeCacheForType:(DCacheType)type;


/*!
 *  删除所有缓存
 */
+ (void)removeAllCache;
@end
