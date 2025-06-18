/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
import colors from '../../utils/ColorUtil'
import KVStore from '../../utils/KVStore'
import { KVStoreType } from '../../viewmodel/KVStoreType'
import { distributedKVStore } from '@kit.ArkData'
import { promptAction } from '@kit.ArkUI'
import { systemDateTime } from '@kit.BasicServicesKit'


interface value_ob {
  name: string
  colors: string[]
  time?: string
}

interface paramOB {
  key: string
  name: string
  colors: string[]
  time?: string
}
interface colorDetail {
  hex: string
  rgb: number[]
  hsb: number[]
}

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

@Extend(Button)
function btnStyle() {
  .height('30vp')
  .fontSize('14vp')
  .width('100%')
  .borderRadius(0)
}


@Builder
export function favEditBuilder(name: string, param: Object) {
  Index()
}


@Component
export struct Index {
  selectChange() {
    this.render_color_board()
  }

  sliderChange(value: number, index: number) {
    const render_color = this.render_color;
    const color_index = this.select;
    let color: ColorData = render_color[color_index];
    let r = color?.red ?? 0;
    let g = color?.green ?? 0;
    let b = color?.blue ?? 0;
    let h = color?.h ?? 0;
    let saturation = color?.s ?? 0;
    let brightness = color?.b ?? 0;
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
    if (index < 3) {
      const hex = colors.rgb2hex(r, g, b);
      const hsb = colors.rgb2hsb(r, g, b);
      color = {
        hex: hex,
        red: r,
        green: g,
        blue: b,
        h: hsb[0],
        s: hsb[1],
        b: hsb[2]
      };
      this.render_color[color_index] = color;
    } else if (index >= 3) {
      const rgb = colors.hsb2rgb(h, saturation, brightness);
      const hex = colors.rgb2hex(rgb[0], rgb[1], rgb[2]);
      color = {
        hex: hex,
        red: rgb[0],
        green: rgb[1],
        blue: rgb[2],
        h: h,
        s: saturation,
        b: brightness
      };
      this.render_color[color_index] = color;
    }

  }
  upDateCdList() {
    let arr: colorDetail[] = [];
    const hexList: string[] = this.param.colors;
    for (let i = 0; i < hexList.length; i++) {
      let hex = hexList[i];
      let rgb = colors.hex2rgb(hex);
      let hsb = colors.rgb2hsb(rgb[0], rgb[1], rgb[2]);
      arr.push({ hex: hex, rgb: rgb, hsb: hsb })
    }
    this.cdList = arr;

  }

  sliderInput(value: number, index: number) {
    this.sliderChange(value, index)
  }

  render_color_board() {
    const r = this.render_color[this.select]?.red ?? 0;
    const g = this.render_color[this.select]?.green ?? 0;
    const b = this.render_color[this.select]?.blue ?? 0;
    const saturation = this.render_color[this.select]?.s ?? 0;
    const brightness = this.render_color[this.select]?.b ?? 0;
    this.sliderValue = [r, g, b, saturation, brightness];
  }

  async save() {
    if (!this.name) {
      promptAction.showToast({ message: "请输入配色名称", alignment: Alignment.Center });
      return
    }
    const timestamp = systemDateTime.getTime();
    const currentTime = this.formatTime(timestamp);
    let key = this.param.key;
    const obj: value_ob = {
      name: this.name,
      time: currentTime,
      colors: this.param.colors
    }
    let value = JSON.stringify(obj);
    this.param.name = this.name;
    let arr: string[] = [];
    this.render_color.forEach(item =>{
      arr.push(item.hex)
    })
    this.param.colors = arr;
    this.upDateCdList();
    AppStorage.setOrCreate('saveParam', this.param);
    setTimeout(async () => {
      await this.kvStore?.put(key, value).then((data: string) => {
        if (data == 'Succeed') {
          promptAction.showToast({ message: "修改成功", alignment: Alignment.Center });
          setTimeout(() => {
            this.pathStack.pop();
          }, 300)

        }
      })
    }, 200)
  }

