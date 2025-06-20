/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/

interface ob {
  name: string
  hex: string
  color: string
}

@Builder
export function plazaChinaBuilder(name: string, param: Object) {
  China()
}

@Component
export struct China {
  @State colors: ob[] = [
    { name: '精白', hex: '#ffffff', color: 'black' },
    { name: '银白', hex: '#e9e7ef', color: 'black' },
    { name: '铅白', hex: '#f0f0f4', color: 'black' },
    { name: '霜色', hex: '#e9f1f6', color: 'black' },
    { name: '雪白', hex: '#f0fcff', color: 'black' },
    { name: '莹白', hex: '#e3f9fd', color: 'black' },
    { name: '月白', hex: '#d6ecf0', color: 'black' },
    { name: '象牙白', hex: '#fffbf0', color: 'black' },
    { name: '缟', hex: '#f2ecde', color: 'black' },
    { name: '鱼肚白', hex: '#fcefe8', color: 'black' },
    { name: '白粉', hex: '#fff2df', color: 'black' },
    { name: '荼白', hex: '#f3f9f1', color: 'black' },
    { name: '鸭卵青', hex: '#e0eee8', color: 'black' },
    { name: '素', hex: '#e0f0e9', color: 'black' },
    { name: '青白', hex: '#c0ebd7', color: 'black' },
    { name: '蟹壳青', hex: '#bbcdc5', color: 'black' },
    { name: '花白', hex: '#c2ccd0', color: 'black' },
    { name: '老银', hex: '#bacac6', color: 'black' },
    { name: '灰色', hex: '#808080', color: 'white' },
    { name: '苍色', hex: '#75878a', color: 'white' },
    { name: '水色', hex: '#88ada6', color: 'white' },
    { name: '黝', hex: '#6b6882', color: 'white' },
    { name: '乌色', hex: '#725e82', color: 'white' },
    { name: '玄青', hex: '#3d3b4f', color: 'white' },
    { name: '乌黑', hex: '#392f41', color: 'white' },
    { name: '黎', hex: '#75664d', color: 'white' },
    { name: '黧', hex: '#5d513c', color: 'white' },
    { name: '黝黑', hex: '#665757', color: 'white' },
    { name: '缁色', hex: '#493131', color: 'white' },
    { name: '煤黑', hex: '#312520', color: 'white' },
    { name: '漆黑', hex: '#161823', color: 'white' },
    { name: '黑色', hex: '#000000', color: 'white' },
    { name: '樱草色', hex: '#eaff56', color: 'black' },
    { name: '鹅黄', hex: '#fff143', color: 'black' },
    { name: '鸭黄', hex: '#faff72', color: 'black' },
    { name: '杏黄', hex: '#ffa631', color: 'white' },
    { name: '橙黄', hex: '#ffa400', color: 'white' },
    { name: '橙色', hex: '#fa8c35', color: 'white' },
    { name: '杏红', hex: '#ff8c31', color: 'white' },
    { name: '橘黄', hex: '#ff8936', color: 'white' },
    { name: '橘红', hex: '#ff7500', color: 'white' },
    { name: '藤黄', hex: '#ffb61e', color: 'white' },
    { name: '姜黄', hex: '#ffc773', color: 'white' },
    { name: '雌黄', hex: '#ffc64b', color: 'white' },
    { name: '赤金', hex: '#f2be45', color: 'white' },
    { name: '缃色', hex: '#f0c239', color: 'white' },
    { name: '雄黄', hex: '#e9bb1d', color: 'white' },
    { name: '秋香色', hex: '#d9b611', color: 'white' },
    { name: '金色', hex: '#eacd76', color: 'white' },
    { name: '牙色', hex: '#eedeb0', color: 'white' },
    { name: '枯黄', hex: '#d3b17d', color: 'white' },
    { name: '黄栌', hex: '#e29c45', color: 'white' },
    { name: '乌金', hex: '#a78e44', color: 'white' },
    { name: '昏黄', hex: '#c89b40', color: 'white' },
    { name: '棕黄', hex: '#ae7000', color: 'white' },
    { name: '琥珀', hex: '#ca6924', color: 'white' },
    { name: '棕色', hex: '#b25d25', color: 'white' },
    { name: '茶色', hex: '#b35c44', color: 'white' },
    { name: '棕红', hex: '#9b4400', color: 'white' },
    { name: '赭', hex: '#9c5333', color: 'white' },
    { name: '驼色', hex: '#a88462', color: 'white' },
    { name: '秋色', hex: '#896c39', color: 'white' },
    { name: '棕绿', hex: '#827100', color: 'white' },
    { name: '褐色', hex: '#6e511e', color: 'white' },
    { name: '棕黑', hex: '#7c4b00', color: 'white' },
    { name: '赭色', hex: '#955539', color: 'white' },
    { name: '赭石', hex: '#845a33', color: 'white' },
    { name: '松花色', hex: '#bce672', color: 'white' },
    { name: '柳黄', hex: '#c9dd22', color: 'white' },
    { name: '嫩绿', hex: '#bddd22', color: 'white' },
    { name: '柳绿', hex: '#afdd22', color: 'white' },
    { name: '葱黄', hex: '#a3d900', color: 'white' },
    { name: '葱绿', hex: '#9ed900', color: 'white' },
    { name: '豆绿', hex: '#9ed048', color: 'white' },
    { name: '豆青', hex: '#96ce54', color: 'white' },
    { name: '油绿', hex: '#00bc12', color: 'white' },
    { name: '葱倩', hex: '#0eb83a', color: 'white' },
    { name: '葱青', hex: '#0eb83a', color: 'white' },
    { name: '青葱', hex: '#0aa344', color: 'white' },
    { name: '石绿', hex: '#16a951', color: 'white' },
    { name: '松柏绿', hex: '#21a675', color: 'white' },
    { name: '松花绿', hex: '#057748', color: 'white' },
    { name: '绿沈', hex: '#0c8918', color: 'white' },
    { name: '绿色', hex: '#00e500', color: 'white' },
    { name: '草绿', hex: '#40de5a', color: 'white' },
    { name: '青翠', hex: '#00e079', color: 'white' },
    { name: '青色', hex: '#00e09e', color: 'white' },
    { name: '翡翠色', hex: '#3de1ad', color: 'white' },
    { name: '碧绿', hex: '#2add9c', color: 'white' },
    { name: '玉色', hex: '#2edfa3', color: 'white' },
    { name: '缥', hex: '#7fecad', color: 'white' },
    { name: '艾绿', hex: '#a4e2c6', color: 'white' },
    { name: '石青', hex: '#7bcfa6', color: 'white' },
    { name: '碧色', hex: '#1bd1a5', color: 'white' },
    { name: '青碧', hex: '#48c0a3', color: 'white' },
    { name: '铜绿', hex: '#549688', color: 'white' },
    { name: '竹青', hex: '#789262', color: 'white' },
    { name: '墨灰', hex: '#758a99', color: 'white' },
    { name: '墨色', hex: '#50616d', color: 'white' },
    { name: '鸦青', hex: '#424c50', color: 'white' },
    { name: '黯', hex: '#41555d', color: 'white' },
    { name: '朱砂', hex: '#ff461f', color: 'white' },
    { name: '火红', hex: '#ff2d51', color: 'white' },
    { name: '朱膘', hex: '#f36838', color: 'white' },
    { name: '妃色', hex: '#ed5736', color: 'white' },
    { name: '洋红', hex: '#ff4777', color: 'white' },
    { name: '品红', hex: '#f00056', color: 'white' },
    { name: '粉红', hex: '#ffb3a7', color: 'white' },
    { name: '桃红', hex: '#f47983', color: 'white' },
    { name: '海棠红', hex: '#db5a6b', color: 'white' },
    { name: '樱桃色', hex: '#c93756', color: 'white' },
    { name: '酡颜', hex: '#f9906f', color: 'white' },
    { name: '银红', hex: '#f05654', color: 'white' },
    { name: '大红', hex: '#ff2121', color: 'white' },
    { name: '石榴红', hex: '#f20c00', color: 'white' },
    { name: '绛紫', hex: '#8c4356', color: 'white' },
    { name: '绯红', hex: '#c83c23', color: 'white' },
    { name: '胭脂', hex: '#9d2933', color: 'white' },
    { name: '朱红', hex: '#ff4c00', color: 'white' },
    { name: '丹', hex: '#ff4e20', color: 'white' },
    { name: '彤', hex: '#f35336', color: 'white' },
    { name: '酡红', hex: '#dc3023', color: 'white' },
    { name: '炎', hex: '#ff3300', color: 'white' },
    { name: '茜色', hex: '#cb3a56', color: 'white' },
    { name: '绾', hex: '#a98175', color: 'white' },
    { name: '檀', hex: '#b36d61', color: 'white' },
    { name: '嫣红', hex: '#ef7a82', color: 'white' },
    { name: '洋红', hex: '#ff0097', color: 'white' },
    { name: '枣红', hex: '#c32136', color: 'white' },
    { name: '殷红', hex: '#be002f', color: 'white' },
    { name: '赫赤', hex: '#c91f37', color: 'white' },
    { name: '银朱', hex: '#bf242a', color: 'white' },
    { name: '赤', hex: '#c3272b', color: 'white' },
    { name: '胭脂', hex: '#9d2933', color: 'white' },
    { name: '栗色', hex: '#60281e', color: 'white' },
    { name: '玄色', hex: '#622a1d', color: 'white' },
    { name: '蔚蓝', hex: '#70f3ff', color: 'black' },
    { name: '蓝', hex: '#44cef6', color: 'white' },
    { name: '碧蓝', hex: '#3eede7', color: 'white' },
    { name: '石青', hex: '#1685a9', color: 'white' },
    { name: '靛青', hex: '#177cb0', color: 'white' },
    { name: '靛蓝', hex: '#065279', color: 'white' },
    { name: '花青', hex: '#003472', color: 'white' },
    { name: '宝蓝', hex: '#4b5cc4', color: 'white' },
    { name: '蓝灰色', hex: '#a1afc9', color: 'white' },
    { name: '藏青', hex: '#2e4e7e', color: 'white' },
    { name: '藏蓝', hex: '#3b2e7e', color: 'white' },
    { name: '黛', hex: '#4a4266', color: 'white' },
    { name: '黛绿', hex: '#426666', color: 'white' },
    { name: '黛蓝', hex: '#425066', color: 'white' },
    { name: '黛紫', hex: '#574266', color: 'white' },
    { name: '紫色', hex: '#8d4bbb', color: 'white' },
    { name: '紫酱', hex: '#815463', color: 'white' },
    { name: '酱紫', hex: '#815476', color: 'white' },
    { name: '紫檀', hex: '#4c221b', color: 'white' },
    { name: '绀青', hex: '#003371', color: 'white' },
    { name: '紫棠', hex: '#56004f', color: 'white' },
    { name: '青莲', hex: '#801dae', color: 'white' },
    { name: '群青', hex: '#4c8dae', color: 'white' },
    { name: '雪青', hex: '#b0a4e3', color: 'white' },
    { name: '丁香色', hex: '#cca4e3', color: 'white' },
    { name: '藕色', hex: '#edd1d8', color: 'white' },
    { name: '藕荷色', hex: '#e4c6d0', color: 'white' }]
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ForEach(this.colors, (item: ob, index) => {
            ListItem() {
              Flex({
                direction: FlexDirection.Column,
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
              }) {
                Text(item.name).fontColor(item.color)
                Text(item.hex).fontColor(item.color)
              }
              .margin('15px')
              .width('calc(100% - 30vp)')
              .padding('20vp')
              .borderRadius('10vp')
              .backgroundColor(item.hex)
              .onClick((event) => {
                this.pathStack.pushPathByName('ColorDetail', item);
              })

            }
          }, (item: string) => item)
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('中国传统色彩')
    // .backgroundColor('#888')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}
