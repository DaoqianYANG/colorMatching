@Entry
@Component
struct Index {
  @State listTest: string[] = ['配色广场', '颜色转换', '色彩工具', 'Web颜色', '关于色搭'];

  build() {
    Column() {
      Text('Color')
        .fontSize($r('app.float.page_text_font_size'))
        .fontColor('#fff')
        .margin({ top: '40vp' })
      Text('色搭')
        .fontColor('#fff')
        .margin({ top: '20vp' })
        .fontSize('20vp')

      List({ space: 30 }) {
        ForEach(this.listTest, (item: string, index) => {
          ListItem() {
            Text(item)
              .width('60%')
              .height('40vp')
              .fontColor("#fff")
              .textAlign(TextAlign.Center)
              .borderRadius('50%')
              .backgroundColor('rgba(255, 255, 255, 0.3)')//添加按钮事件
              .onClick((index) => {
                this.listTest[1] = '2+'+index
              })
          }
        }, (item: string) => item)
      }
      .margin({ top: '20vp' })
      .alignListItem(ListItemAlign.Center)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#1e8cd4')

  }
}