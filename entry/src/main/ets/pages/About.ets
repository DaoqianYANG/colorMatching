/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
 import { common } from "@kit.AbilityKit"
@Builder
export function aboutBuilder(name: string, param: Object) {
  about()
}

@Extend(Column)
function columnStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
    left: '63px',
    right: '63px'
  })
  .padding({
    top: 15, // 上边距15vp
    right: 20, // 右边距20vp
    bottom: 10, // 下边距10vp
    left: 20        // 左边距20vp
  })
  .border({
    width: 1,
    style: BorderStyle.Solid,
    color: 'rgba(39, 48, 57, 0.08)'
  })
  .borderRadius(17)
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(Text)
function tittleStyle() {
  .width('100%')
  .fontWeight(FontWeight.Bold)
  .fontSize(20)
  .margin({ top: 10, bottom: 10 })
  .fontColor('#333')
}

@Extend(Text)
function pStyle() {
  .width('100%')
  .margin({ bottom: '5vp' })
  .fontColor('#333')
}


@Extend(Text)
function textStyle() {
  .width('100%')
  .margin({ bottom: '5vp' })
  .fontColor('#333')
  .textIndent('32vp')
}



@Component
export struct about {
  @StorageLink('navHideBackButton') navHideBackButton:boolean = false;
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      List({ space: 0 }) {
        ListItem() {
          Column() {
            Image($r('app.media.startIcon')).width('80vp').margin({ bottom: 20 })
            Text('色搭')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 })
            Row() {
              Text('版本号:').fontWeight(FontWeight.Medium).fontColor('#888')
              Text('1.0.0').margin({ left: 10 }).fontColor('#888')
            }.margin({ bottom: 10 })

            Text('关于色搭').tittleStyle()
            Text("色搭致力于为用户打造一款功能强大、便捷易用的色彩搭配 App，帮助您轻松解决各种配色难题。无论您是专业设计师，还是对色彩搭配感兴趣的初学者，这款 App 都将成为您的得力助手。")
              .textStyle()
            Text('一、App 简介')
              .tittleStyle()
            Text("色搭 App 是一款集色彩灵感获取、智能配色推荐、色卡编辑与管理等多种功能于一体的专业配色工具。通过丰富的色彩资源和智能算法，为您提供全方位的配色解决方案。")
              .textStyle()
            Text('二、核心功能')
              .tittleStyle()
            Text("1.配色广场:提供了中国和日本传统颜色，Adobe Color CC上最受欢迎的配色方案以及自己收藏的配色方案。")
              .pStyle()
            Text("2.颜色转换:提供了颜色在RGB、CMYK、LAB、HSB四个色彩空间以及HEX的换算操作，方便在查询色彩分量的同时，参考其他色彩空间的值。")
              .pStyle()
            Text("3.配色工具:提供了基于六种颜色关系的配色算法。")
              .pStyle()
            Text("4.Web颜色:列举了Web标准规范中HTML和CSS定义的标准色和安全色。")
              .pStyle()
            Text('三、适用范围').tittleStyle()
            Text("涵盖手绘配色、海报配色、PPT 配色、笔记配色、封面配色、家居配色、穿搭配色、广告配色、网页配色、UI 配色、刺绣配色、模型配色等各类场景，满足您在工作、学习和生活中的不同配色需求。")
              .textStyle()

            Column() {
              Row() {
                Text('开发者:').fontWeight(FontWeight.Medium)
                Text('杨国兴').margin({ left: 10 })
                Text("523585137@qq.com").margin({ left: 10 })
              }.margin({ bottom: 10 })

              Row() {
                Text('基于项目:').fontWeight(FontWeight.Medium)
                Text('Color颜值 (蔡炜桀)').margin({ left: 10 })
              }.margin({ bottom: 10 })

              // 许可证声明
              Text('许可证: GNU General Public License v3.0 or later')
                .fontSize(12)
                .margin({ top: 25, bottom: 10 })
              Button('查看完整许可证')
                .onClick(() => {
                  this.pathStack.pushPath({ name: 'license', param: null });
                })
                .margin({ bottom: 15 })

              // 衍生说明
              Text('本应用是"Color颜值"项目的衍生作品，主要进行了鸿蒙系统适配与UI优化及部分功能逻辑修改。')
                .fontSize(15)
                .textAlign(TextAlign.Start)
                .margin({ left: 20, right: 20 })
            }.margin({top:50})
          }.columnStyle()
        }
      }
    }
    .title('关于')
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
    .backgroundColor('#f8f8f8')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((ctx: NavDestinationContext) => {
      this.pathStack = ctx.pathStack;
      try {
      } catch (e) {
      }
    })

  }
}
