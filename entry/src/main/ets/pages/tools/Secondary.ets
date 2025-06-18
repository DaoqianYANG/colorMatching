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
export function secondaryBuilder(name: string, param: Object) {
  secondary()
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
export struct secondary {
  sliderChange(value: number, index: number) {
    let color = this.standard_color;
    let r = color?.red ?? 0;
    let g = color?.green ?? 0;
    let b = color?.blue ?? 0;
    let h = color?.h ?? 0;
    let saturation = color?.s ?? 0;
    let brightness = color?.b ?? 0;
    let rgb: number[] = [];
    switch (index) {
      case 0:
        r = value;
        break;
      case 1:
        g = value;
        break;
      case 2:
        b = value;
        break;
      case 3:
        console.log('333333')
        saturation = value;
        break;
      case 4:
        brightness = value;
        break;
    }
    if (index < 3) {
      this.valueChange(r, g, b);
    } else if (index >= 3) {
      rgb = colors.hsb2rgb(h, saturation, brightness);
      this.valueChange(rgb[0], rgb[1], rgb[2]);
    }

  }

  sliderInput(value: number, index: number) {
    this.sliderChange(value, index)
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
  render() {
    let render_color: ColorData[] = [];
    let red = this.standard_color?.red ?? 0;
    let green = this.standard_color?.green ?? 0;
    let blue = this.standard_color?.blue ?? 0;

    const r1 = Math.round(Math.random() * 255);
    const g1 = Math.round(Math.random() * 255);
    const b1 = Math.round(Math.random() * 255);
    const r2 = Math.round(Math.random() * 255);
    const g2 = Math.round(Math.random() * 255);
    const b2 = Math.round(Math.random() * 255);

    const hex1 = colors.rgb2hex(red, g1, b1);
    const hex2 = colors.rgb2hex(red, green, b2);
    const hex3 = colors.rgb2hex(r1, green, blue);
    const hex4 = colors.rgb2hex(r2, g2, blue);

    const hsb1 = colors.rgb2hsb(red, g1, b1);
    const hsb2 = colors.rgb2hsb(red, green, b2);
    const hsb3 = colors.rgb2hsb(r1, green, blue);
    const hsb4 = colors.rgb2hsb(r2, g2, blue);

    render_color.push({
      hex: hex1,
      red: red,
      green: g1,
      blue: b1,
      h: hsb1[0],
      s: hsb1[1],
      b: hsb1[2]
    });

    render_color.push({
      hex: hex2,
      red: red,
      green: green,
      blue: b2,
      h: hsb2[0],
      s: hsb2[1],
      b: hsb2[2]
    });

    render_color.push({
      hex: hex3,
      red: r1,
      green: green,
      blue: blue,
      h: hsb3[0],
      s: hsb3[1],
      b: hsb3[2]
    });

    render_color.push({
      hex: hex4,
      red: r2,
      green: g2,
      blue: blue,
      h: hsb4[0],
      s: hsb4[1],
      b: hsb4[2]
    });
    this.render_color = render_color;
  }

  valueChange(r: number, g: number, b: number) {
    let hsb = colors.rgb2hsbV2(r, g, b);
    const red = r;
    const green = g;
    const blue = b;
    this.standard_color = {
      hex: colors.rgb2hex(r, g, b),
      red: red,
      green: green,
      blue: blue,
      h: hsb[0],
      s: hsb[1],
      b: hsb[2]
    }
    if (this.isFirst) {
      this.isFirst = false;
      this.sliderValue = [red, green, blue, hsb[1], hsb[2]];
    }
    this.sliderValue = [red, green, blue, hsb[1], hsb[2]];
    console.log('this.sliderValue', JSON.stringify(this.sliderValue));
    console.log('this.standard_color', JSON.stringify(this.standard_color));
    this.render();
  }

  // 随机算法
  random_value() {
    const r = Math.round(Math.random() * 255);
    const g = Math.round(Math.random() * 255);
    const b = Math.round(Math.random() * 255);
    this.valueChange(r, g, b);
  }

  initialize() {
    this.isFirst = true;
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
      color: '#59b057',
      maxlength: 3,
      value: 0
    }];
  @State sliderValue: number[] = [0, 0, 0, 0, 0];
  isFirst: boolean = false;
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
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name).fontColor('#888').width('70vp')
                  Slider({ min: item.min, max: item.max, value: this.sliderValue[index] })
                    .selectedColor(item.color)
                    .onChange((value: number, mode: SliderChangeMode) => {
                      item.value = value
                      this.sliderValue[index] = value
                      this.sliderChange(value, index);
                    })
                  TextInput({ text: this.sliderValue[index].toString() })
                    .textAlign(TextAlign.End)
                    .type(InputType.PhoneNumber)
                    .inputFilter('^[0-9]+$')
                    .textInputStyle()
                    .width('55.00vp')
                    .maxLength(item.maxlength)
                    .onChange((value: string) => {
                      /*
                      * 鸿蒙对于 TextInput的.onChange和slider的.onChange绑定统一数据时，慎重！！！！
                      * 此处跟.onEditChange搭配
                       */
                      this.sliderValue[index] = Number(value);
                    })
                    .onEditChange((isEditing) =>{
                      // console.log(`编辑状态?:${isEditing}`)
                      this.sliderInput(this.sliderValue[index], index);
                    })

                }
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
              Text('配比色组').fontColor('#888').margin({ top: '10vp' }).padding('5vp')
              Row() {
                ForEach(this.render_color, (item: ColorData, index) => {
                  Flex({
                    direction: FlexDirection.Column,
                    justifyContent: FlexAlign.Center,
                    alignItems: ItemAlign.Center
                  }) {
                    Flex().width('60vp').height('60vp').backgroundColor(item.hex)
                    Text(item.hex).fontColor('#888').fontSize('13').padding({ top: '5vp' })
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
    .title('二次色配比')
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
