@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Column({ space: 6 }) {
          Text('Integrated Plugins')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .width('100%')

          Text('HarmonyOS')
            .fontSize(14)
            .fontColor('#667085')
            .width('100%')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 58, bottom: 18 })

        Scroll() {
          Column() {
            Row({ space: 14 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('L')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
              }
              .width(44)
              .height(44)
              .borderRadius(8)
              .backgroundColor('#101828')

              Column({ space: 4 }) {
                Text('Levixel')
                  .fontSize(17)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#101828')
                  .width('100%')

                Text('Native HarmonyOS')
                  .fontSize(13)
                  .fontColor('#667085')
                  .width('100%')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text('>')
                .fontSize(20)
                .fontColor('#98A2B3')
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: 'pages/LevixelDemo' });
            })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Start)
          .padding({ left: 16, right: 16, bottom: 28 })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
