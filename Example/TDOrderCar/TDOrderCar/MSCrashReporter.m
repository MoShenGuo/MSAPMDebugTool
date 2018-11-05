//
//  MSCrashReporter.m
//  TDOrderCar
//
//  Created by guoxiaoliang on 2018/10/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MSCrashReporter.h"
#import <mach/mach.h>
//NSString *const kLastStartupFreeMemory;
//@implementation MSCrashReporter
//{
//    natural_t _startupFreeMemory;
//    natural_t _shutdownFreeMemory;
//    int _lastStartupFreeMemory;
//}
//
//- (void) getMemory:(BOOL)startup
//{
//    mach_port_t host_port;
//    mach_msg_type_number_t host_size;
//    vm_size_t pagesize;
//    
//    host_port = mach_host_self();
//    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
//    host_page_size(host_port, &pagesize);
//    
//    vm_statistics_data_t vm_stat;
//    
//    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
//        NSLog(@"Failed to fetch vm statistics");
//    
//    natural_t mem_free = vm_stat.free_count * pagesize;
//    if (startup)
//        _startupFreeMemory = (mem_free / 1024 );
//    else
//        _shutdownFreeMemory = (mem_free / 1024 );
//}
//- (void) handlerCrashReportInfo {
//    
//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        [self getMemory:YES];
//        
//        NSString* testValue = nil;
//        testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kLastStartupFreeMemory];
//        if (testValue == nil)
//        {
//            _lastStartupFreeMemory = 0;
//        } else {
//            _lastStartupFreeMemory = [[NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:kLastStartupFreeMemory]] intValue];
//        }
//        
//        testValue = nil;
//        testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kLastShutdownFreeMemory];
//        if (testValue == nil)
//        {
//            _lastShutdownFreeMemory = 0;
//        } else {
//            _lastShutdownFreeMemory = [[NSNumber numberWithInt:[[NSUserDefaults standardUserDefaults] integerForKey:kLastShutdownFreeMemory]] intValue];
//        }
//        
//        _crashData = nil;
//        PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
//        NSError *error;
//        
//        // Check if we previously crashed
//        if ([crashReporter hasPendingCrashReport]){
//            [self handleCrashReport];
//        }
//        
//        // Enable the Crash Reporter
//        if (![crashReporter enableCrashReporterAndReturnError: &error])
//            NSLog(@"Warning: Could not enable crash reporter: %@", error);
//        
//        if (_crashData != nil || ( _lastShutdownFreeMemory < 2000))
//        {
//            // 向服务器发送crash report
//            [self sendCrashReport];
//        }
//        
//    });
//    
//}
//- (void) sendCrashReport {
//    // 发送crash report
//}
//
//- (void) handleCrashReport {
//    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
//    NSData *crashData;
//    NSError *error;
//    
//    // Try loading the crash report
//    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
//    if (crashData == nil) {
//        NSLog(@"Could not load crash report: %@", error);
//        [crashReporter purgePendingCrashReport];
//        return;
//    }
//    
//    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    [FileManager_WX createDirectoryWithName:@"Crash" atPath:docPath];
//    NSString* filePath = [docPath stringByAppendingPathComponent:@"Crash"];
//    
//    //    [crashData writeToFile:filePath atomically:YES];
//    _crashData = crashData;
//    // We could send the report from here, but we'll just print out
//    // some debugging info instead
//    PLCrashReport *report = [[PLCrashReport alloc] initWithData: crashData error: &error];
//    if (report == nil) {
//        NSLog(@"Could not parse crash report");
//        [crashReporter purgePendingCrashReport];
//        return;
//    }
//    
//    NSLog(@"Crashed on %@", report.systemInfo.timestamp);
//    NSLog(@"Crashed with signal %@ (code %@, address=0x%" PRIx64 ")", report.signalInfo.name,
//          report.signalInfo.code, report.signalInfo.address);
//    
//    NSString *humanText = [PLCrashReportTextFormatter stringValueForCrashReport:report withTextFormat:PLCrashReportTextFormatiOS];
//    
//    // 加上用户信息
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSString* userInfo = [NSString stringWithFormat:@"appVersion: %@\nuser: %@\nstartmemory: %@\nendmemory: %@\n",app_build,self.myUser,@(_lastStartupFreeMemory),@(_lastShutdownFreeMemory)];
//    
//    humanText = [humanText stringByAppendingFormat:@"\n%@",userInfo];
//    
//    NSString* fileName = [NSString stringWithFormat:@"%@.crash",@([[NSDate date] timeIntervalSince1970])];
//    [[humanText dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[filePath stringByAppendingPathComponent:fileName] atomically:YES];
//    
//    // Purge the report
//    [crashReporter purgePendingCrashReport];
//    
//    return;
//}
//@end
