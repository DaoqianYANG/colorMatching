import { common } from "@kit.AbilityKit";

/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
interface ob {
  name: string
  bgColor: string
  path: string
}

@Builder
export function webIndexBuilder(name: string, param: Object) {
  Index()
}


@Component
export struct Index {
  @StorageLink('navHideBackButton') navHideBackButton:boolean = false;
  @State listTest: ob[] = [{
    name: 'CSS 颜色值',
    bgColor: '#3498DB',
    path: 'cssColor'
  },
    {
      name: 'Web 安全色',
      bgColor: '#E74C3C',
      path: 'webColor'
    },
    {
      name: 'Gray 灰度值',
      bgColor: '#ECF0F1',
      path: 'grayLevel'
    }];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {

          ForEach(this.listTest, (item: ob, index) => {
            ListItem() {
              Flex({
                direction: FlexDirection.Column,
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Auto
              }){
                Text(item.name)
                  .width('60%')
                  .height('45%')
                  .fontColor(index<2?'#fff':'#000')
                  .borderRadius(10)
                  .fontSize('19.2vp')
                  .textAlign(TextAlign.Center)
                  .backgroundColor(item.bgColor)
                  .onClick((event) => {
                    this.pathStack.pushPathByName(item.path, null);
                  })
              }.height('33.33%')

            }
            // ListItem() {
            //   Text(item.name)
            //     .width('100%')
            //     .height('33.33%')
            //     .fontColor(index<2?'#fff':'#000')
            //     .fontSize('32vp')
            //     .textAlign(TextAlign.Center)
            //     .backgroundColor(item.bgColor)
            //     .onClick((event) => {
            //       this.pathStack.pushPathByName(item.path, null);
            //     })
            // }
          }, (item: string) => item)
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('Web 颜色')
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
    // .backgroundColor('#946f96')
    .backgroundColor('#d6ecf0')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}