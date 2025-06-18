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


interface sliderOB {
  name: string
  min: number
  max: number
  color: string
  maxlength: number
  value: number
}

// 颜色数据结构
interface ColorData {
  hex: string;
  percent?: string;
  red?: number;
  green?: number;
  blue?: number;
  h?: number;
  s?: number;
  b?: number;
}

@Builder
export function shadeBuilder(name: string, param: Object) {
  shade()
}

@Extend(Row)
function rowStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
  })
  .padding({ top: '10vp', bottom: '5vp' })
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(Column)
function columnStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
  })
  .padding({ 'bottom': '5vp' })
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(Button)
function btnStyle() {
  .height('30vp')
  .fontSize('14vp')
  .width('80vp')
}

@Extend(TextInput)
function textInputStyle() {
  .backgroundColor('#00000000')
  .borderWidth({ bottom: 1 }) //下边框，出来下划线的效果。
  .borderStyle(BorderStyle.Solid) //边框样式【Dashed】-虚线,【Dotted】.虚线，【Solid】实现
  .borderColor("#eee") //边框颜色

  .borderRadius(0)
  .padding(5)
  .fontColor('#888')
  .width("auto")
}


interface GeneratedTypeLiteralInterface_1 {
  name: string;
  colors: Array<string>;
}


@Component
export struct shade {
  sliderChange(value: number, index: number) {
    let color = this.standard_color;
    let r = color?.red ?? 0;
    let g = color?.green ?? 0;
    let b = color?.blue ?? 0;
    let p = this.percent;
    let kind = this.kind;
    switch (index) {
      case 0:
        r = value;
        this.valueChange(r, g, b, p, kind);
        break;
      case 1:
        g = value;
        this.valueChange(r, g, b, p, kind);
        break;
      case 2:
        b = value;
        this.valueChange(r, g, b, p, kind);
        break;
      case 3:
        p = value;
        this.valueChange(r, g, b, p, kind);
        break;
    }
  }

  sliderInput(value: number, index: number) {
    this.sliderChange(value, index)
  }

  radioChange() {
    let color = this.standard_color;
    let r = color?.red ?? 0;
    let g = color?.green ?? 0;
    let b = color?.blue ?? 0;
    let p = this.percent;
    let kind = this.kind;
    this.valueChange(r, g, b, p, kind);
  }

  copy(text: string) {
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

  copyAll() {
    let text = '基准色：' + this.standard_color.hex + ', 配比色组：';
    for (let i = 0; i < this.render_color.length; i++) {
      text += this.render_color[i].hex + ','
    }
    text = text.substring(0, text.lastIndexOf(','));
    const pasteboardData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, text)
    const systemPasteboard = pasteboard.getSystemPasteboard()
    // 将数据放入剪切板
    systemPasteboard.setData(pasteboardData, (err, data) => {
      if (err) {
        promptAction.showToast({ message: "复制配色方案失败" })
        return;
      }
      promptAction.showToast({ message: "复制配色方案成功" })
    });
  }

  // 生成颜色数组
  render(r: number, g: number, b: number, percent: number, kind: string) {
    let render_color: ColorData[] = [];
    let red = this.standard_color?.red ?? 0;
    let green = this.standard_color?.green ?? 0;
    let blue = this.standard_color?.blue ?? 0;
    const hsb = colors.rgb2hsb(red, green, blue);
    const hue = hsb[0];
    const saturation = hsb[1];
    const lightness = hsb[2];
    for (let i = 1; i <= 4; i++) {
      let l = lightness;
      let s = saturation;
      if (kind == "lightness") {
        l = lightness + percent * i;
        l = l > 100 ? 100 : l;
        l = l < 0 ? 0 : l;
      } else {
        s = saturation + percent * i;
        s = s > 100 ? 100 : s;
        s = s < 0 ? 0 : s;
      }
      const rgb = colors.hsb2rgb(hue, s, l);
      const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
      render_color.push({ hex: hex, percent: percent * i + "%" });
    }
    this.render_color = render_color;
  }

  valueChange(r: number, g: number, b: number, p: number, kind: string) {
    const red = r;
    const green = g;
    const blue = b;
    this.standard_color = {
      hex: colors.rgb2hex(r, g, b),
      red: red,
      green: green,
      blue: blue,
      percent: p.toString()
    }
    this.sliderValue = [red, green, blue, p]
    this.render(r, g, b, p, kind)
  }

  // 随机算法
  random_value() {
    const r = Math.round(Math.random() * 255);
    const g = Math.round(Math.random() * 255);
    const b = Math.round(Math.random() * 255);
    const p = Math.round(Math.random() * 50) - 25; // 随机比例
    this.percent = p;
    this.valueChange(r, g, b, this.percent, this.kind);
  }

  initialize() {

    this.random_value();
  }

