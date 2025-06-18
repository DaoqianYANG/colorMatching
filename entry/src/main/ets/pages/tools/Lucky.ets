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
import algorithm from '../../utils/Algorithm'


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
export function luckyBuilder(name: string, param: Object) {
  lucky()
}

@Extend(Row)
function rowStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
    left: '20vp',
    right: '20vp'
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
export struct lucky {
  selectChange() {
    this.render_color_board()
  }

  sliderChange(value: number,index: number) {
    const render_color = this.render_color;
    const color_index = this.select;
    let color: ColorData = render_color[color_index];
    let r = color?.red??0;
    let g = color?.green??0;
    let b = color?.blue??0;
    let h = color?.h??0;
    let saturation = color?.s??0;
    let brightness = color?.b??0;
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
        saturation = value;
        break;
      case 4:
        brightness = value;
        break;
    }
    if(index<3){
      const hex = colors.rgb2hex(r, g, b);
      const hsb = colors.rgb2hsb(r, g, b);
      color = { hex: hex, red: r, green: g, blue: b, h: hsb[0], s: hsb[1], b: hsb[2] };
      this.render_color[color_index] = color;
    }else if(index>=3){
      const rgb = colors.hsb2rgb(h, saturation, brightness);
      const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
      color = { hex: hex, red: rgb[0], green: rgb[1], blue: rgb[2], h: h, s: saturation, b: brightness };
      this.render_color[color_index] = color;
    }

  }

  sliderInput(value: number,index: number) {
    this.sliderChange(value,index)
  }

  copyAll() {
    let text = '配色方案：';
    for (let i = 0; i < 5; i++) {
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
  render(algorithm_index: number) {
    const r = Math.round(Math.random() * 255);
    const g = Math.round(Math.random() * 255);
    const b = Math.round(Math.random() * 255);
    let a = 20;
    let color: ColorData[] = []
    switch (this.algorithm[algorithm_index]) {
      case "analogous":
        a = Math.round(Math.random() * 100) % 52 + 20;
        color = algorithm.render_analogous(r, g, b, a);
        break;
      case "complementary":
        color = algorithm.render_complementary(r, g, b);
        break;
      case "triad":
        color = algorithm.render_triad(r, g, b);
        break;
      case "monochromatic":
        color = algorithm.render_monochromatic(r, g, b);
        break;
      case "shade":
        let p = Math.round(Math.random() * 50) - 25; // 随机比例
        let k = Math.round(Math.random() * 1) == 1 ? "lightness" : "saturation";
        color = algorithm.render_shade(r, g, b, p, k);
        break;
      case "secondary":
        color = algorithm.render_complementary(r, g, b);
        break;
      default:
        a = Math.round(Math.random() * 100) % 52 + 20;
        color = algorithm.render_analogous(r, g, b, a);
        break;
    }
    const hex = colors.rgb2hex(r, g, b);
    const hsb = colors.rgb2hsb(r, g, b);
    let render_color: ColorData[] = [{
      hex: hex,
      red: r,
      green: g,
      blue: b,
      h: hsb[0],
      s: hsb[1],
      b: hsb[2]
    }];
    render_color = render_color.concat(color);
    this.render_color = render_color;
    this.render_color_board();
  }

  render_color_board() {
    const r = this.render_color?.[this.select]?.red ?? 0;
    const g = this.render_color[this.select]?.green ?? 0;
    const b = this.render_color[this.select]?.blue ?? 0;
    const saturation = this.render_color[this.select]?.s ?? 0;
    const brightness = this.render_color[this.select]?.b ?? 0;
    this.sliderValue = [r, g, b, saturation, brightness];
  }

  // 随机算法
  random_value() {
    this.select = 0;

    const length = this.algorithm.length - 1;
    const algorithm_index = Math.round(Math.random() * length);
    this.render(algorithm_index);
  }

  initialize() {

    this.select = 0;
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
  @State range: string[] = ['颜色1', '颜色2', '颜色3', '颜色4', '颜色5'];
  @State select: number = 0;
  @State algorithm_index: number = 0; // 算法索引
  @State algorithm: string[] = ["analogous", "complementary", "triad", "monochromatic", "shade", "secondary"]; // 颜色算法
  @State sliderValue: number[] = [0, 0, 0, 0, 0];
  @State render_color: ColorData[] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ListItem() {
            Row() {
              ForEach(this.render_color, (item: ColorData, index) => {
                Flex({
                  direction: FlexDirection.Column,
                  justifyContent: FlexAlign.Center,
                  alignItems: ItemAlign.Center
                }) {
                  Flex().width('20%').height('60vp').backgroundColor(item.hex)
                  Text(item.hex).fontColor('#888').fontSize('13').padding({ top: '5vp' })
                }
                .onClick((event) => {
                  this.pathStack.pushPathByName('ColorDetail', item);
                })
              })
            }
            .rowStyle()
          }


          ListItem() {
            Column() {
              Flex({
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
              }) {
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

              ForEach(this.sliderList, (item: sliderOB, index) => {
                Flex({
                  alignItems: ItemAlign.Center,
                  justifyContent: FlexAlign.SpaceBetween,
                }) {
                  Text(item.name).fontColor('#888').width('70vp')
                  Slider({ min: item.min, max: item.max, value: this.sliderValue[index] })
                    .selectedColor(item.color)
                    .onChange((value: number) => {
                      item.value = value
                      this.sliderValue[index] = value
                      this.sliderChange(value,index);
                    })
                  TextInput({ text: this.sliderValue[index].toString() })
                    .textAlign(TextAlign.End)
                    .type(InputType.PhoneNumber)
                    .inputFilter('^[0-9]+$')
                    .textInputStyle()
                    .width('55.00vp')
                    .maxLength(item.maxlength)
                    .onChange((value: string) => {
                      this.sliderValue[index] = Number(value);
                      this.sliderInput(Number(value),index);
                    })

                }
              })
            }
            .columnStyle()
            .padding('30px')
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
    .title('I am Feeling Lucky')
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
