//
//  LLNotification.h
//  LLNotificationCracking
//
//  Created by 迦南 on 2017/9/23.
//  Copyright © 2017年 迦南. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *LLNotificationName NS_EXTENSIBLE_STRING_ENUM;

@class NSString, NSDictionary, NSOperationQueue;

NS_ASSUME_NONNULL_BEGIN

/****************    Notifications    ****************/

@interface LLNotification : NSObject

@property (readonly, copy) LLNotificationName name;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(LLNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)) NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;   

@end

@interface LLNotification (LLNotificationCreation)

+ (instancetype)notificationWithName:(LLNotificationName)aName object:(nullable id)anObject;
+ (instancetype)notificationWithName:(LLNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

@end

/****************    Notification Center    ****************/

@interface LLNotificationCenter : NSObject

+ (LLNotificationCenter *)defaultCenter;

// 向通知中心注册观察者
// 观察者接收到通知后执行任务的代码在发送通知的线程中执行
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable LLNotificationName)aName object:(nullable id)anObject;
// 观察者接收到通知后执行任务的代码在指定的操作队列中执行
- (id <NSObject>)addObserverForName:(nullable LLNotificationName)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(LLNotification *note))block NS_AVAILABLE(10_6, 4_0);

// 通知中心向所有注册的观察者发送通知
- (void)postNotification:(LLNotification *)notification;
- (void)postNotificationName:(LLNotificationName)aName object:(nullable id)anObject;
- (void)postNotificationName:(LLNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

// 移除观察者
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable LLNotificationName)aName object:(nullable id)anObject;

@end
NS_ASSUME_NONNULL_END
