# 源码导读

## <span id="预览">预览</span>
![image](https://github.com/liuchaotclc/videoedit/blob/master/images/shortcut.gif)

## <span id="工程概述">工程概述</span>
入口页面为MainActivity，主页面首先获取文件读写权限，先从视频文件选择页面（VideoPickActivity）选取视频。
获取视频返回MainActivity，判断视频数据时长，打开视频编辑页TrimVideoActivity。
TrimVideoActivity 支持旋转 滤镜 分屏 裁剪多种操作
视频编辑之后进入封面选择页面：SelCoverTimeActivity，封面选择支持@和#操作
视频裁剪滤镜支持配置：VideoFilterConfig，可以调节：
* VIDEO_INPUT_LENGTH_MAX = 3*60;//60整数倍，展示提示时展示最长多少分钟
* VIDEO_INPUT_LENGTH_MIN = 5;//最小视频导入时长
* VIDEO_CAPTURE_LENGTH_MAX = 60;//最长裁剪时长
* VIDEO_CAPTURE_LENGTH_MIN = 3;//最短裁剪时长
* VIDEO_CACHE_FILE_DIR = "small_video/trimmedVideo";//视频临时文件缓存路径


## <span id="总体流程">总体流程</span>

图片滤镜的总体流程如下：
* 入口页面为MainActivity(获取文件读写权限)，在调用模块之前需要先获取相应权限
* 视频编辑页面 VideoPickActivity 支持常用滤镜和分屏操作。同时支持旋转和滤镜同时操作
* 封面选择页 SelCoverTimeActivity 支持@和#，封面拖动选择 点击选择

## <span id="主要第三方库">主要第三方库</span>

* 视频裁剪处理 isoparser


### 工程结构说明

源码主要分成四个 package ：effect、filter、pickvideo、trimvideo 和 selcover。
- effect：滤镜效果处理包。
- filter：滤镜脚本。
- pickvideo：选取视频。
- selcover：选取封面。
- trimvideo：裁剪视频。

下面具体介绍 videoEdit 包下的子包结构：
- 一级目录：所有 MainActivity、Application。
- composer：视频处理相关。
- model：数据模型。
- utils: 相关工具。
- view：自定义view。
- VideoFilterConfig: 视频配置。

### 重点类说明

- GlFilter : 滤镜渲染基类,所有滤镜旋转、滤镜效果、纹理映射、矩阵传递等。
- VideoGlRender：视频滤镜渲染器，同样包含GlFilter相关操作。
- TrimVideoActivity: 滤镜效果、分屏、旋转操作页面。简单状态机处理渲染和裁剪状态。
- SelCoverTimeActivity:获取封面、分享 mVideoPath为视频路径 mSelCoverAdapter.getDataList().get(mScrollerPosition).path为图片路径

### 重要提示
- 视频缓存文件要在使用完滤镜后删除，不然会越来越多。在SelCoverTimeActivity的onDestroy方法中有删除示例

