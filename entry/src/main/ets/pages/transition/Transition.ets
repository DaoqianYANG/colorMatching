/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
import pasteboard from '@ohos.pasteboard'
import promptAction from '@ohos.promptAction'
import colors from '../../utils/ColorUtil'
import { common } from '@kit.AbilityKit'


interface ob {
  name: string
  value: Array<string>
}

interface paramOB {
  name: string
  hex: string
  color: string
}

interface sliderOB {
  name: string
  min: number
  max: number
  color: string
  maxlength: number
  value: number
}

@Builder
export function transitionBuilder(name: string, param: Object) {
  colorTransition()
}

@Extend(Column)
function columnStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
    left: '20vp',
    right: '20vp'
  })
  .padding({ 'bottom': '5vp' })
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(TextInput)
function textInputStyle() {
  .backgroundColor('#00000000')
  // .backgroundColor('#eee')
  .borderWidth({ bottom: 1 }) //下边框，出来下划线的效果。
  .borderStyle(BorderStyle.Solid) //边框样式【Dashed】-虚线,【Dotted】.虚线，【Solid】实现
  .borderColor("#eee") //边框颜色

  .borderRadius(0)
  .padding(5)
  .fontColor('#888')
  .width("auto")
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
export struct colorTransition {
  valueChange(rgb: number[]) {
    const cmyk = colors.rgb2cmyk(rgb[0], rgb[1], rgb[2]);
    const lab = colors.rgb2lab(rgb[0], rgb[1], rgb[2]);
    const hsb = colors.rgb2hsb(rgb[0], rgb[1], rgb[2]);
    const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    this.hex = hex.replace('#', '');
    this.arr = [rgb, cmyk, lab, hsb];
    if (this.select < 4) {
      this.sliderValue = this.arr[this.select]
    }
  }

  rgbChange() {
    let r = this.sliderValue[0];
    let g = this.sliderValue[1];
    let b = this.sliderValue[2];
    this.valueChange([r, g, b]);
  }

  cmykChange() {
    let c = this.sliderValue[0];
    let m = this.sliderValue[1];
    let y = this.sliderValue[2];
    let k = this.sliderValue[3];
    // 设置分量值
    const rgb = colors.cmyk2rgb(c, m, y, k);
    const cmyk = [c, m, y, k];
    const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    const hsb = colors.rgb2hsb(rgb[0], rgb[1], rgb[2]);
    const lab = colors.rgb2lab(rgb[0], rgb[1], rgb[2]);
    this.sliderValue = cmyk;
    this.hex = hex.replace('#', '');
    this.arr = [rgb, cmyk, lab, hsb];
  }

  labChange() {
    let l = this.sliderValue[0];
    let a = this.sliderValue[1];
    let b = this.sliderValue[2];
    const rgb = colors.lab2rgb(l, a, b);
    this.valueChange(rgb);
  }

  hsbChange() {
    let h = this.sliderValue[0];
    let s = this.sliderValue[1];
    let b = this.sliderValue[2];
    const rgb = colors.hsb2rgb(h, s, b);
    this.valueChange(rgb);
  }

  selectChange() {
    if (this.select < 4) {
      this.sliderValue = this.arr[this.select]
    }
  }

  sliderChange() {
    switch (this.select) {
      case 0:
        this.rgbChange();
        break;
      case 1:
        this.cmykChange();
        break;
      case 2:
        this.labChange();
        break;
      case 3:
        this.hsbChange();
        break;
    }
  }

  sliderInput(value: string) {

    switch (this.select) {
      case 0:
        this.rgbChange();
        break;
      case 1:
        this.cmykChange();
        break;
      case 2:
        this.labChange();
        break;
      case 3:
        this.hsbChange();
        break;
    }
  }

  hexInput(text: string) {
    let h = text;
    if (h.length < 3 || h.length < 6) {
      this.arr = [[0, 0, 0], [0, 0, 0, 100], [0, 0, 0], [0, 0, 0]]
    }
    // 当颜色代码为 3 位缩写（如 #RGB）时，每一位数字会被扩展为 两位重复的数字
    if (h.length == 3) {
      h = h.split('').map(c => c + c).join('');
    }
    const rgb = colors.hex2rgb('#' + h);
    if (h.length == 3 || h.length == 6) {
      this.valueChange(rgb);
    }
    this.hex = text;
  }

  initialize() {

    let r = 0;
    let g = 0;
    let b = 0;
    r = Math.round(Math.random() * 255);
    g = Math.round(Math.random() * 255);
    b = Math.round(Math.random() * 255);
    this.valueChange([r, g, b]);

  }

  @State types: ob[] = [
    { name: 'RGB分类', value: ['R', 'G', 'B'] },
    { name: 'CMYK分量', value: ['C', 'M', 'Y', 'K'] },
    { name: 'Lab分量', value: ['L', 'a', 'b'] },
    { name: 'HSB分量', value: ['H', 'S', 'B'] }
  ]
  @State range: string[] = ['RGB', 'CMYK', 'Lab', 'HSB', 'HEX'];
  @State select: number = 0;
  @State sliderList: sliderOB[][] = [
    [{
      name: 'R',
      min: 0,
      max: 255,
      color: '#f00',
      maxlength: 3,
      value: 0
    }, {
      name: 'G',
      min: 0,
      max: 255,
      color: '#0f0',
      maxlength: 3,
      value: 0
    }, {
      name: 'B',
      min: 0,
      max: 255,
      color: '#00f',
      maxlength: 3,
      value: 0
    }],
    [{
      name: 'C',
      min: 0,
      max: 100,
      color: '#0ff',
      maxlength: 3,
      value: 0
    }, {
      name: 'M',
      min: 0,
      max: 100,
      color: '#f0f',
      maxlength: 3,
      value: 0
    }, {
      name: 'Y',
      min: 0,
      max: 100,
      color: '#ff0',
      maxlength: 3,
      value: 0
    }, {
      name: 'K',
      min: 0,
      max: 100,
      color: '#000',
      maxlength: 3,
      value: 0
    }],
    [{
      name: 'L',
      min: 0,
      max: 100,
      color: '#f00',
      maxlength: 3,
      value: 0
    }, {
      name: 'a',
      min: -128,
      max: 127,
      color: '#0f0',
      maxlength: 4,
      value: 0
    }, {
      name: 'b',
      min: -128,
      max: 127,
      color: '#2176d9',
      maxlength: 4,
      value: 0
    }],
    [{
      name: 'H',
      min: 0,
      max: 359,
      color: '#f00',
      maxlength: 3,
      value: 0
    }, {
      name: 'S',
      min: 0,
      max: 100,
      color: '#0f0',
      maxlength: 3,
      value: 0
    }, {
      name: 'B',
      min: 0,
      max: 100,
      color: '#00f',
      maxlength: 3,
      value: 0
    }],
  ]
  @StorageLink('navHideBackButton') navHideBackButton: boolean = false;
  @State sliderValue: number[] = [0, 0, 0, 0];
  @State hex: string = 'ffffff';
  @State param: paramOB = { name: '未知', hex: '#fff', color: '#fff' };
  @State arr: number[][] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ListItem() {
            Column() {
              Flex({
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
              }) {
                Text("模式选择").padding('5vp').fontColor('#888')
                Text(this.range[this.select]).padding('5vp').fontColor('#888')
                // 加载本地资源中的下箭头图片
                Image($r('app.media.arrow_down'))
                  .width(13)
                  .height(8)
              }.width('100%')
              .onClick((event) => {
                TextPickerDialog.show({
                  range: this.range,
                  selected: this.select,
                  onAccept: (value: TextPickerResult) => {
                    this.select = value.index as number
                    this.selectChange();
                  }
                })
              })

              ForEach(this.sliderList[this.select], (item: sliderOB, index) => {
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name + "：").fontColor('#888').width('42vp')
                  Slider({ min: item.min, max: item.max, value: this.sliderValue[index] })
                    .selectedColor(item.color)
                    .onChange((value: number) => {
                      item.value = value
                      this.sliderValue[index] = value
                      this.sliderChange();
                    })
                  TextInput({ text: this.sliderValue[index].toString() })
                    .textAlign(TextAlign.End)
                    .type(InputType.PhoneNumber)
                    .inputFilter('^-?[0-9]+$')
                    .textInputStyle()
                    .width('55.00vp')
                    .maxLength(item.maxlength)
                    .onChange((value: string) => {
                      if (value.length == 1 && value[0] == '-') {
                        return
                      }
                      this.sliderValue[index] = Number(value);
                      this.sliderInput(value);
                    })
                  if (this.select == 1 || this.select == 3) {
                    Text("%").fontColor('#888').margin({ left: '5vp' })
                  }
                }
              })
              if (this.select == 4) {
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.Center,
                }) {
                  Text("#").fontColor('#888')
                  TextInput({ text: this.hex })
                    .margin({ left: '10vp' })
                    .textInputStyle()
                    .width('70vp')
                    .maxLength(6)
                    .onChange((value: string) => {
                      this.hex = value
                      this.hexInput(value);
                    })
                }.margin('5vp')
              }


            }
            .columnStyle()
            .padding('30px')
          }

          ListItem() {
            Column() {
              Text("预览").padding('5vp').fontColor('#333')
              Flex().width('100%').height('50vp').backgroundColor(this.hex.length != 4 ? "#" + this.hex : '#fff')
                .onClick(() => {
                  copyText(this.hex)
                })
              Text("#" + this.hex).padding('5vp').fontColor('#333')
            }.columnStyle()
          }

          ListItem() {
            Column() {
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
            .columnStyle()
          }

        }
      }
    }
    .title('颜色转换')
    .hideBackButton(this.navHideBackButton)
    .onBackPressed(() => {
      if(this.navHideBackButton){
        let uiContext = getContext(this) as common.UIAbilityContext;
        uiContext.moveAbilityToBackground(); // 切换到后台
      }else {
        this.pathStack.clear();
      }
      return true
    })
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
