半模态视图
先看效果图：
<br></br>
![效果预览](https://github.com/biyuhuaping/BottomSheet/blob/main/%E6%95%88%E6%9E%9C%E9%A2%84%E8%A7%88.gif)
<br></br>
越来越多的app，使用半模态视图，弹窗从底部弹窗，手动滑动收起。交互流程丝滑，体验流畅。我这一研究才发现，官方出了一个控件叫 UISheetPresentationController，使用起来及其方便，只需要关注业务逻辑就可以，着急的朋友可以直接把demo拿去。[BottomSheetDemo](https://github.com/biyuhuaping/BottomSheet.git)

## 系统提供的 UISheetPresentationController，但只在iOS16+才支持自定义高度
```objectivec
// 支持的自定义显示大小
    if (@available(iOS 16.0, *)) {
        if (vc.sheetPresentationController) {
            UISheetPresentationController *sheet = vc.sheetPresentationController;
            UISheetPresentationControllerDetent *smallDetent = [UISheetPresentationControllerDetent customDetentWithIdentifier:@"small" resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                return 0.2 * context.maximumDetentValue;
            }];
            
            sheet.detents = @[
                [UISheetPresentationControllerDetent customDetentWithIdentifier:nil resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                    return 200.0; // 固定大小
                }],
                smallDetent,
                [UISheetPresentationControllerDetent customDetentWithIdentifier:nil resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                    return 0.5 * context.maximumDetentValue; // 占上下文最大尺寸的0.5
                }],
                UISheetPresentationControllerDetent.largeDetent
            ];
            sheet.prefersGrabberVisible = YES;//是否在表单顶部显示一个抓手。默认值为 NO
            sheet.preferredCornerRadius = 10;//表单展示时的首选圆角半径
        }
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        // Fallback on earlier versions
    }
```
我们的app，还要适配iOS9.0 ，所以只能另求他法，此处推荐一个第三方库 [HWPanModal](https://github.com/HeathWang/HWPanModal.git) Star1.1k，可以比较完美的适配低版本，感谢作者。
