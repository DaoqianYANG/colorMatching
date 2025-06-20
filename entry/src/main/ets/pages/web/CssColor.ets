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
}

@Builder
export function cssColorBuilder(name: string, param: Object) {
  cssColor()
}

@Extend(Column)
function columnStyle() {
  .backgroundColor('#FFFFFF')
  .margin({
    top: '20px',
    bottom: '20px',
    left: '63px',
    right: '63px'
  })
  .padding({
    top: 15, // 上边距15vp
    right: 20, // 右边距20vp
    bottom: 10, // 下边距10vp
    left: 20        // 左边距20vp
  })
  .border({
    width: 1,
    style: BorderStyle.Solid,
    color: 'rgba(39, 48, 57, 0.08)'
  })
  // .shadow({
  //   color: 'rgba(39, 48, 57, 0.05)',
  //   offsetX: 10, // X轴偏移量
  //   offsetY: 10, // Y轴偏移量
  //   radius: 5                 // 模糊半径
  // })
  .shadow({
    offsetX: 10, // X轴偏移量
    offsetY: 10, // Y轴偏移量
    radius: 30, // 模糊半径
    color: '#2730390D'  // 阴影颜色，使用十六进制表示法，0D是透明度0.05的十六进制表示
  })
}

@Extend(ListItem)
function listItemStyle() {
  .margin({
    top: '20px',
    bottom: '20px',
    left: '63px',
    right: '63px'
  })
}

@Extend(Flex)
function flexStyle() {

  .border({
    width: { top: 1 },
    color: '#e9e9e9',
    style: BorderStyle.Solid
  })
}

@Extend(Text)
function textStyle() {
  .width('100%')
  .margin({ bottom: '5vp' })
  .fontColor('#333')
  .textIndent('32vp')
}



