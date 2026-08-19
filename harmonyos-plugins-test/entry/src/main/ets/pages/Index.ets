@Entry
@Component
struct Index {
  build() {
    Column() {
      Column({ space: 0 }) {
        Text('NATIVE PLUGIN LAB')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor('#CFDAEB')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#24405F')
          .borderRadius(8)
          .alignSelf(ItemAlign.Start)

        Text('HarmonyOS Native Plugins')
          .fontSize(29)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 18 })
          .width('100%')

        Text('Packaged plugin artifacts, isolated in focused verification screens.')
          .fontSize(14)
          .fontColor('#CFDAEB')
          .lineHeight(20)
          .margin({ top: 7 })
          .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 58, bottom: 30 })
      .backgroundColor('#172A48')

      Column({ space: 0 }) {
        Text('Available plugins')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#172033')
          .width('100%')

        Text('Open a plugin to verify its public artifact.')
          .fontSize(13)
          .fontColor('#667085')
          .margin({ top: 3 })
          .width('100%')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 24, bottom: 14 })

      Scroll() {
        Column() {
          Row({ space: 15 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.ic_gallery'))
                .width(28)
                .height(28)
            }
            .width(56)
            .height(56)
            .borderRadius(10)
            .backgroundColor('#3D63E8')

            Column({ space: 4 }) {
              Text('Levixel')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .fontColor('#172033')
                .width('100%')

              Text('Shared-transition image and video viewer')
                .fontSize(13)
                .fontColor('#667085')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width('100%')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Image($r('app.media.ic_chevron_right'))
              .width(22)
              .height(22)
          }
          .width('100%')
          .constraintSize({ minHeight: 94 })
          .padding({ left: 16, right: 14, top: 15, bottom: 15 })
          .backgroundColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/LevixelDemo' });
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Start)
        .padding({ left: 20, right: 20, bottom: 28 })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F5F9')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
