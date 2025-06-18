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
  angle?: number,
  h?: number;
  s?: number;
  b?: number;
}

@Builder
export function complementaryBuilder(name: string, param: Object) {
  complementary()
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
export struct complementary {
  sliderChange(value: number, index: number) {
    const color = this.standard_color;
    let r = color?.red ?? 0;
    let g = color?.green ?? 0;
    let b = color?.blue ?? 0;
    switch (index) {
      case 0:
        r = value;
        this.valueChange(r, g, b);
        break;
      case 1:
        g = value;
        this.valueChange(r, g, b);
        break;
      case 2:
        b = value;
        this.valueChange(r, g, b);
        break;
    }
  }

  slider2Change(value: number, index: number) {
    let temp = this.render_color;
    // 原始颜色
    const color = this.render_color[this.check_index];
    let h = color?.h ?? 0;
    let s = color?.s ?? 0;
    let b = color?.b ?? 0;
    switch (index) {
      case 0:
        s = value;
        break;
      case 1:
        b = value;
        break;
    }
    const rgb = colors.hsb2rgb(h, s, b);
    const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    temp[this.check_index] = {
      hex: hex,
      red: rgb[0],
      green: rgb[1],
      blue: rgb[2],
      h: h,
      s: s,
      b: b
    };
    this.render_color = temp;
    this.slider2Value = [s, b];
  }

  sliderInput(value: number, index: number) {
    this.sliderChange(value, index)
  }

  slider2Input(value: number, index: number) {
    this.slider2Change(value, index)
  }

  radioChange(index: number) {
    this.check_index = index;
    const s = this.render_color[index]?.s ?? 0;
    const b = this.render_color[index]?.b ?? 0;
    this.slider2Value = [s, b];
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
    let text = '基准色：' + this.standard_color.hex + ', 辅色+补色组：';
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

  // 计算补色
  render(r: number, g: number, b: number) {
    let render_color: ColorData[] = [];
    const hsl = colors.rgb2hsb(r, g, b);
    const h = hsl[0];
    const s = hsl[1];
    const l = hsl[2];
    // 变化基数 = 10
    const hue_base = s < 50 ? 10 : -10;

    // 辅色 H变化，S，B和主色一样
    let new_h = (h + hue_base) % 360;
    let rgb = colors.hsb2rgb(new_h, s, l);
    let hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    render_color.push({
      hex: hex,
      red: rgb[0],
      green: rgb[1],
      blue: rgb[2],
      h: new_h,
      s: s,
      b: l
    });

    // 补色1 H + 180， S、B和主色一样
    new_h = (h + 180) % 360;
    rgb = colors.hsb2rgb(new_h, s, l);
    hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    render_color.push({
      hex: hex,
      red: rgb[0],
      green: rgb[1],
      blue: rgb[2],
      h: new_h,
      s: s,
      b: l
    });

    // 补色2
    new_h = (h + 180 + hue_base) % 360;
    rgb = colors.hsb2rgb(new_h, s, l);
    hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    render_color.push({
      hex: hex,
      red: rgb[0],
      green: rgb[1],
      blue: rgb[2],
      h: new_h,
      s: s,
      b: l
    });

    // 补色3
    new_h = (h + 180 - hue_base) % 360;
    rgb = colors.hsb2rgb(new_h, s, l);
    hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
    render_color.push({
      hex: hex,
      red: rgb[0],
      green: rgb[1],
      blue: rgb[2],
      h: new_h,
      s: s,
      b: l
    });
    this.render_color = render_color;
  }



  valueChange(r: number, g: number, b: number) {
    const hsb = colors.rgb2hsb(r, g, b);
    const hex = colors.rgb2hex(r, g, b);
    const red = r;
    const green = g;
    const blue = b;
    const saturation = hsb[1];
    const brightness = hsb[2];
    const length = this.sliderList.length;
    this.sliderList[length-1].color = hex;
    this.standard_color = {
      red: red,
      green: green,
      blue: blue,
      hex: hex,
      s: saturation,
      b: brightness,
    }
    this.sliderValue = [red, green, blue]
    this.slider2Value = [saturation, brightness]
    this.render(r, g, b)
  }

  // 随机算法
  random_value() {
    const r = Math.round(Math.random() * 255);
    const g = Math.round(Math.random() * 255);
    const b = Math.round(Math.random() * 255);
    this.valueChange(r, g, b);
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
      name: '饱和度',
      min: 0,
      max: 100,
      color: '#59b057',
      maxlength: 3,
      value: 0
    }, {
      name: '亮度',
      min: 0,
      max: 100,
      color: '#888',
      maxlength: 3,
      value: 0
    }];
  @State sliderValue: number[] = [0, 0, 0];
  @State slider2Value: number[] = [0, 0];
  @State check_index: number = 0; // 勾选的单选框
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
              ForEach(this.sliderList.slice(0, 3), (item: sliderOB, index) => {
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name).fontColor('#888').width('70vp')
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
                .width('100%').padding({ left: '10vp', right: '10vp' })
              })
            }
            .columnStyle()
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
              Text('辅色 + 补色组').fontColor('#888').margin({ top: '10vp' }).padding('5vp')
              Row() {
                ForEach(this.render_color, (item: ColorData, index) => {
                  Flex({
                    direction: FlexDirection.Column,
                    justifyContent: FlexAlign.Center,
                    alignItems: ItemAlign.Center
                  }) {
                    Flex().width('60vp').height('60vp').backgroundColor(item.hex)
                      .onClick((event) => {
                        this.pathStack.pushPathByName('ColorDetail', item);
                      })
                    Row() {
                      Radio({ value: index.toString(), group: 'radioGroup' })
                        .radioStyle({
                          checkedBackgroundColor: item.hex
                        })
                        .onChange((isChecked: boolean) => {
                          if (isChecked) {
                            this.radioChange(index);
                          }
                        })
                        .checked(this.check_index == index).size({ width: 13, height: 13 })
                      Text(item.hex).fontColor('#888').fontSize('12')
                    }.justifyContent(FlexAlign.Start).alignItems(VerticalAlign.Center).margin({ top: '5vp' })

                    // .onClick((event) => {
                    //   this.radioChange(index);
                    // })

                  }

                })
              }.width('100%').justifyContent(FlexAlign.SpaceAround)
            }.columnStyle()
          }

          ListItem() {
            Column() {
              Text("调整补色").margin({ top: '10vp' }).padding('5vp').fontColor('#888')
              ForEach(this.sliderList.slice(3, 5), (item: sliderOB, index) => {
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name).fontColor('#888').width('70vp')
                  Slider({ min: item.min, max: item.max, value: this.slider2Value[index] })// .width('69%')
                    .selectedColor(item.color)
                    .onChange((value: number) => {
                      item.value = value
                      this.slider2Change(value, index);
                    })
                  TextInput({ text: this.slider2Value[index].toString() })
                    .textAlign(TextAlign.End)
                    .type(InputType.PhoneNumber)
                    .inputFilter('^-?[0-9]+$')
                    .textInputStyle()
                    .width('55.00vp')
                    .maxLength(item.maxlength)
                    .onChange((value: string) => {
                      this.slider2Value[index] = Number(value);
                      this.slider2Input(Number(value), index);
                    })
                }
                .width('100%').padding({ left: '10vp', right: '10vp' })
              })
            }
            .columnStyle()
          }

          ListItem() {
            Row({}) {
              Button('收藏')
                .onClick(() => {
                  let arr:string[] = [];
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
    .title('互补色')
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
