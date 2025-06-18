import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError, deviceInfo } from '@kit.BasicServicesKit';
import { ScreenAdapter } from '../utils/ScreenAdapter'

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  windowObj: window.Window | undefined = undefined;
  private onWindowSizeChange: (data: window.Size) => void = (data: window.Size) => {
    let widthVp: number = px2vp(data.width);
    console.log("窗口宽，高", widthVp, px2vp(data.height));
    if (widthVp >= 600) {
      AppStorage.setOrCreate('navHideBackButton', true);
    } else {
      AppStorage.setOrCreate('navHideBackButton', false);
    }
    this.setDefaultOrientation();
  }

  // ...
  setDefaultOrientation(): void {
    const BREAKPOINT_MD = 600;
    let windowRect: window.Rect = this.windowObj!.getWindowProperties().windowRect;
    let windowWidthVp: number = px2vp(windowRect.width);
    let windowHeightVp: number = px2vp(windowRect.height);
    let aspectRatio: number = windowHeightVp / windowWidthVp;
    if (Math.min(windowWidthVp, windowHeightVp) >= BREAKPOINT_MD || (aspectRatio < 1.2 && aspectRatio >= 0.8) ||
      deviceInfo.deviceType === 'tablet') {
      AppStorage.setOrCreate('navSplit',true);
      // Rotation supported.
      this.windowObj?.setPreferredOrientation(window.Orientation.AUTO_ROTATION_RESTRICTED);
    } else {
      AppStorage.setOrCreate('navSplit',false);
      // Portrait display.
      this.windowObj?.setPreferredOrientation(window.Orientation.PORTRAIT);
    }
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 初始化屏幕适配
    ScreenAdapter.init(windowStage);

    windowStage.getMainWindow().then((windowObj) => {
      this.windowObj = windowObj;
      this.setDefaultOrientation();
      this.windowObj.on('windowSizeChange', this.onWindowSizeChange);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, 'testTag',
        `Failed to obtain the main window. Cause code: ${err.code}, message: ${err.message}`);
    });

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
    windowStage.getMainWindow((err, data) => {
      if (!err.code) {
        data.setWindowLayoutFullScreen(true)
      }
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}