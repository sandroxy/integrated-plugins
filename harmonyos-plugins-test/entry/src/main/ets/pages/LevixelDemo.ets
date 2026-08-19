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
  @State statusBarInset: number = 48;

  aboutToAppear(): void {
    this.refreshStatusBarInset();
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      LevixelGallery({
        items: this.items,
        showsNavigationHeader: true,
        navigationTitle: 'Levixel',
        navigationTopInset: this.statusBarInset,
        onNavigateBack: (): void => {
          this.getUIContext().getRouter().back();
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }

  private async refreshStatusBarInset(): Promise<void> {
    const hostContext: Context | undefined = this.getUIContext().getHostContext();
    if (hostContext === undefined) {
      return;
    }
    try {
      const mainWindow: window.Window = await window.getLastWindow(hostContext);
      const systemArea: window.AvoidArea =
        mainWindow.getWindowAvoidAreaIgnoringVisibility(window.AvoidAreaType.TYPE_SYSTEM);
      const resolvedInset: number = this.getUIContext().px2vp(systemArea.topRect.height);
      if (resolvedInset > 0) {
        this.statusBarInset = resolvedInset;
      }
    } catch (error) {
      const businessError: BusinessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Failed to read the status bar inset. Code: %{public}d, message: %{public}s',
        businessError.code, businessError.message);
    }
  }
}
