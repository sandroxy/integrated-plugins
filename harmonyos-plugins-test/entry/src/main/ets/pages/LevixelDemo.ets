import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { LevixelGallery, LevixelMediaItem } from '@sandrox/levixel';
import { createLevixelSampleData } from '../data/LevixelSampleData';

const DOMAIN: number = 0x0000;
const TAG: string = 'LevixelDemo';

@Entry
@Component
struct LevixelDemo {
  private readonly items: LevixelMediaItem[] = createLevixelSampleData();

  aboutToAppear(): void {
    this.setSystemBarContent(true);
  }

  aboutToDisappear(): void {
    this.setSystemBarContent(false);
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      LevixelGallery({ items: this.items })
    }
    .width('100%')
    .height('100%')
  }

  private async setSystemBarContent(light: boolean): Promise<void> {
    const hostContext: Context | undefined = this.getUIContext().getHostContext();
    if (hostContext === undefined) {
      return;
    }
    try {
      const mainWindow: window.Window = await window.getLastWindow(hostContext);
      const contentColor: string = light ? '#FFFFFF' : '#111827';
      await mainWindow.setWindowSystemBarProperties({
        isStatusBarLightIcon: light,
        isNavigationBarLightIcon: light,
        statusBarContentColor: contentColor,
        navigationBarContentColor: contentColor
      });
    } catch (error) {
      const businessError: BusinessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Failed to update system bars. Code: %{public}d, message: %{public}s',
        businessError.code, businessError.message);
    }
  }
}