@Component
export struct cssColor {
  @State standard: ob[] = [{ name: "aqua", hex: "#00FFFF" },
    { name: "black", hex: "#000000" },
    { name: "blue", hex: "#0000FF" },
    { name: "fuchsia", hex: "#FF00FF" },
    { name: "gray", hex: "#808080" },
    { name: "green", hex: "#008000" },
    { name: "lime", hex: "#00FF00" },
    { name: "maroon", hex: "#800000" },
    { name: "navy", hex: "#000080" },
    { name: "olive", hex: "#808000" },
    { name: "orange", hex: "#FFA500" },
    { name: "purple", hex: "#800080" },
    { name: "red", hex: "#FF0000" },
    { name: "silver", hex: "#C0C0C0" },
    { name: "teal", hex: "#008080" },
    { name: "white", hex: "#FFFFFF" },
    { name: "yellow", hex: "#FFFF00" }];
  @State color: ob[] = [
    { name: "maroon", hex: "#800000" },
    { name: "brown", hex: "#A52A2A" },
    { name: "crimson", hex: "#DC143C" },
    { name: "darkred", hex: "#8B0000" },
    { name: "firebrick", hex: "#B22222" },
    { name: "red", hex: "#FF0000" },
    { name: "mediumvioletred", hex: "#C71585" },
    { name: "deeppink", hex: "#FF1493" },
    { name: "hotpink", hex: "#FF69B4" },
    { name: "lightpink", hex: "#FFB6C1" },
    { name: "lavenderblush", hex: "#FFF0F5" },
    { name: "palevioletred", hex: "#D87093" },
    { name: "fuchsia(magenta)", hex: "#FF00FF" },
    { name: "pink", hex: "#FFC0CB" },
    { name: "mistyrose", hex: "#FFE4E1" },
    { name: "indigo", hex: "#4B0082" },
    { name: "darkmagenta", hex: "#8B008B" },
    { name: "blueviolet", hex: "#8A2BE2" },
    { name: "slateblue", hex: "#6A5ACD" },
    { name: "mediumslateblue", hex: "#7B68EE" },
    { name: "violet", hex: "#EE82EE" },
    { name: "thistle", hex: "#D8BFD8" },
    { name: "purple", hex: "#800080" },
    { name: "darkorchid", hex: "#9932CC" },
    { name: "darkviolet", hex: "#9400D3" },
    { name: "mediumpurple", hex: "#9370DB" },
    { name: "mediumorchid", hex: "#BA55D3" },
    { name: "plum", hex: "#DDA0DD" },
    { name: "lavender", hex: "#E6E6FA" },
    { name: "saddlebrown", hex: "#8B4513" },
    { name: "chocolate", hex: "#D2691E" },
    { name: "rosybrown", hex: "#BC8F8F" },
    { name: "salmon", hex: "#FA8072" },
    { name: "orangered", hex: "#FF4500" },
    { name: "coral", hex: "#FF7F50" },
    { name: "sandybrown", hex: "#F4A460" },
    { name: "tan", hex: "#D2B48C" },
    { name: "wheat", hex: "#F5DEB3" },
    { name: "navajowhite", hex: "#FFDEAD" },
    { name: "bisque", hex: "#FFE4C4" },
    { name: "papayawhip", hex: "#FFEFD5" },
    { name: "oldlace", hex: "#FDF5E6" },
    { name: "seashell", hex: "#FFF5EE" },
    { name: "floralwhite", hex: "#FFFAF0" },
    { name: "sienna", hex: "#A0522D" },
    { name: "indianred", hex: "#CD5C5C" },
    { name: "lightcoral", hex: "#F08080" },
    { name: "lightsalmon", hex: "#FFA07A" },
    { name: "tomato", hex: "#FF6347" },
    { name: "darkorange", hex: "#FF8C00" },
    { name: "peru", hex: "#CD853F" },
    { name: "burlywood", hex: "#DEB887" },
    { name: "moccasin", hex: "#FFE4B5" },
    { name: "peachpuff", hex: "#FFDAB9" },
    { name: "antiquewhite", hex: "#FAEBD7" },
    { name: "cornsilk", hex: "#FFF8DC" },
    { name: "linen", hex: "#FAF0E6" },
    { name: "snow", hex: "#FFFAFA" },
    { name: "ivory", hex: "#FFFFF0" },
    { name: "darkgoldenrod", hex: "#B8860B" },
    { name: "gold", hex: "#FFD700" },
    { name: "darkkhaki", hex: "#BDB76B" },
    { name: "palegoldenrod", hex: "#EEE8AA" },
    { name: "lemonchiffon", hex: "#FFFACD" },
    { name: "lightyellow", hex: "#FFFFE0" },
    { name: "goldenrod", hex: "#DAA520" },
    { name: "yellow", hex: "#FFFF00" },
    { name: "khaki", hex: "#F0E68C" },
    { name: "beige", hex: "#F5F5DC" },
    { name: "lightgoldenrodyellow", hex: "#FAFAD2" },
    { name: "darkslategray", hex: "#2F4F4F" },
    { name: "olive", hex: "#808000" },
    { name: "forestgreen", hex: "#228B22" },
    { name: "green(teal)", hex: "#008080" },
    { name: "yellowgreen", hex: "#9ACD32" },
    { name: "lime", hex: "#00FF00" },
    { name: "lawngreen", hex: "#7CFC00" },
    { name: "mediumspringgreen", hex: "#00FA9A" },
    { name: "lightgreen", hex: "#90EE90" },
    { name: "aquamarine", hex: "#7FFFD4" },
    { name: "mintcream", hex: "#F5FFFA" },
    { name: "darkolivegreen", hex: "#556B2F" },
    { name: "darkgreen", hex: "#006400" },
    { name: "seagreen", hex: "#2E8B57" },
    { name: "madiumaquamarine", hex: "#66CDAA" },
    { name: "limegreen", hex: "#32CD32" },
    { name: "chartreuse", hex: "#7FFF00" },
    { name: "greenyellow", hex: "#ADFF2F" },
    { name: "springgreen", hex: "#00FF7F" },
    { name: "palegreen", hex: "#98F898" },
    { name: "honeydew", hex: "#F0FFF0" },
    { name: "midnightblue", hex: "#191970" },
    { name: "darkblue", hex: "#00008B" },
    { name: "mediumblue", hex: "#0000CD" },
    { name: "dodgerblue", hex: "#1E90FF" },
    { name: "deepskyblue", hex: "#00BFFF" },
    { name: "lightsteelblue", hex: "#B0C4DE" },
    { name: "steelblue", hex: "#4682B4" },
    { name: "cadetblue", hex: "#5F9EA0" },
    { name: "mediumturquoise", hex: "#48D1CC" },
    { name: "skyblue", hex: "#87CECB" },
    { name: "paleturquoise", hex: "#AFEEEE" },
    { name: "azure", hex: "#F0FFFF" },
    { name: "aqua(cyan)", hex: "#00FFFF" },
    { name: "navy", hex: "#000080" },
    { name: "darkslateblue", hex: "#483D8B" },
    { name: "royalblue", hex: "#4169E1" },
    { name: "cornflowerblue", hex: "#6495ED" },
    { name: "lightskyblue", hex: "#87CEFA" },
    { name: "lightblue", hex: "#ADD8E6" },
    { name: "darkcyan", hex: "#008B8B" },
    { name: "darkturquoise", hex: "#00CED1" },
    { name: "turquoise", hex: "#40E0D0" },
    { name: "powderblue", hex: "#B0E0E6" },
    { name: "lightcyan", hex: "#E0FFFF" },
    { name: "aliceblue", hex: "#F0F8FF" },
    { name: "black", hex: "#000000" },
    { name: "gray", hex: "#808000" },
    { name: "lightslategray", hex: "#778899" },
    { name: "silver", hex: "#C0C0C0" },
    { name: "gainsboro", hex: "#DCDCDC" },
    { name: "ghostwhite", hex: "#F8F8FF" },
    { name: "blanchedalmond", hex: "#FFEBCD" },
    { name: "cyan", hex: "#00FFFF" },
    { name: "darkgray", hex: "#A9A9A9" },
    { name: "darksalmon", hex: "#E9967A" },
    { name: "darkseagreen", hex: "#8FBC8F" },
    { name: "dimgray", hex: "#696969" },
    { name: "feldspar", hex: "#D19275" },
    { name: "lightgrey", hex: "#D3D3D3" },
    { name: "lightseagreen", hex: "#20B2AA" },
    { name: "lightslateblue", hex: "#8470FF" },
    { name: "magenta", hex: "#FF00FF" },
    { name: "mediumaquamarine", hex: "#66CDAA" },
    { name: "mediumseagreen", hex: "#3CB371" },
    { name: "olivedrab", hex: "#6B8E23" },
    { name: "orchid", hex: "#DA70D6" },
    { name: "slategray", hex: "#708090" },
    { name: "violetred", hex: "#D02090" },
    { name: "whitesmoke", hex: "#F5F5F5" }];
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        List({ space: 0 }) {
          ListItem() {
            Column() {
              Text("HTML 和 CSS 颜色规范中定义了 147 中颜色名（17 种标准颜色加 130 种其他颜色）。下面的表格中列出了所有这些颜色，以及它们的十六进制值。")
                .textStyle()
              Text('点击来查看相应颜色的详细分量值。')
                .textStyle()
            }.columnStyle()
          }

          ListItem() {
            Column() {
              Text("CSS 标准色")
                .fontColor('#868e96')
                .padding({ top: '12vp', bottom: '12vp' })
              Flex({
                direction: FlexDirection.Row,
                justifyContent: FlexAlign.SpaceAround,
                alignItems: ItemAlign.Center
              }) {
                Text('颜色名')
                Text('HEX值')
                Text('预览')
              }.padding('9vp').flexStyle()

              ForEach(this.standard, (item: ob, index) => {
                Flex({
                  direction: FlexDirection.Row,
                  justifyContent: FlexAlign.End,
                  alignItems: ItemAlign.Center
                }) {
                  Text(item.name).fontSize(14).textAlign(TextAlign.Center).width('25%')
                  Text(item.hex).fontSize(14).textAlign(TextAlign.Center).width('39%')
                  Text('').backgroundColor(item.hex).width('92vp').height('31vp')
                    .onClick((event) => {
                      this.pathStack.pushPathByName('ColorDetail', item);
                    })
                }.flexStyle()
              })
            }
          }.listItemStyle()
          ListItem() {
            Column() {
              Text("CSS 颜色")
                .fontColor('#868e96')
                .padding({ top: '12vp', bottom: '12vp' })
              Flex({
                direction: FlexDirection.Row,
                alignItems: ItemAlign.Center
              }) {
                Text('颜色名').textAlign(TextAlign.Center).width('50%')
                Text('HEX值').textAlign(TextAlign.Center).width('30%')
                Text('预览').textAlign(TextAlign.Center).width('20%')
              }.padding('9vp').flexStyle()

              ForEach(this.color, (item: ob, index) => {
                Flex({
                  direction: FlexDirection.Row,
                  justifyContent: FlexAlign.End,
                  alignItems: ItemAlign.Center
                }) {
                  Text(item.name).fontSize(14).textAlign(TextAlign.Center).width('50%')
                  Text(item.hex).fontSize(14).textAlign(TextAlign.Center).width('30%')
                  Text('').backgroundColor(item.hex).width('20%').height('31vp')
                    .onClick((event) => {
                      this.pathStack.pushPathByName('ColorDetail', item);
                    })
                }.flexStyle()
              })
            }
          }.listItemStyle()
        }
        .alignListItem(ListItemAlign.Center)
      }
    }
    .title('CSS 颜色值')
    // .backgroundColor('#eee')
    .height('100%')
    .width('100%')
    .padding({ top:35 })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })

  }
}
