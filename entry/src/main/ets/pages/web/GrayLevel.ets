/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
interface ob {
  hex: string
}

@Builder
export function grayLevelBuilder(name: string, param: Object) {
  grayLevel()
}


@Component
export struct grayLevel {
  @State color: ob[] = [
    { hex: "#000000" },
    { hex: "#080808" },
    { hex: "#101010" },
    { hex: "#181818" },
    { hex: "#202020" },
    { hex: "#282828" },
    { hex: "#303030" },
    { hex: "#383838" },
    { hex: "#404040" },
    { hex: "#484848" },
    { hex: "#505050" },
    { hex: "#585858" },
    { hex: "#606060" },
    { hex: "#686868" },
    { hex: "#707070" },
    { hex: "#787878" },
    { hex: "#808080" },
    { hex: "#888888" },
    { hex: "#909090" },
    { hex: "#989898" },
    { hex: "#A0A0A0" },
    { hex: "#A8A8A8" },
    { hex: "#B0B0B0" },
    { hex: "#B8B8B8" },
    { hex: "#C0C0C0" },
    { hex: "#C8C8C8" },
    { hex: "#D0D0D0" },
    { hex: "#D8D8D8" },
    { hex: "#E0E0E0" },
    { hex: "#E8E8E8" },
    { hex: "#F0F0F0" },
    { hex: "#F8F8F8" },
    { hex: "#FFFFFF" }];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ForEach(this.color, (item: ob, index) => {
            ListItem() {
              Flex({
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
              }) {
                Text(item.hex).width('25%')
                Flex().backgroundColor(item.hex).width('75%').height('40vp')
                  .onClick((event) => {
                    this.pathStack.pushPathByName('ColorDetail', item);
                  })
              }
            }.margin({ left: '20vp', right: '20vp' })
          })
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('灰阶灰度')
    // .backgroundColor('#eee')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}
