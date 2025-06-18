/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/

import { common } from '@kit.AbilityKit'

interface ob {
  name: string
  color: string
  url: string
}

@Builder
export function toolsBuilder(name: string, param: Object) {
  tools()
}


@Component
export struct tools {
  @StorageLink('navHideBackButton') navHideBackButton:boolean = false;
  @State listTest: ob[] = [
    { name: "I am Feeling Lucky", color: "#bf76cc", url: "lucky" },
    { name: "类比色 相似色", color: "#00c3d9", url: "analogous" },
    { name: "互补色", color: "#01d48f", url: "complementary" },
    { name: "分裂补色", color: "#018884", url: "triad" },
    { name: "单色", color: "#f3c300", url: "monochromatic" },
    { name: "渐变", color: "#de6e02", url: "shade" },
    { name: "二次色配比", color: "#fd694c", url: "secondary" }
  ];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ForEach(this.listTest, (item: ob, index) => {
            ListItem() {
              Text(item.name)
                .width('100%')
                .height('14.3%')
                .fontColor("#fff")
                .textAlign(TextAlign.Center)
                .backgroundColor(item.color)
                .onClick((event) => {
                  this.pathStack.pushPathByName(item.url, null);
                })
            }
          }, (item: string) => item)
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('色彩工具')
    .onBackPressed(() => {
      if(this.navHideBackButton){
        let uiContext = getContext(this) as common.UIAbilityContext;
        uiContext.moveAbilityToBackground(); // 切换到后台
      }else {
        this.pathStack.clear();
      }
      return true
    })
    .hideBackButton(this.navHideBackButton)
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}