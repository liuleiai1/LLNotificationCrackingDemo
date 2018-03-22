//
//  LLNotification.m
//  LLNotificationCracking
//
//  Created by 迦南 on 2017/9/23.
//  Copyright © 2017年 迦南. All rights reserved.
//

#import "LLNotification.h"

/****************    Notifications    ****************/

@implementation LLNotification

- (instancetype)initWithName:(LLNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
    
    if (self = [super init]) {
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    return nil;
}

@end

@implementation LLNotification (LLNotificationCreation)

+ (instancetype)notificationWithName:(LLNotificationName)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    
    return [[self alloc] initWithName:aName object:anObject userInfo:aUserInfo];
}

+ (instancetype)notificationWithName:(LLNotificationName)aName object:(id)anObject {
    
    return [self notificationWithName:aName object:anObject userInfo:nil];
}

@end

/****************    Notification Center    ****************/

typedef void(^OperationBlock)(LLNotification *notification);

@interface LLObserverModel : NSObject

@property (nonatomic, weak) id observer;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, copy) OperationBlock block;
@end

@implementation LLObserverModel

@end

@interface LLNotificationCenter ()

@property (nonatomic, strong) NSMutableArray *observers;
@end

@implementation LLNotificationCenter

- (instancetype)init {
    
    @throw [NSException exceptionWithName:@"Cannot be involked" reason:@"Singleton" userInfo:nil];
}

+ (LLNotificationCenter *)defaultCenter {
    
    static LLNotificationCenter *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] initSingleton];
    });
    return singleton;
}

- (instancetype)initSingleton {
    
    if (self = [super init]) {
        _observers = [NSMutableArray array];
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable LLNotificationName)aName object:(nullable id)anObject {
    LLObserverModel *observerModel = [[LLObserverModel alloc] init];
    observerModel.observer = observer;
    observerModel.selector = aSelector;
    observerModel.notificationName = aName;
    observerModel.object = anObject;
    [self.observers addObject:observerModel];
}

- (void)postNotification:(LLNotification *)notification {
    
    [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLObserverModel *observerModel = obj;
        id observer = observerModel.observer;
        SEL selector = observerModel.selector;

        if (![observerModel.notificationName isEqualToString:notification.name]) return;

        if (!observerModel.operationQueue) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [observer performSelector:selector withObject:notification];
#pragma clang diagnostic pop
        } else {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                observerModel.block(notification);
            }];
            NSOperationQueue *operationQueue = observerModel.operationQueue;
            [operationQueue addOperation:operation];
        }
    }];
}

- (void)postNotificationName:(LLNotificationName)aName object:(nullable id)anObject {
    
    [self postNotificationName:aName object:anObject userInfo:nil];
}

- (void)postNotificationName:(LLNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    
    LLNotification *notification = [[LLNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
    [self postNotification:notification];
}

- (void)removeObserver:(id)observer {
    
     [self removeObserver:observer name:nil object:nil];
}

- (void)removeObserver:(id)observer name:(nullable LLNotificationName)aName object:(nullable id)anObject {
    
    [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLObserverModel *observerModel = obj;
        if (observerModel.observer == observer && [observerModel.notificationName isEqualToString:aName] && observerModel.object == anObject) {
            [self.observers removeObject:observerModel];
            *stop = YES;
        }
    }];
}

- (id <NSObject>)addObserverForName:(nullable LLNotificationName)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(LLNotification *note))block {
    
    LLObserverModel *observerModel = [[LLObserverModel alloc] init];
    observerModel.notificationName = name;
    observerModel.object = obj;
    observerModel.operationQueue = queue;
    observerModel.block = block;
    [self.observers addObject:observerModel];
    return nil;
}

@end
