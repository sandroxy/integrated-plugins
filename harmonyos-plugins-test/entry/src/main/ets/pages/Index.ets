@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 10 }) {
        Text('Integrated Plugins')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')

        Text('No packaged plugins installed')
          .fontSize(15)
          .fontColor('#4B5563')
      }
      .alignItems(HorizontalAlign.Center)
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
