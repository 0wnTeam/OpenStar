#import <objc/runtime.h>
#import <Foundation/Foundation.h>
@interface Star : NSObject {
}
+(IMP)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl;
+(id)hookIvar:(NSString*)name inInstance:(id)inst;
+(BOOL)addSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andType:(NSString*)type;
@end
@implementation Star
+(id)hookIvar:(NSString*)name inInstance:(id)inst 
{
Ivar ivar=object_getInstanceVariable(inst, [name UTF8String], NULL);
return object_getIvar(inst, ivar);
}
+(BOOL)addSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andType:(NSString*)type 
{
        return class_addMethod(cls, selector, impl, [type UTF8String]);
}               
+(IMP)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl
{
        Method hookd=class_getClassMethod(cls, selector);
        const char* types=method_getTypeEncoding(hookd);
        return class_replaceMethod(cls, selector, (IMP) impl, types);
}
@end


