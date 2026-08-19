import { UIAbility } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN: number = 0x0000;
const TAG: string = 'IntegratedPluginsTest';

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    this.configureWindow(windowStage).then(() => {
      windowStage.loadContent('pages/Index', (error) => {
        if (error.code) {
          hilog.error(DOMAIN, TAG, 'Failed to load content. Cause: %{public}s', JSON.stringify(error));
        }
      });
    });
  }

  private async configureWindow(windowStage: window.WindowStage): Promise<void> {
    try {
      const mainWindow: window.Window = windowStage.getMainWindowSync();
      await mainWindow.setWindowLayoutFullScreen(true);
      await mainWindow.setWindowSystemBarEnable(['status', 'navigation']);
      await mainWindow.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        navigationBarColor: '#000000',
        isStatusBarLightIcon: true,
        isNavigationBarLightIcon: true,
        statusBarContentColor: '#FFFFFF',
        navigationBarContentColor: '#FFFFFF'
      });
    } catch (error) {
      const businessError: BusinessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Failed to configure window. Code: %{public}d, message: %{public}s',
        businessError.code, businessError.message);
    }
  }
}
