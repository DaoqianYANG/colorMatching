/**************************************************
 * Copyright (C) 2018 蔡炜桀
 * Copyright (C) 2025 杨国兴
 * 原始代码可访问：https://github.com/czcaiwj/color
 * 本文件属于衍生项目“色搭”，基于原项目“Color颜值”修改
 * 遵循 GNU General Public License v3.0 许可证
 *************************************************/

export class colorUtil {
  /**
   * 检查RGB某一分量值是否合法
   * @param value 分量值
   */
  check_rgb_value(value: string): boolean {
    if (value === undefined || value === null) {
      return false;
    }
    if (typeof value === 'string' && value.trim() === '') {
      return false;
    }
    const num = Number(value);
    return !(isNaN(num) || num < 0 || num > 255);
  }

  /**
   * RGB值转十六进制表示
   */
  rgb2hex(red: number, green: number, blue: number): string {
    let r = red.toString(16);
    let g = green.toString(16);
    let b = blue.toString(16);
    if (r.length === 1) {
      r = "0" + r;
    }
    if (g.length === 1) {
      g = "0" + g;
    }
    if (b.length === 1) {
      b = "0" + b;
    }
    return `#${r}${g}${b}`;
  }

  /**
   * 十六进制表示转RGB值
   */
  hex2rgb(hex: string): number[] {
    hex = hex.includes('#') ? hex.slice(1) : hex;
    let r: string, g: string, b: string;

    if (hex.length === 6) {
      r = hex.substring(0, 2);
      g = hex.substring(2, 4);
      b = hex.substring(4, 6);
    } else if (hex.length === 3) {
      hex = hex.split('').map(c => c + c).join('');
      r = hex.substring(0, 2);
      g = hex.substring(2, 4);
      b = hex.substring(4, 6);
    } else {
      r = g = b = '00';
    }

    return [parseInt(r, 16) || 0, parseInt(g, 16) || 0, parseInt(b, 16) || 0];
  }

  /**
   * RGB值转HSB值
   * 输入
   * r:0~255
   * g:0~255
   * b:0~255
   * 输出
   * h:0~359
   * s:0~100
   * b:0~100
   */
  rgb2hsb(r: number, g: number, b: number): [number, number, number] {
    const rgb = [r, g, b].sort((i, j) => i - j);
    const max = rgb[2];
    const min = rgb[0];

    const hsb_b = max / 255.0;
    const hsb_s = max === 0 ? 0 : (max - min) / max;
    let hsb_h = 0;

    if (max !== min) {
      if (max === r && g >= b) {
        hsb_h = 60 * (g - b) / (max - min);
      } else if (max === r && g < b) {
        hsb_h = 60 * (g - b) / (max - min) + 360;
      } else if (max === g) {
        hsb_h = 60 * (b - r) / (max - min) + 120;
      } else if (max === b) {
        hsb_h = 60 * (r - g) / (max - min) + 240;
      }
    }
    return [Math.round(hsb_h), Math.round(hsb_s * 100), Math.round(hsb_b * 100)];

  }

  rgb2hsbV2(r: number, g: number, b: number): [number, number, number] {
    let rgb = new Array(r, g, b);
    rgb = rgb.sort((i, j) => i - j);
    let max = rgb[2];
    let min = rgb[0];

    let hsb_b = max / 255.0;
    let hsb_s = max == 0 ? 0 : (max - min) / max
    let hsb_h = 0;
    if (max == min) {
      hsb_h = 0;
    } else if (max == r && g >= b) {
      hsb_h = 60 * (g - b) / (max - min);
    } else if (max == r && g < b) {
      hsb_h = 60 * (g - b) / (max - min) + 360;
    } else if (max == g) {
      hsb_h = 60 * (b - r) / (max - min) + 120;
    } else if (max == b) {
      hsb_h = 60 * (r - g) / (max - min) + 240;
    }
    return [Math.round(hsb_h), Math.round(hsb_s * 100), Math.round(hsb_b * 100)];

  }

  /**
   * RGB值转CMYK值
   * 输入
   * r:0~255
   * g:0~255
   * b:0~255
   * 输出
   * c:0~100
   * m:0~100
   * y:0~100
   * k:0~100
   */
  rgb2cmyk(r: number, g: number, b: number): [number, number, number, number] {
    let c = 1 - r / 255;
    let m = 1 - g / 255;
    let y = 1 - b / 255;
    let k = 1;
    k = c < k ? c : k;
    k = m < k ? m : k;
    k = y < k ? y : k;
    if (k == 1) {
      c = 0;
      m = 0;
      y = 0
    } else {
      c = (c - k) / (1 - k)
      m = (m - k) / (1 - k)
      y = (y - k) / (1 - k)
    }
    return [Math.round(c * 100), Math.round(m * 100), Math.round(y * 100), Math.round(k * 100)];

  }