  @State sliderList: sliderOB[] =
    [{
      name: 'R:',
      min: 0,
      max: 255,
      color: '#f00',
      maxlength: 3,
      value: 0
    }, {
      name: 'G:',
      min: 0,
      max: 255,
      color: '#0f0',
      maxlength: 3,
      value: 0
    }, {
      name: 'B:',
      min: 0,
      max: 255,
      color: '#00f',
      maxlength: 3,
      value: 0
    }, {
      name: '比例',
      min: -25,
      max: 25,
      color: 'rgb(233,233,233)',
      maxlength: 3,
      value: 0
    }];
  @State sliderValue: number[] = [0, 0, 0, 0];
  @State kind: string = "lightness"; // 勾选的单选框
  @State percent: number = 0;
  @State standard_color: ColorData = {
    hex: ''
  };
  @State render_color: ColorData[] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ListItem() {
            Column() {
              ForEach(this.sliderList, (item: sliderOB, index) => {
                if (index === 3) {
                  Flex({
                    alignItems: ItemAlign.Center,
                    justifyContent: FlexAlign.Start,
                  }) {
                    Text('调整').fontColor('#888').width('49vp')
                    Row() {
                      Radio({ value: 'Radio1', group: 'radioGroup' })
                        .onChange((isChecked: boolean) => {
                          if (isChecked) {
                            this.kind = 'lightness';
                            this.radioChange();
                          }
                        }).checked(true)
                      Text('亮度').fontColor('#888').margin({ right: '50vp' })
                      Radio({ value: 'Radio2', group: 'radioGroup' })
                        .onChange((isChecked: boolean) => {
                          if (isChecked) {
                            this.kind = 'saturation';
                            this.radioChange();
                          }
                        })
                      Text('饱和度').fontColor('#888')
                    }

                  }.width('100%')
                }
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name).fontColor('#888').width('49vp')
                  Slider({ min: item.min, max: item.max, value: this.sliderValue[index] })// .width('69%')
                    .selectedColor(item.color)
                    .onChange((value: number) => {
                      item.value = value
                      this.sliderValue[index] = value
                      this.sliderChange(value, index);
                    })
                  TextInput({ text: this.sliderValue[index].toString() })
                    .textAlign(TextAlign.End)
                    .type(InputType.PhoneNumber)
                    .inputFilter('^-?[0-9]+$')
                    .textInputStyle()
                    .width('55.00vp')
                    .maxLength(item.maxlength)
                    .onChange((value: string) => {
                      this.sliderValue[index] = Number(value);
                      this.sliderInput(Number(value), index);
                    })
                }
                .width('100%')
              })
            }
            .columnStyle()
            .padding('30px')
          }

          ListItem() {
            Column() {
              Text("基准色").margin({ top: '10vp' }).padding('5vp').fontColor('#888')
              Flex().width('100%').height('50vp').backgroundColor(this.standard_color.hex)
                .onClick(() => {
                  this.copy(this.standard_color.hex)
                })
              Text(this.standard_color.hex).padding('5vp').fontColor('#888')
            }.columnStyle()
          }

          ListItem() {
            Column() {
              Text('渐变色组').fontColor('#888').margin({ top: '10vp' }).padding('5vp')
              Row() {
                ForEach(this.render_color, (item: ColorData, index) => {
                  Flex({
                    direction: FlexDirection.Column,
                    justifyContent: FlexAlign.Center,
                    alignItems: ItemAlign.Center
                  }) {
                    Flex().width('60vp').height('60vp').backgroundColor(item.hex)
                    Text(item.hex).fontColor('#888').fontSize('13').padding({ top: '5vp' })
                    Text(item.percent).fontColor('#888').fontSize('13').padding({ top: '5vp' })
                  }
                  .onClick((event) => {
                    this.pathStack.pushPathByName('ColorDetail', item);
                  })
                })
              }.width('100%').justifyContent(FlexAlign.SpaceAround)
            }.columnStyle()
          }

          ListItem() {
            Row({}) {
              Button('收藏')
                .onClick(() => {
                  let arr: string[] = [];
                  this.render_color.forEach(item => {
                    arr.push(item.hex);
                  });
                  let obj = {
                    name: '',
                    colors: arr
                  } as GeneratedTypeLiteralInterface_1;
                  this.pathStack.pushPathByName('fav', obj);
                })
                .btnStyle()
                .backgroundColor('#e864b3')

              Button('随机')
                .onClick(() => {
                  this.random_value()
                })
                .btnStyle()
                .backgroundColor('#5e96d1')
              Button('复制')
                .onClick(() => {
                  this.copyAll()
                })
                .btnStyle()
                .backgroundColor('#09bb07')
            }
            .width('calc(100% - 40vp)')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({
              top: '30px',
              bottom: '20',
              left: '20vp',
              right: '20vp'
            })
          }

        }
      }
    }
    .title('渐变')
    .backgroundColor('#f8f8f8')
    .height('100%')
    .width('100%')
    .padding({ top: 35 })
    .onReady((ctx: NavDestinationContext) => {
      this.pathStack = ctx.pathStack;
      try {
        this.initialize();
      } catch (e) {
      }
    })

  }
}
