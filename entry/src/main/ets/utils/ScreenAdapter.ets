import { window } from '@kit.ArkUI';
// import display from '@ohos.display';

export class ScreenAdapter {
  // 当前屏幕宽度（单位：vp）
  private static screenWidth: number = 0;
  // 当前屏幕高度（单位：vp）
  private static screenHeight: number = 0;

  /**
   * 初始化屏幕适配
   * @param windowStage 窗口对象
   */
  static init(windowStage: window.WindowStage) {
    try {
      // const  windowObj: window.Window | undefined = undefined;
      // let windowRect: window.Rect = windowObj!.getWindowProperties().windowRect;
      // const widthVp: number = px2vp(windowRect.width);

      const win = windowStage.getMainWindowSync();
      //第二种widthVp 可以规避警告 The system capacity of this api 'getGlobalRect' is not supported on all devices
      // const widthVp = px2vp(win.getGlobalRect().width);
      const widthVp = px2vp(win.getWindowProperties().windowRect.width);
      if (widthVp >= 600) {
        AppStorage.setOrCreate('navHideBackButton', true);
      } else {
        AppStorage.setOrCreate('navHideBackButton', false);
      }

      // const displayInfo = display.getDefaultDisplaySync();
      // // 获取屏幕信息,转化单位为vp
      // ScreenAdapter.screenWidth = px2vp(displayInfo.width);
      // ScreenAdapter.screenHeight = px2vp(displayInfo.height);
      //
      // // 存储屏幕信息到AppStorage
      // AppStorage.setOrCreate('screenWidth', ScreenAdapter.screenWidth);
      // AppStorage.setOrCreate('screenHeight', ScreenAdapter.screenHeight);
      //
      // PersistentStorage.persistProp('screenWidth', ScreenAdapter.screenWidth);
      // PersistentStorage.persistProp('screenHeight', ScreenAdapter.screenHeight);
    } catch (error) {
      console.error('屏幕适配初始化失败:', error);
    }
  }

  /**
   * 获取屏幕宽度
   * @returns 屏幕宽度
   */
  static getScreenWidth(): number {
    return ScreenAdapter.screenWidth;
  }

  /**
   * 获取屏幕高度
   * @returns 屏幕高度
   */
  static getScreenHeight(): number {
    return ScreenAdapter.screenHeight;
  }
}