  private formatTime(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份补零
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    const second = date.getSeconds().toString().padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}:${second}`;
  }

  async aboutToAppear() {
    let encrypted = false; //加密状态
    const securityLevel: distributedKVStore.SecurityLevel = distributedKVStore.SecurityLevel.S1; //风险等级低
    const UIContext = this.getUIContext();
    this.kvStoreAll = [];
    this.kvStore = undefined;
    this.kvStore = new KVStore(encrypted, securityLevel, UIContext);
  }

  initialize() {
    let arr: ColorData[] = [];
    const hexList: string[] = this.param.colors;
    // console.log('hexList,,,', hexList);
    this.name = this.param.name;
    let ranges: string[] = [];
    for (let i = 0; i < hexList.length; i++) {
      let hex = hexList[i];
      let rgb = colors.hex2rgb(hex);
      let hsb = colors.rgb2hsb(rgb[0], rgb[1], rgb[2]);
      ranges.push('颜色' + (i + 1));
      arr.push({
        hex: hex,
        red: rgb[0],
        green: rgb[1],
        blue: rgb[2],
        h: hsb[0],
        s: hsb[1],
        b: hsb[2]
      })
    }
    this.range = ranges;
    this.render_color = arr;
    this.render_color_board()
  }

  @State sliderList: sliderOB[] = [
    {
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

  @StorageLink('kvStore') kvStore: KVStore | undefined = undefined;
  @StorageLink('kvStoreAll') kvStoreAll: KVStoreType[] = [];
  @State param: paramOB = {
    name: '未知', colors: [],
    key: ''
  };
  @StorageLink('cdList') cdList: colorDetail[] = [];
  @State range: string[] = ['颜色1', '颜色2', '颜色3', '颜色4', '颜色5'];
  @State select: number = 0;
  @State sliderValue: number[] = [0, 0, 0, 0, 0];
  @State render_color: ColorData[] = [];
  @State pathStack: NavPathStack = new NavPathStack();
  @State name: string = '';
  @State isLoading:boolean = false;
  build() {
    NavDestination() {
      List({ space: 0 }) {
        ListItem() {
          Row() {
            Flex({
              justifyContent: FlexAlign.Center,
              alignItems: ItemAlign.Center
            }) {
              Text("命名:").fontColor('#888')
              TextInput({ text: this.name, placeholder: '请输入配色名称' })
                .inputFilter('^[\u4e00-\u9fa5a-zA-Z0-9_-]+$')
                .maxLength(20)
                .margin({ left: '10vp' })
                .textInputStyle()
                .border({
                  width: { bottom: 1 },
                  style: BorderStyle.Solid,
                  color: 'paleturquoise'
                })
                .width('60%')
                .onChange((value: string) => {
                  this.name = value
                })
            }.width('100%')
          }
          .rowStyle()
        }

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
                    this.sliderValue[index] = Number(value);
                    this.sliderInput(Number(value), index);
                  })
              }
            })
          }
          .columnStyle()
          .padding('30px')

        }
      }.margin({ bottom: 50 })

      Button(this.isLoading ? '处理中...' : '保存', { type: ButtonType.Normal })
        .enabled(!this.isLoading)
        .onClick(() => {
          //防止连续点击
          if (this.isLoading) {
            return;
          }

          this.isLoading = true;
          this.save();

          setTimeout(() => {
            this.isLoading = false;
          }, 500);
        })
        .btnStyle()
        .backgroundColor('#4c6cb3')
        .width('100%')
        .position({ x: 0, y: '85%' }) // 定位到底部
    }
    .padding({ bottom: 15 })
    .title('编辑收藏')
    .height('100%')
    .width('100%')
    .backgroundColor('#eee')
    .padding({ top: 35 })
    .onReady((ctx: NavDestinationContext) => {
      this.pathStack = ctx.pathStack;
      const obj = (ctx.pathInfo.param as paramOB);
      if (!obj.key) {
        ctx.pathStack.pop();
      }
      this.param = obj;
      this.initialize();
    })

  }
}