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
export function plazaIndexBuilder(name: string, param: Object) {
  Index()
}
@Component
export struct Index {

  @StorageLink('navHideBackButton') navHideBackButton:boolean = false;


  @State listTest: ob[] = [{
    name: '中国传统色彩',
    bgColor: '#ff461f',
    path: 'plazaChina'
  },
    {
      name: '日本传统色彩',
      bgColor: '#88ada6',
      path: 'plazaJapan'
    },
    // {
    //   name: 'Adobe 配色方案',
    //   bgColor: '#003371',
    //   path: 'adobe'
    // },
    {
      name: '我的收藏',
      bgColor: '#ef7a82',
      path: 'myFav'
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
                  .borderRadius(10)
                  .fontColor("#fff")
                  .fontSize('19.2vp')
                  .textAlign(TextAlign.Center)
                  .backgroundColor(item.bgColor)
                  .onClick((event) => {
                    this.pathStack.pushPathByName(item.path, null);
                  })
              }.height('33.33%')

            }
          }, (item: string) => item)
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('配色广场')
    .onBackPressed(() => {
      if(this.navHideBackButton){
        let uiContext = getContext(this) as common.UIAbilityContext;
        uiContext.moveAbilityToBackground(); // 切换到后台
      }else {
        this.pathStack.clear();
      }
      return true
    })
    .height('100%')
    .width('100%')
    // .backgroundColor('#946f96')
    .backgroundColor('#d6ecf0')
    .hideBackButton(this.navHideBackButton)
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}