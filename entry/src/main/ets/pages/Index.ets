/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/
interface path {
  name: string
  url: string
}

@Entry
@Component
struct Index {
  aboutToAppear() {
    this.onChanged();
  }

  onChanged() {
    //获取当前路由
    let arr:string[] = [];
    arr = this.pathStack.getAllPathName();
    console.log('尝试获取当前路由',arr.toString());
    let isHavePath:boolean = false;
    if(arr.length>0){
      isHavePath = true;
    }
    if (!isHavePath && this.navHideBackButton) {
      this.pathStack.pushPath({ name: 'plazaIndex', param: null });
    }
  }

  @StorageLink('navHideBackButton') @Watch("onChanged") navHideBackButton: boolean = false;
  @StorageLink('navSplit') navSplit: boolean = false;
  @State listTest: path[] = [
    { 'name': '配色广场', 'url': 'plazaIndex' },
    { 'name': '颜色转换', 'url': 'transition' },
    { 'name': '色彩工具', 'url': 'tools' },
    { 'name': 'Web颜色', 'url': 'webIndex' },
    { 'name': '关于', 'url': 'about' },
  ];
  // 创建一个页面栈对象并传入Navigation
  @State pathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pathStack) {
      List({ space: (!this.navHideBackButton || this.navSplit)?30:10 }) {
        if (!this.navHideBackButton || this.navSplit) {
          ListItem() {
            Column() {
              Text('Color')
                .fontSize($r('app.float.page_text_font_size'))
                .fontColor('#fff')
                .margin({ top: '40vp' })
              Text('色搭')
                .fontColor('#fff')
                .margin({ top: '20vp' })
                .fontSize('20vp')
            }
          }
        }
        ForEach(this.listTest, (item: path, index) => {
          ListItem() {
            Text(item.name)
              .width('60%')
              .height('40vp')
              .fontColor("#fff")
              .textAlign(TextAlign.Center)
              .borderRadius('50%')
              .backgroundColor('rgba(255, 255, 255, 0.3)')//添加按钮事件
              .onClick((event) => {
                this.pathStack.pushPath({ name: item.url, param: null });
                // this.pathStack.pushPathByName("plazaIndex", null);
              })
          }
        }, (item: string) => item)
      }
      .margin({ top: 35, bottom: 35 })
      .alignListItem(ListItemAlign.Center)

    }
    .hideToolBar(true)
    .hideTitleBar(true)
    .backgroundColor('#00a497')
    .width('100%')
  }
}