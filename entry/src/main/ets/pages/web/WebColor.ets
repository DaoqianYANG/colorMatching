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
export function webColorBuilder(name: string, param: Object) {
  webColor()
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

  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(Text)
function textStyle() {
  .width('100%')
  .margin({ bottom: '5vp' })
  .fontColor('#333')
  .textIndent('32vp')
}



@Component
export struct webColor {
  numberFix(a: string): string {
    if (a.length == 1) {
      return "0" + a;
    }
    return a;
  };

  range(length: number): number[] {
    let result: number[] = [];
    for (let i = 0; i < length; i++) {
      result.push(i);
    }
    return result;
  }

  initialize() {
    let array: string[] = [];
    for (let i = 0; i <= 255; i += 51) {
      let red_10 = new Number(i);
      let red = red_10.toString(16);
      red = this.numberFix(red);

      for (let j = 0; j <= 255; j += 51) {
        let green_10 = new Number(j);
        let green = green_10.toString(16);
        green = this.numberFix(green);

        for (let k = 0; k <= 255; k += 51) {
          let blue_10 = new Number(k);
          let blue = blue_10.toString(16);
          blue = this.numberFix(blue);

          let color = "#" + red + green + blue;
          array.push(color);
        }
      }
    }
    this.color_array = array;
    this.index_array = this.range(72)

  }

  @State color_array: string[] = [];
  @State index_array: number[] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ListItem() {
            Column() {
              Text("HTML 和 CSS 颜色规范中定义了 147 中颜色名（17 种标准颜色加 130 种其他颜色）。下面的表格中列出了所有这些颜色，以及它们的十六进制值。")
                .textStyle()
              Text('点击来查看相应颜色的详细分量值。')
                .textStyle()
            }.columnStyle()
          }

          ListItem() {
            Column() {
              ForEach(this.index_array, (item: number) => {
                Flex({
                  justifyContent: FlexAlign.Center,
                  alignItems: ItemAlign.Center
                }) {
                  Flex().backgroundColor(this.color_array[item]).width('33.33%').height('40vp')
                    .onClick((event) => {
                      const ob: ob = {
                        hex: this.color_array[item]
                      }
                      this.pathStack.pushPathByName('ColorDetail', ob);
                    })
                  Flex().backgroundColor(this.color_array[item+1]).width('33.33%').height('40vp')
                    .onClick((event) => {
                      let ob: ob = {
                        hex: this.color_array[item+1]
                      }
                      this.pathStack.pushPathByName('ColorDetail', ob);
                    })
                  Flex().backgroundColor(this.color_array[item+2]).width('33.33%').height('40vp')
                    .onClick((event) => {
                      let ob: ob = {
                        hex: this.color_array[item+2]
                      }
                      this.pathStack.pushPathByName('ColorDetail', ob);
                    })
                }

                Flex({
                  justifyContent: FlexAlign.Center,
                  alignItems: ItemAlign.Center
                }) {
                  Text(this.color_array[item]).textAlign(TextAlign.Center).width('33.33%')
                  Text(this.color_array[item+1]).textAlign(TextAlign.Center).width('33.33%')
                  Text(this.color_array[item+2]).textAlign(TextAlign.Center).width('33.33%')
                }
                .padding({ top: '5vp', bottom: '8vp' })
              })
            }
          }.margin('20vp')

        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('Web 安全色')
    .backgroundColor('#f8f8f8')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((ctx: NavDestinationContext) => {
      this.pathStack = ctx.pathStack;
      try {
        this.initialize();
      } catch (e) {
      }
    })

  }
}
