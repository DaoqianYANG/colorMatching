/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
import pasteboard from '@ohos.pasteboard'
import promptAction from '@ohos.promptAction'
import colorUtilsObject from '../utils/ColorUtil'


interface ob {
  name: string
  value: Array<string>
}

interface paramOB {
  name: string
  hex: string
  color?: string
}


@Builder
export function ColorDetailBuilder(name: string, param: Object) {
  ColorDetail()
}

function copyText(text: string) {
  const pasteboardData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, text)
  const systemPasteboard = pasteboard.getSystemPasteboard()
  // 将数据放入剪切板
  systemPasteboard.setData(pasteboardData, (err, data) => {
    if (err) {
      promptAction.showToast({ message: "复制HEX值失败" })
      return;
    }
    promptAction.showToast({ message: "复制HEX值成功" })
  });
}

@Component
export struct ColorDetail {
  @State types: ob[] = [
    { name: 'RGB分类', value: ['R', 'G', 'B'] },
    { name: 'CMYK分量', value: ['C', 'M', 'Y', 'K'] },
    { name: 'Lab分量', value: ['L', 'a', 'b'] },
    { name: 'HSB分量', value: ['H', 'S', 'B'] }
  ]
  @State param: paramOB = { name: '未知', hex: '#fff', color: '#fff' };

  @State arr :number[][] =[];

  build() {
    NavDestination() {
      List() {
        ListItem() {
          Flex()
            .width('100%')
            .height('110vp')
            .backgroundColor(this.param.hex)
            .onClick(() => {
              copyText(this.param.name + ', HEX: ' + this.param.hex)
            })
        }
        ListItem() {
          Text(this.param.hex).margin({ top: '20.00vp' }).fontColor('#888').textAlign(TextAlign.Center)
        }
        ListItem() {
          GridRow({ columns: 2 }) {
            ForEach(this.types, (item: ob, index) => {
              GridCol() {
                Column() {
                  Text(item.name).margin({ bottom: '20vp' }).fontColor('#888')
                  List() {
                    ForEach(item.value, (t: string, index1) => {
                      ListItem() {
                        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                          Text(t + ':')
                          Text(index != 1 && index != 3 ? this.arr[index][index1].toString() :
                            this.arr[index][index1].toString() + '%')
                        }.margin({ bottom: '10vp' })
                      }.padding({ left: '30vp', right: '20vp' })
                    }, (t: string) => t)
                  }
                }.margin({ top: '20vp', bottom: '20vp' })
              }
            }, (item: string) => item)
          }
        }
      }.alignListItem(ListItemAlign.Center)
    }
    .title(this.param.name)
    .height('100%')
    .width('100%')
    .padding('15vp')
    .padding({ top:35 })
    .onReady((ctx: NavDestinationContext) => {
      try {
        const obj = (ctx.pathInfo.param as paramOB);
        // console.log('检测，：',JSON.stringify(obj));
        if (!obj.hex) {
          ctx.pathStack.pop();
        }
        this.param = obj;
        this.param.name = this.param.name ? this.param.name : '色彩分量'
        const hex = obj.hex;
        const rgb = colorUtilsObject.hex2rgb(hex);
        const cmyk = colorUtilsObject.rgb2cmyk(rgb[0], rgb[1], rgb[2]);
        const lab = colorUtilsObject.rgb2lab(rgb[0], rgb[1], rgb[2]);
        const hsb = colorUtilsObject.rgb2hsb(rgb[0], rgb[1], rgb[2]);
        this.arr = [rgb,cmyk,lab,hsb];
      } catch (e) {
      }
    })

  }
}

