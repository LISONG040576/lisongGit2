

#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted
#define SYSTEM_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
// Define 'button press' effects
/**
 *  actionSheet点击反馈效果
 */
typedef NS_ENUM(NSInteger, XCActionSheetButtonResponse) {
    /**
     *  透明
     */
    XCActionSheetButtonResponseFadesOnPress,
    /**
     *  反色
     */
    XCActionSheetButtonResponseReversesColorsOnPress,
    /**
     *  放缩
     */
    XCActionSheetButtonResponseShrinksOnPress,
    /**
     *  高亮
     */
    XCActionSheetButtonResponseHighlightsOnPress
};

typedef NS_ENUM(NSInteger, XCActionSheetButtonCornerType) {
    
    XCActionSheetButtonCornerTypeNoCornersRounded,
    XCActionSheetButtonCornerTypeTopCornersRounded,
    XCActionSheetButtonCornerTypeBottomCornersRounded,
    XCActionSheetButtonCornerTypeAllCornersRounded
    
};

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


// forward declarations
@class XCActionSheet, HSActionSheetTitleView;

#pragma mark - HSActionSheetDelegate Protocol

@protocol XCActionSheetDelegate <NSObject>

-(void)actionSheet:(XCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


/*************************************************    HSActionSheet   ************************************************************/

#pragma mark - HSActionSheet

@interface XCActionSheet : UIView {
    
}
/**
 *  显示ActionSheet
 *
 *  @param theView 显示所在的视图
 */
- (void)showInView:(UIView *)theView;

//- (NSInteger)addButtonWithTitle:(NSString *)title;

//- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

/**
 *  初始化
 *
 *  @param title            标题
 *  @param delegate         代理对象
 *  @param cancelTitle      取消按钮
 *  @param destructiveTitle
 *  @param otherTitles
 *
 *  @return
 */
- (id)initWithTitle:(NSString *)title
 buttonResponseType:(XCActionSheetButtonResponse)buttonResponseType
              delegate:(id<XCActionSheetDelegate>)delegate
     cancelButtonTitle:(NSString *)cancelTitle
destructiveButtonTitle:(NSString *)destructiveTitle
     otherButtonTitles:(NSString *)otherTitles, ... NS_REQUIRES_NIL_TERMINATION;


//- (NSInteger)numberOfButtons;

/**
 *  选中按钮的标题
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)index;

//- (void)rotateToCurrentOrientation;


// fonts
//- (void)setFont:(UIFont *)font;
//- (void)setTitleFont:(UIFont *)font;
//- (void)setFont:(UIFont *)font forButtonAtIndex:(NSInteger)index;


// standard colors

//- (void)setTitleTextColor:(UIColor *)color;
//- (void)setButtonTextColor:(UIColor *)color;
//- (void)setTitleBackgroundColor:(UIColor *)color;
//- (void)setButtonBackgroundColor:(UIColor *)color;
//- (UIColor *)buttonTextColorAtIndex:(NSInteger)index;
//- (UIColor *)buttonBackgroundColorAtIndex:(NSInteger)index;
//- (void)setButtonTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//- (void)setButtonBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//
//
//// highlight colors
//- (void)setButtonHighlightBackgroundColor:(UIColor *)color;
//- (void)setButtonHighlightTextColor:(UIColor *)color;
//- (void)setButtonHighlightTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//- (void)setButtonHighlightBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;

@property UIView *transparentView;
@property NSMutableArray *buttons;
@property (nonatomic) NSString *title;
@property HSActionSheetTitleView *titleView;
@property (weak) id <XCActionSheetDelegate> delegate;
@property XCActionSheetButtonResponse buttonResponse;
@property BOOL visHSle, hasCancelButton, hasDestructiveButton, shouldCancelOnTouch;

@end




/************************************************    HSActionSheetButton     **********************************************************/
#pragma mark - HSActionSheetButton

@interface XCActionSheetButton : UIButton


- (id)initWithTopCornersRounded;
- (id)initWithAllCornersRounded;
- (id)initWithBottomCornersRounded;
- (void)resizeForPortraitOrientation;
- (void)resizeForLandscapeOrientation;
- (void)setTextColor:(UIColor *)color;

@property NSInteger index;
@property XCActionSheetButtonCornerType cornerType;
@property UIColor *originalTextColor, *highlightTextColor;
@property UIColor *originalBackgroundColor, *highlightBackgroundColor;


@end

/***********************************************     HSActionSheetTitleView     ************************************************************/
#pragma mark - HSActionSheetTitleView

@interface HSActionSheetTitleView : UIView

- (void)resizeForPortraitOrientation;
- (void)resizeForLandscapeOrientation;
- (id)initWithTitle:(NSString *)title;


@property UILabel *titleLabel;

@end




