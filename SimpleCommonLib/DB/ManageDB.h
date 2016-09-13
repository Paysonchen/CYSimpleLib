//
//  ManageDB.h
//  HealthHome
//
//  Created by weihongWang on 14-7-15.
//  Copyright (c) 2014年 easepal. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseObject.h"
#import <CoreData/CoreData.h>

@interface ManageDB : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (ManageDB *)sharedClient;

- (void)insertDataWithTableName:(NSString*)tableName
                       delegate:(id)delegate;

- (void)saveContext;


- (NSURL *)applicationDocumentsDirectory;


//插入数据库
- (void)dataUpWithtableName:(NSString *)tableName
                   delegate:(id)delegate
                    KeyName:(NSString *)keyName
                   KeyValue:(NSString *)keyValue;

//查询数据库tableName表里全部记录
- (NSArray*)readArrayFromTableName:(NSString *)tableName;
- (NSArray*)readArrayFromTableName:(NSString *)tableName key:(NSString *) keyname value:(NSString *) value;


//删除数据库某张表
-(void) deleteAllFromCoreData:(NSString *) entityName;
-(void) deleteAllFromCoreData:(NSString *) entityName key:(NSString *) keyname value:(NSString *) value;

@end
