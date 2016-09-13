//
//  ManageDB.m
//  HealthHome
//
//  Created by weihongWang on 14-7-15.
//  Copyright (c) 2014年 easepal. All rights reserved.
//

#import "ManageDB.h"
#define COREDATA_NAME @"CoreData"
#import "UtilsHelper.h"
#import <objc/runtime.h>

@implementation ManageDB


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (ManageDB *)sharedClient
{
    
    
    static ManageDB *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ManageDB alloc] init];
    });
    
    return _sharedClient;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:COREDATA_NAME withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",COREDATA_NAME]];
    
    
    NSError *error = nil;
    
    
    NSDictionary *optionsDictionary = nil;

    optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
    

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:optionsDictionary error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
/*******************************************************
 
 功能: 插入数据库
 参数: tableName 数据库表名
 delegate 存储的对象
 
 *******************************************************/
- (void)insertDataWithTableName:(NSString*)tableName
                       delegate:(id)delegate
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *sObj = [NSEntityDescription insertNewObjectForEntityForName:tableName  inManagedObjectContext:context];
    
    NSString *className = NSStringFromClass([delegate class]);
    const char *cClassName = [className UTF8String];
    id theClass = objc_getClass(cClassName);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        SEL selector = NSSelectorFromString(propertyNameString);
        
        NSString *str =[NSString stringWithFormat:@"%@", [delegate performSelector:selector]];
        if ([UtilsHelper stringIsEmpty:str]) {
            str= @"";
        }
        [sObj setValue:str forKey:propertyNameString];
        [propertyNameString release];
        propertyNameString = nil;
    }
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}

/*******************************************************
 
 功能:
 （插入数据库升级版）更新数据库已有条目的信息，如果没有该信息,插入该数据
 
 
 参数:
 tableName   数据库表名
 delegate    存储的对象
 keyName     主键名称
 KeyValue    主键的值
 
 *******************************************************/

- (void)dataUpWithtableName:(NSString *)tableName
                   delegate:(id)delegate
                    KeyName:(NSString *)keyName
                   KeyValue:(NSString *)keyValue

{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:tableName inManagedObjectContext:moc]];
    //查出keyName等于 keyValue字段 存到 request
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",keyName, keyValue];
    
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    //如果表里面有keyValue字段的条目
    if ([results count]>0) {
        //results 都是值为 keyValue的 条目
        for (int i=0; i<[results count]; i++) {
            
            NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
            
            NSString *className = NSStringFromClass([delegate class]);
            const char *cClassName = [className UTF8String];
            id theClass = objc_getClass(cClassName);
            unsigned int outCount, j;
            objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
            
            for (j = 0; j < outCount; j++) {
                objc_property_t property = properties[j];
                NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                SEL selector = NSSelectorFromString(propertyNameString);
                
                NSString *str =[NSString stringWithFormat:@"%@", [delegate performSelector:selector]];
                if ([UtilsHelper stringIsEmpty:str]) {
                    str= @"";
                }
                [favoritsGrabbed setValue:str forKey:propertyNameString];
                [propertyNameString release];
                propertyNameString = nil;
            }
        }
        if(![moc save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
    else{//如果表里没有执行插入数据
        [self insertDataWithTableName:tableName delegate:delegate];
    }
    
    [request release];
    request = nil;
}//更新数据

/*******************************************************
 
 功能:查询数据库
 
 
 参数:
 tableName   数据库表名
 class       将要读取的对象类型 与tableName的名称要一致
 
 返回值: NSArray  读取对象的数组
 *******************************************************/
- (NSArray*)readArrayFromTableName:(NSString *)tableName
{

    return [self readArrayFromTableName:tableName key:nil value:nil];
    
}
- (NSArray*)readArrayFromTableName:(NSString *)tableName key:(NSString *) keyname value:(NSString *) value
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];//modify 2015-06-16
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
   
    
   
    if (keyname && value) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",keyname, value];
        
        [fetchRequest setPredicate:predicate];
    }
   
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    
    
    const char *cClassName = [tableName UTF8String];
    id theClass = objc_getClass(cClassName);
    unsigned int outCount, j;
    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
    NSMutableArray *returnArray = [[[NSMutableArray alloc]init]autorelease];
    
    if ([fetchedObjects count]<=0) {
        return nil;
    }
    
    for (NSManagedObject *info in fetchedObjects) {//循环遍历所有条目
        NSObject *bojc = [[theClass alloc]init];
        for (j = 0; j < outCount; j++) {//遍历传入的对象的key
            objc_property_t property = properties[j];
            NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *value = [info valueForKey:propertyNameString];
            NSString *selNameFirstChar = [propertyNameString substringToIndex:1];
            selNameFirstChar = [selNameFirstChar uppercaseString];
            NSString *selName = [propertyNameString substringFromIndex:1];
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",selNameFirstChar,selName]);
            [bojc performSelector:selector withObject:value];
            [propertyNameString release];
            propertyNameString = nil;
        }
        [returnArray addObject:bojc];
        [bojc release];
        bojc =nil;
    }
    
    return returnArray;

}
/*******************************************************
 
 功能:删除数据库某张表
 
 
 参数:
 entityName   数据库表名
 
 *******************************************************/
-(void) deleteAllFromCoreData:(NSString *) entityName
{
    [self deleteAllFromCoreData:entityName key:nil value:nil];
    
}
-(void) deleteAllFromCoreData:(NSString *) entityName key:(NSString *) keyname value:(NSString *) value
{
    NSManagedObjectContext *context = [self managedObjectContext];
	NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setIncludesPropertyValues:NO];
	[request setEntity:description];
    
    if (keyname && value) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",keyname, value];
        
        [request setPredicate:predicate];
    }
    
	NSError *error = nil;
	NSArray *datas = [context executeFetchRequest:request error:&error];
	if (!error && datas && [datas count])
	{
		for (NSManagedObject *obj in datas)
		{
			[context deleteObject:obj];
		}
		if (![context save:&error])
		{
			NSLog(@"error:%@",error);
		}
	}
}

@end