  /**
   * RGB值转LAB值
   * 输入
   * r:0~255
   * g:0~255
   * b:0~255
   * 输出
   * l:0~100
   * a:-128~127
   * b:-128~127
   */
  rgb2lab(r: number, g: number, b: number): [number, number, number] {
    let red = r / 255;
    let green = g / 255;
    let blue = b / 255;

    red = red > 0.04045 ? Math.pow((red + 0.055) / 1.055, 2.4) : red / 12.92;
    green = green > 0.04045 ? Math.pow((green + 0.055) / 1.055, 2.4) : green / 12.92;
    blue = blue > 0.04045 ? Math.pow((blue + 0.055) / 1.055, 2.4) : blue / 12.92;

    red *= 100;
    green *= 100;
    blue *= 100;

    let x = red * 0.4124 + green * 0.3576 + blue * 0.1805;
    let y = red * 0.2126 + green * 0.7152 + blue * 0.0722;
    let z = red * 0.0193 + green * 0.1192 + blue * 0.9505;

    x /= 95.047;
    y /= 100.0;
    z /= 108.883;

    x = x > 0.008856 ? Math.pow(x, 1 / 3) : 7.787 * x + 16 / 116;
    y = y > 0.008856 ? Math.pow(y, 1 / 3) : 7.787 * y + 16 / 116;
    z = z > 0.008856 ? Math.pow(z, 1 / 3) : 7.787 * z + 16 / 116;

    const l1 = 116 * y - 16;
    const a1 = 500 * (x - y);
    const b1 = 200 * (y - z);

    return [Math.round(l1), Math.round(a1), Math.round(b1)];
  }

  /**
   * CMYK值转RGB值
   * 输入
   * c:0~100
   * m:0~100
   * y:0~100
   * k:0~100
   * 输出
   * r:0~255
   * g:0~255
   * b:0~255
   */
  cmyk2rgb(c: number, m: number, y: number, k: number): [number, number, number] {
    c /= 100;
    m /= 100;
    y /= 100;
    k /= 100;
    c = c * (1 - k) + k;
    m = m * (1 - k) + k;
    y = y * (1 - k) + k;
    const r = (1 - c) * 255;
    const g = (1 - m) * 255;
    const b = (1 - y) * 255;

    return [Math.round(r), Math.round(g), Math.round(b)];

  }

  /**
   * LAB值转RGB值
   * 输入
   * l:0~100
   * a:-128~127
   * b:-128~127
   * 输出
   * r:0~255
   * g:0~255
   * b:0~255
   */
  lab2rgb(l: number, a: number, b_val: number): [number, number, number] {
    let y = (l + 16) / 116;
    let x = a / 500 + y;
    let z = y - b_val / 200;

    x = Math.pow(x, 3) > 0.008856 ? Math.pow(x, 3) : (x - 16 / 116) / 7.787;
    y = Math.pow(y, 3) > 0.008856 ? Math.pow(y, 3) : (y - 16 / 116) / 7.787;
    z = Math.pow(z, 3) > 0.008856 ? Math.pow(z, 3) : (z - 16 / 116) / 7.787;


    x *= 95.047;
    y *= 100.0;
    z *= 108.883;

    x /= 100.0;
    y /= 100.0;
    z /= 100.0;

    let red = x * 3.2406 + y * -1.5372 + z * -0.4986;
    let green = x * -0.9689 + y * 1.8758 + z * 0.0415;
    let blue = x * 0.0557 + y * -0.2040 + z * 1.0570;

    red = red > 0.0031308 ? 1.055 * Math.pow(red, 1 / 2.4) - 0.055 : red * 12.92;
    green = green > 0.0031308 ? 1.055 * Math.pow(green, 1 / 2.4) - 0.055 : green * 12.92;
    blue = blue > 0.0031308 ? 1.055 * Math.pow(blue, 1 / 2.4) - 0.055 : blue * 12.92;

    red *= 255;
    green *= 255;
    blue *= 255;

    red = red < 0 ? 0 : red > 255 ? 255 : red;
    green = green < 0 ? 0 : green > 255 ? 255 : green;
    blue = blue < 0 ? 0 : blue > 255 ? 255 : blue;
    return [Math.round(red), Math.round(green), Math.round(blue)];
  }

  /**
   * HSB值转RGB值
   * 输入
   * h:0~359
   * s:0~100
   * b:0~100
   * 输出
   * r:0~255
   * g:0~255
   * b:0~255
   */
  hsb2rgb(h: number, s: number, b: number): [number, number, number] {
    h = h % 360;
    s = s / 100.0;
    b = b / 100.0;
    let hi = parseInt(((h / 60) % 6).toString());
    let f = h / 60 - hi;
    let p = b * (1 - s);
    let q = b * (1 - f * s);
    let t = b * (1 - (1 - f) * s);
    let red = 0, green = 0, blue = 0;

    switch (hi) {
      case 0:
        red = b;
        green = t;
        blue = p;
        break;
      case 1:
        red = q;
        green = b;
        blue = p;
        break;
      case 2:
        red = p;
        green = b;
        blue = t;
        break;
      case 3:
        red = p;
        green = q;
        blue = b;
        break;
      case 4:
        red = t;
        green = p;
        blue = b;
        break;
      case 5:
        red = b;
        green = p;
        blue = q;
        break;
    }

    red *= 255;
    green *= 255;
    blue *= 255;
    return [parseInt(red.toFixed(0)), parseInt(green.toFixed(0)), parseInt(blue.toFixed(0))];
  }
}

let colorUtilsObject: colorUtil = new colorUtil();

export default colorUtilsObject;
