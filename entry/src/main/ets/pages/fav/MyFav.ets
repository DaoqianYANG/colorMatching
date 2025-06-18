import { distributedKVStore } from '@kit.ArkData';
import KVStore from '../../utils/KVStore';
import { KVStoreType } from '../../viewmodel/KVStoreType';

/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
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

@Extend(Column)
function columnStyle() {
  .width('100%')
  .padding(10)
  .border({
    width: 1,
    style: BorderStyle.Solid,
    radius: 8,
    color: 'rgba(39, 48, 57, 0.08)'
  })
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 5, // 模糊半径
    color: '#aaa'
    // color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Builder
export function myFavBuilder(name: string, param: Object) {
  Index()
}


@Component
export struct Index {
  async aboutToAppear() {
    let encrypted = false; //加密状态
    const securityLevel: distributedKVStore.SecurityLevel = distributedKVStore.SecurityLevel.S1; //风险等级低
    const UIContext = this.getUIContext();
    this.kvStoreAll = [];
    this.kvStore = undefined;
    this.kvStore = new KVStore(encrypted, securityLevel, UIContext);
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
    }, 200)

  }

  @StorageLink('kvStore') kvStore: KVStore | undefined = undefined;
  @StorageLink('kvStoreAll') kvStoreAll: KVStoreType[] = [];
  @StorageLink('listTest') listTest: ob[] = [];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          if (this.listTest.length == 0) {
            ListItem() {
              Column() {
                Text('这里什么都没有~').fontColor('#00a497')
                Text('快去逛逛收藏美好吧').fontColor('#00a497')
              }.height("100%").justifyContent(FlexAlign.Center)
            }
          }
          ForEach(this.listTest, (item: ob) => {
            ListItem() {
              Column({}) {
                Text(item.name).margin({ bottom: 10 })
                Row() {
                  ForEach(item.colors, (c: string) => {
                    Flex()
                      .backgroundColor(c)
                      .height(48)
                      .width(48)
                      .margin({ right: 10 })
                      .border({
                        radius: 8,
                      })
                  })
                }.justifyContent(FlexAlign.Start).width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .columnStyle()
              .onClick(() => {
                this.pathStack.pushPathByName('favDetail', item);
              })

            }.margin({ bottom: 15 }).padding({ left: 15, right: 15 })
          })
        }
        .alignListItem(ListItemAlign.Center)
        .padding({ bottom: 20 })
      }
    }
    .title('我的收藏')
    .height('100%')
    .width('100%')
    .padding({ top: 35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}