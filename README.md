# PixelSnap_S AviUtl/AviUtl ExEdit2 スクリプト

画像が半ピクセルだけズレるなどの影響でぼやけてしまうのを防ぐ AviUtl スクリプトです．小数点以下の座標調整をせずともピクセルパーフェクトな描画になってくれます．

無印の AviUtl と AviUtl ExEdit2 の両方に対応しています．

[ダウンロードはこちら．](https://github.com/sigma-axis/aviutl2_script_PixelSnap_S/releases) [紹介動画．](https://www.nicovideo.jp/watch/sm45452975)

<img width="1920" height="1080" alt="半ピクセルずれを矯正" src="https://github.com/user-attachments/assets/ad69353b-659e-40ba-b610-96c42f4fef45" />

##  動作要件

### AviUtl (無印)

- AviUtl 1.10

  http://spring-fragrance.mints.ne.jp/aviutl

- 拡張編集 0.92

### AviUtl ExEdit2

- AviUtl ExEdit2

  http://spring-fragrance.mints.ne.jp/aviutl

  - `beta13` で動作確認済み．

## 導入方法

- AviUtl (無印) の場合

  以下のフォルダのいずれかに `PixelSnap_S.anm` をコピーしてください．

  1. `exedit.auf` のあるフォルダにある `script` フォルダ
  1. (1) のフォルダにある任意の名前のフォルダ

  アニメーション効果として PixelSnap_S が追加されています．

- AviUtl ExEdit2 の場合

  以下のフォルダのいずれかに `PixelSnap_S.anm2` をコピーしてください．

  1.  スクリプトフォルダ
      - AviUtl2 のメニューの「その他」 :arrow_right: 「アプリケーションデータ」 :arrow_right: 「スクリプトフォルダ」で表示されます．
  1.  (1) のフォルダにある任意の名前のフォルダ

  初期状態だと「フィルタ効果を追加」メニューの「配置」に PixelSnap_S が追加されています．
  - 「オブジェクト追加メニューの設定」の「ラベル」項目で分類を変更できます．


##  仕組み

オブジェクトの座標位置と回転中心を小数点以下のピクセル数だけ動かして，シーンのピクセルとオブジェクトのピクセルが 1 対 1 に対応する位置に微調整します．適用前と比べてオブジェクトの位置が 1 ピクセル未満だけズレますが，オブジェクトに余計なボケが発生しない，ピクセルパーフェクトな描画になります．

- 具体的には `obj.ox`, `obj.oy`, `obj.cx`, `obj.cy` の数値を操作して，これらの座標がオブジェクトやシーンのピクセルの頂点，または中央に来るように微調整しています．


##  パラメタの説明

ありません．

##  TIPS

1.  次のような場合はこのスクリプトを適用していても，ピクセルパーフェクトな描画にならないことがあります．

    1.  標準描画の「拡大率」や「縦横比」，フィルタ効果の「拡大率」がかかっているとき．

        拡大縮小の画像処理が入ってしまうためぼやけてしまいます．

    1.  オブジェクトの Z 座標が 0 でなかったり，立体回転 (X, Y 軸の回転) がかかっていたり，カメラ制御下にあるとき．

        遠近法の表現のため，拡大縮小処理がかかります．

    1.  90° の整数倍でないオブジェクトの平面回転 (Z 軸回転) がかかっているとき．

        90° の整数倍の回転なら問題ありません．

    1.  **[AviUtl (無印) のみ]** グループ制御下に入れているオブジェクトで，そのグループ制御で小数点以下のピクセル数だけズレている場合．

        グループ制御の情報はスクリプトでは現状取得できません．

    1.  その他，上記のような拡大率や回転，Z 座標などを操作するフィルタ効果がかかっているとき．

    1.  このフィルタ効果 (アニメーション効果) の後続フィルタにオブジェクトの座標を動かすものが適用されている場合．

1.  このスクリプトを適用している場合，オブジェクトを平行移動してもピクセル単位で移動するためガクガクした動きになります．

    移動系のアニメーションなどと併用する場合は，このスクリプトの後続に配置したフィルタを使って動かすとスムーズな動きになります．ただしその場合，動きの始点終点などの動きのないタイミングでは，整数単位の移動量を指定するなど通常通りのピクセル単位の配慮が必要です．


## 改版履歴

- **v1.01 (for beta13)** (2025-09-28)

  - AviUtl (無印) 版で回転角度を設定しているオブジェクトに対して，矯正方向が正しくなかったのを修正．

  - AviUtl ExEdit2 版のスクリプト情報表示が間違っていたのを修正．

- **v1.00 (for beta13)** (2025-09-27)

  - 初版．


## ライセンス

このプログラムの利用・改変・再頒布等に関しては MIT ライセンスに従うものとします．

---

The MIT License (MIT)

Copyright (C) 2025 sigma-axis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

https://mit-license.org/


#  連絡・バグ報告

- GitHub: https://github.com/sigma-axis
- Twitter: https://x.com/sigma_axis
- nicovideo: https://www.nicovideo.jp/user/51492481
- Misskey.io: https://misskey.io/@sigma_axis
- Bluesky: https://bsky.app/profile/sigma-axis.bsky.social
