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
import { distributedKVStore } from '@kit.ArkData'
import KVStore from '../../utils/KVStore'
import { KVStoreType } from '../../viewmodel/KVStoreType'

interface ob {
  key: string
  name: string
  colors: string[]
  time?: string
}

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

@Extend(Button)
function btnStyle() {
  .height('30vp')
  .fontSize('14vp')
  .width('33.33%')
  .borderRadius(0)
}

@Builder
export function favDetailBuilder(name: string, param: Object) {
  Index()
}


@Component
export struct Index {
  initialize() {
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

  copyAll() {
    let text = '';
    for (let i = 0; i < this.cdList.length; i++) {
      text += this.cdList[i].hex + ','
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

  async aboutToAppear() {
    let encrypted = false; //加密状态
    const securityLevel: distributedKVStore.SecurityLevel = distributedKVStore.SecurityLevel.S1; //风险等级低
    const UIContext = this.getUIContext();
    this.kvStoreAll = [];
    this.kvStore = undefined;
    this.kvStore = new KVStore(encrypted, securityLevel, UIContext);
  }

  upDateListTest() {
    setTimeout(async () => {
      await this.kvStore?.getAll().then((data: KVStoreType[]) => {
        this.kvStoreAll = data;
        let arr: ob[] = [];
        for (let i = 0; i < data.length; i++) {
          if (typeof data[i]?.value === 'string') {
            const key = data[i].key;
            const item = data[i]?.value as string;
            const obj: value_ob = JSON.parse(item);
            arr.push({
              key: key,
              name: obj.name,
              colors: obj.colors,
              time: obj.time
            })
          }
        }
        this.listTest = arr;

      });
    }, 300)
  }

  delete() {
    this.kvStore?.delete(this.param.key)
    promptAction.showToast({ message: "删除成功", alignment: Alignment.Center });
    this.upDateListTest();
    this.pathStack.pop();

  }

  @StorageLink('listTest') listTest: ob[] = [];
  @StorageLink('kvStore') kvStore: KVStore | undefined = undefined;
  @StorageLink('kvStoreAll') kvStoreAll: KVStoreType[] = [];
  @StorageLink('saveParam') param: paramOB = {
    name: '未知', colors: [],
    key: ''
  };
  @StorageLink('cdList') @Watch("upDateListTest") cdList: colorDetail[] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Text(this.param.name).fontSize(18).fontWeight(FontWeight.Bold).margin({ bottom: 20 })
        List({ space: 0 }) {
          ForEach(this.cdList, (item: colorDetail, index) => {
            ListItem() {
              Row() {
                Flex()
                  .backgroundColor(item.hex)
                  .height(80)
                  .width(80)
                  .margin({ right: 10 })
                  .onClick((event) => {
                    this.pathStack.pushPathByName('ColorDetail', item);
                  })
                Column() {
                  Row() {
                    Text('R: ' + item.rgb[0]).width('20%')
                    Text('G: ' + item.rgb[1]).width('20%')
                    Text('B: ' + item.rgb[2]).width('20%')
                  }.margin({ bottom: 10 })

                  Row() {
                    Text('H: ' + item.hsb[0]).width('20%')
                    Text('S: ' + item.hsb[1] + '%').width('20%')
                    Text('B: ' + item.hsb[2] + '%').width('20%')
                  }
                }
              }.justifyContent(FlexAlign.Start).width('100%').height(80)
            }
          })
        }
        .alignListItem(ListItemAlign.Center)
        .margin({ bottom: 80 })

        Row() {
          Button('复制', { type: ButtonType.Normal })
            .onClick(() => {
              this.copyAll()
            })
            .btnStyle()
            .backgroundColor('#09bb07')

          Button('编辑', { type: ButtonType.Normal })
            .onClick(() => {
              this.pathStack.pushPathByName('favEdit', this.param);
            })
            .btnStyle()
            .backgroundColor('#2ca9e1')
          Button('删除', { type: ButtonType.Normal })
            .onClick(() => {
              this.getUIContext().showAlertDialog(
                {
                  title: '提示',
                  message: '删除配色方案 ' + this.param.name,
                  autoCancel: true, //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
                  // alignment: DialogAlignment.Center, //对齐位置
                  gridCount: 3,
                  buttons: [{
                    value: '取消',
                    action: () => {
                    }
                  },
                    {
                      enabled: true,
                      defaultFocus: true,
                      style: DialogButtonStyle.HIGHLIGHT, //突出显示
                      value: '确定',
                      action: () => {
                        this.delete()
                      }
                    }],
                }
              );
            })
            .btnStyle()
            .backgroundColor('#ec6d71')
        }.justifyContent(FlexAlign.SpaceAround).width('100%')
        .position({ x: 0, y: '90%' }) // 定位到底部

      }.margin({ bottom: 15 }).padding({ left: 15, right: 15 })

    }
    .title('配色详情')
    .height('100%')
    .width('100%')
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