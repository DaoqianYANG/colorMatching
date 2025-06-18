/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
import colors from '../../utils/ColorUtil'
import { promptAction } from '@kit.ArkUI'
import KVStore from '../../utils/KVStore'
import { distributedKVStore } from '@kit.ArkData'
import { KVStoreType } from '../../viewmodel/KVStoreType'
import { systemDateTime } from '@kit.BasicServicesKit'


interface paramOB {
  name: string
  colors: string[]
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

interface value_ob {
  name: string,
  time: string;
  colors: string[];
}

@Extend(Row)
function rowStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20',
    left: '20vp',
    right: '20vp'
  })
  .padding({ top: '10vp', bottom: '5vp' })

}


@Extend(TextInput)
function textInputStyle() {
  .backgroundColor('#00000000')

  .border({
    width: { bottom: 1 },
    style: BorderStyle.Solid,
    color: 'paleturquoise'
  })
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
export function favBuilder(name: string, param: Object) {
  Index()
}


@Component
export struct Index {
  async save() {
    if (!this.name) {
      promptAction.showToast({ message: "请输入配色名称", alignment: Alignment.Center });
      return
    }
    const timestamp = systemDateTime.getTime();
    const currentTime = this.formatTime(timestamp);
    let key = 'myFav' + currentTime + '-' + Math.round(Math.random() * 999);
    const obj: value_ob = {
      name: this.name,
      time: currentTime,
      colors: this.param.colors
    }
    let value = JSON.stringify(obj);
    setTimeout(async () => {
      await this.kvStore?.put(key, value).then((data: string) => {
        if (data == 'Succeed') {
          promptAction.showToast({ message: "收藏成功", alignment: Alignment.Center });
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
    this.name = this.param.name;
    for (let i = 0; i < hexList.length; i++) {
      let hex = hexList[i];
      let rgb = colors.hex2rgb(hex);
      let hsb = colors.rgb2hsb(rgb[0], rgb[1], rgb[2]);
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
    this.render_color = arr;
  }

  @StorageLink('kvStore') kvStore: KVStore | undefined = undefined;
  @StorageLink('kvStoreAll') kvStoreAll: KVStoreType[] = [];
  @State param: paramOB = { name: '未知', colors: [] };
  @State render_color: ColorData[] = [];
  @State pathStack: NavPathStack = new NavPathStack();
  @State name: string = '';
  @State isLoading: boolean = false;

  build() {
    NavDestination() {
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
                .width('60%')
                .onChange((value: string) => {
                  this.name = value
                })
            }.width('100%')
          }
          .rowStyle()
        }

        ListItem() {
          Column() {
            Text('1、配色名称仅支持中文、英文、数字、短横线和下划线。').width('100%').margin(10)
            Text('2、配色名称限定20个字符以内。').width('100%')
          }.justifyContent(FlexAlign.Start)
          .backgroundColor('#FFFFFF')
          .margin({
            top: 20,
            left: '20vp',
            right: '20vp'
          })
          .padding(15)
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
    .title('新增收藏')
    .height('100%')
    .width('100%')
    // .backgroundColor('#eee')
    .padding({ top: 35 })
    .onReady((ctx: NavDestinationContext) => {
      this.pathStack = ctx.pathStack;
      const obj = (ctx.pathInfo.param as paramOB);

      if (!obj.colors) {
        ctx.pathStack.pop();
      }
      this.param = obj;
      this.initialize();
    })

  }
}