//+------------------------------------------------------------------+
//|                                         SEMI AUTOMATIC TRADE.mq5 |
//|                                           Copyright 2020, SAT's. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, SAT's."
#property link      ""
#property version   "1.2.0"
#property description "SEMI AUTOMATIC TRADE"
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>
#include <Controls\ComboBox.mqh>
#include <Trade\SymbolInfo.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>
#include <Controls\BmpButton.mqh>
#include <Graphics\Graphic.mqh>
#include "Controls\CheckBoxEx.mqh"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
#resource "camera.wav"
#resource "sl.wav"
#resource "tp.wav"
#resource "reverse.bmp"

//--- 基本情報
// #define TOOL_NAME                          ""      // Toolの名前
// Window Size
#define ORG_BASE_LEFT                          (32)
#define ORG_BASE_TOP                           (32)
#define ORG_BASE_WIDTH                         (240)
#define ORG_BASE_HEIGHT                        (360)
//--- indents and gaps
#define ORG_MENU_INDENT_LEFT                   (5)
#define ORG_MENU_INDENT_TOP                    (24)
#define ORG_BODY_INDENT_LEFT                   (7.5)
#define ORG_BODY_INDENT_CENTER                 (4)
#define ORG_BODY_INDENT_TOP                    (6.4)
#define ORG_BODY_INDENT_ROW                    (8.4)
#define ORG_GRAPH_INDENT_LEFT                  (35)
#define ORG_GRAPH_INDENT_TOP                   (15)
//--- menu buttons
#define ORG_MENU_EDIT_WIDTH                    (70)
#define ORG_MENU_EDIT_WIDE_WIDTH               (120)
#define ORG_MENU_EDIT_HEIGHT                   (24)
#define ORG_MENU_BUTTON_WIDTH                  (66.8)
#define ORG_MENU_BUTTON_HEIGHT                 (24)
#define ORG_MENU_LABEL_WIDTH                  (30)
#define ORG_MENU_LABEL_HEIGHT                 (10)
#define ORG_MENU_BUTTON_INFO_INDENT_LEFT      (11)
#define ORG_MENU_BUTTON_INFO_WIDTH            (30.4)
#define ORG_MENU_BUTTON_INFO_HEIGHT           (24)
//--- trade buttons
#define ORG_TRADE_BUTTON_WIDTH                 (96.8)
#define ORG_TRADE_BUTTON_HEIGHT                (48)
//--- trade labels
// #define ORG_TRADE_LABEL_WIDTH                  (96.8)
#define ORG_TRADE_LABEL_WIDTH                  (66.8)
#define ORG_TRADE_LABEL_HEIGHT                 (16)
//--- tick labels
// #define ORG_TICK_LABEL_WIDTH                   (96.8)
#define ORG_TICK_LABEL_WIDTH                   (66.8)
#define ORG_TICK_LABEL_HEIGHT                  (16)
//--- common labels
#define ORG_COMMON_LABEL_COL1_WIDTH            (42.4)
#define ORG_COMMON_LABEL_COL2_WIDTH            (67.2)
#define ORG_COMMON_LABEL_COL3_WIDTH            (80)
#define ORG_COMMON_LABEL_COL4_WIDTH            (50)
#define ORG_COMMON_LABEL_COL5_WIDTH            (15)
#define ORG_COMMON_LABEL_COL6_WIDTH            (15)
#define ORG_COMMON_LABEL_COL3_1_1_WIDTH        (56)
#define ORG_COMMON_LABEL_COL3_1_2_WIDTH        (24)
#define ORG_COMMON_LABEL_COL3_2_1_WIDTH        (72)
#define ORG_COMMON_LABEL_COL3_2_2_WIDTH        (8)
#define ORG_COMMON_LABEL_COL3_3_1_WIDTH        (56)
#define ORG_COMMON_LABEL_COL3_3_2_WIDTH        (24)
#define ORG_COMMON_BUTTON_HEIGHT                (20)
#define ORG_COMMON_LABEL_HEIGHT                (14)
#define ORG_COMMON_LABEL_FOOTER_WIDTH          (55)
#define ORG_COMMON_LABEL_FOOTER_INDENT          (2)
#define ORG_COMMON_LABEL_FOOTER_INFO_INDENT    (0)
#define ORG_COMMON_LABEL_FOOTER_INFO_WIDTH     (25.5)
//--- 決済
#define ORG_INFO_LABEL_COL1_WIDTH              (42.4)
#define ORG_INFO_LABEL_COL2_WIDTH              (152)
// #define ORG_INFO_LABEL_COL3_WIDTH           (80)
#define ORG_INFO_LABEL_HEIGHT                  (14)
#define ORG_INFO_FOOTER_INDENT_ROW             (8.4)
#define ORG_INFO_BUTTON1_WIDTH                 (58)
#define ORG_INFO_BUTTON1_HEIGHT                (24)
#define ORG_INFO_BUTTON2_WIDTH                 (106)
#define ORG_INFO_BUTTON2_HEIGHT                (24)
//--- ポジション一覧
#define ORG_POSITION_LABEL_COL1_WIDTH              (70)
#define ORG_POSITION_LABEL_HEIGHT                  (20)
#define ORG_POSITION_BUTTON1_WIDTH                 (25)
#define ORG_POSITION_BUTTON1_HEIGHT                (20)
#define ORG_POSITION_BUTTON2_WIDTH                 (15)
#define ORG_POSITION_BUTTON2_HEIGHT                (20)
#define ORG_POSITION_BUTTON3_WIDTH                 (15)
#define ORG_POSITION_BUTTON3_HEIGHT                (20)
#define ORG_POSITION_BUTTON4_WIDTH                 (25)
#define ORG_POSITION_BUTTON4_HEIGHT                (20)
#define ORG_POSITION_EDIT1_WIDTH                   (30)
#define ORG_POSITION_EDIT1_HEIGHT                  (20)
//---
//--- line labels
#define ORG_LINE_LABEL1_X                      (140)
// #define ORG_LINE_LABEL2_X                      (80)
// #define ORG_LINE_LABEL2_2_X                 (176)
// #define ORG_LINE_LABEL3_X                   (400)
#define ORG_LINE_LABEL1_WIDTH                  (170)
#define ORG_LINE_LABEL1_HEIGHT                 (16)
#define ORG_LINE_LABEL2_WIDTH                  (72)
#define ORG_LINE_LABEL2_HEIGHT                 (16)
#define ORG_LINE_LABEL3_WIDTH                  (72)
#define ORG_LINE_LABEL3_HEIGHT                 (16)
//--- position labels
#define ORG_POSITION_LABEL1_WIDTH                  (20)
#define ORG_POSITION_LABEL1_HEIGHT                 (16)
#define ORG_POSITION_LABEL2_WIDTH                  (170)
#define ORG_POSITION_LABEL2_HEIGHT                 (16)

#define ORG_LINE_CANDLETIME_WIDTH                  (60)
#define ORG_LINE_CANDLETIME_HEIGHT                 (16)

//--- 注文パネル（サブ）Object名
#define SUB_NAME_PREFIX                   "sub_"
//---
#define SYMBOL_MENU_NAME_PREFIX           "sel_symbol_menu_"
#define SYMBOL_MENU_COL_ITEM_COUNT     10
//--- ポジション操作メニューObject名
#define POSITION_MENU_NAME_PREFIX         "sel_position_menu_"
//--- ポジションごとのボタンObject名
#define POSITION_NAME_PREFIX              "sel_position_"
#define POSITION_TP_NAME_PREFIX           "sel_position_tp_"
#define POSITION_SL_NAME_PREFIX           "sel_position_sl_"
#define POSITION_ORDER_NAME_PREFIX        "sel_order_"
//--- グラフのObject名
#define GRAPH_NAME_PREFIX                 "graph_"
#define GRAPH_SYMBOL_MENU_NAME_PREFIX     "graph_symbol_menu_"
#define GRAPH_LABEL_TRADES_PREFIX         "取引回数"
#define GRAPH_LABEL_LONG_TRADES_PREFIX    "ロングポジション"
#define GRAPH_LABEL_SHORT_TRADES_PREFIX   "ショットポジション"
#define GRAPH_LABEL_PROFITFACTOR_PREFIX   "ブロフィットファクター"
#define GRAPH_LABEL_MDD_PREFIX            "最大ドローダウン"
//--- 水平線Object名
#define LINE_NAME_PREFIX                  "line_"

//--- 水平線Object名
#define HLINE_TP_NAME                     "line_tp_hline"
#define LABEL_TP1_NAME                    "line_tp1_label"
// #define LABEL_TP2_NAME                  "line_tp2_label"
// #define LABEL_TP3_NAME                  "line_tp3_label"
#define HLINE_TP_SHADOW_NAME              "line_tp_shadow_hline"
#define HLINE_SL_NAME                     "line_sl_hline"
#define LABEL_SL1_NAME                    "line_sl1_label"
// #define LABEL_SL2_NAME                  "line_sl2_label"
// #define LABEL_SL3_NAME                  "line_sl3_label"
#define HLINE_SL_SHADOW_NAME              "line_sl_shadow_hline"
#define HLINE_ENTRY_NAME                  "line_entry_hline"
#define LABEL_ENTRY1_NAME                 "line_entry1_label"
#define LABEL_REVERSE_ICON_NAME           "line_reverse_label"
// #define LABEL_ENTRY2_NAME               "line_entry2_label"
// #define LABEL_ENTRY3_NAME               "line_entry3_label"
#define HLINE_ENTRY_SHADOW_NAME           "line_entry_shadow_hline"
#define RECTANGLE_TP_NAME                 "line_rectangle_tp_hline"
#define RECTANGLE_SL_NAME                 "line_rectangle_sl_hline"

#define SAT_NAME_PREFIX                   "sat_"

#define LABEL_CANDLETIME_NAME             "sat_candletime_label"
#define LABEL_MA_TPSL_INFO_NAME           "sat_label_tpsl_info"
#define LABEL_TRAILINGSTOP_INFO_NAME      "sat_label_trailingstop_info"

// 一時定数
int DIALOG_MIN_H;
int DIALOG_H;
int DIALOG_W;
int CLIENT_H;
int CLIENT_W;
int BACK_H;
int BACK_W;
int BORDER_H;
int BORDER_W;
int CAPTION_H;
int CAPTION_W;
int CAPTION_TOP;
int CAPTION_LEFT;
// 実体の定数
int BASE_LEFT;
int BASE_TOP;
int BASE_WIDTH;
int BASE_HEIGHT;
//--- indents and gaps
int MENU_INDENT_LEFT;
int MENU_INDENT_TOP;
int BODY_INDENT_LEFT;
int BODY_INDENT_CENTER;
int BODY_INDENT_TOP;
int BODY_INDENT_ROW;
int GRAPH_INDENT_TOP;
int GRAPH_INDENT_LEFT;
//--- menu buttons
int MENU_PANEL_EDIT_WIDTH;
int MENU_EDIT_WIDTH;
int MENU_EDIT_HEIGHT;
int MENU_EDIT_WIDE_WIDTH;
int MENU_BUTTON_WIDTH;
int MENU_BUTTON_HEIGHT;
int MENU_LABEL_WIDTH;
int MENU_LABEL_HEIGHT;
int MENU_BUTTON_INFO_INDENT_LEFT;
int MENU_BUTTON_INFO_WIDTH;
int MENU_BUTTON_INFO_HEIGHT;
//--- trade buttons
int TRADE_BUTTON_WIDTH;
int TRADE_BUTTON_HEIGHT;
//--- trade labels
int TRADE_LABEL_WIDTH;
int TRADE_LABEL_HEIGHT;
//--- tick labels
int TICK_LABEL_WIDTH;
int TICK_LABEL_HEIGHT;
//--- common labels
int COMMON_LABEL_COL1_WIDTH;
int COMMON_LABEL_COL2_WIDTH;
int COMMON_LABEL_COL3_WIDTH;
int COMMON_LABEL_COL4_WIDTH;
int COMMON_LABEL_COL5_WIDTH;
int COMMON_LABEL_COL6_WIDTH;
int COMMON_LABEL_COL3_1_1_WIDTH;
int COMMON_LABEL_COL3_1_2_WIDTH;
int COMMON_LABEL_COL3_2_1_WIDTH;
int COMMON_LABEL_COL3_2_2_WIDTH;
int COMMON_LABEL_COL3_3_1_WIDTH;
int COMMON_LABEL_COL3_3_2_WIDTH;
int COMMON_BUTTON_HEIGHT;
int COMMON_LABEL_HEIGHT;
int COMMON_LABEL_FOOTER_WIDTH;
int COMMON_LABEL_FOOTER_INDENT;
int COMMON_LABEL_FOOTER_INFO_INDENT;
int COMMON_LABEL_FOOTER_INFO_WIDTH;
//--- 決済
int INFO_LABEL_COL1_WIDTH;
int INFO_LABEL_COL2_WIDTH;
//     int INFO_LABEL_COL3_WIDTH;
int INFO_LABEL_HEIGHT;
int INFO_FOOTER_INDENT_ROW;
int INFO_BUTTON1_WIDTH;
int INFO_BUTTON1_HEIGHT;
int INFO_BUTTON2_WIDTH;
int INFO_BUTTON2_HEIGHT;
//--- ポジション一覧
int POSITION_LABEL_COL1_WIDTH;
int POSITION_LABEL_HEIGHT;
int POSITION_BUTTON1_WIDTH;
int POSITION_BUTTON1_HEIGHT;
int POSITION_BUTTON2_WIDTH;
int POSITION_BUTTON2_HEIGHT;
int POSITION_BUTTON3_WIDTH;
int POSITION_BUTTON3_HEIGHT;
int POSITION_BUTTON4_WIDTH;
int POSITION_BUTTON4_HEIGHT;
int POSITION_EDIT1_WIDTH;
int POSITION_EDIT1_HEIGHT;
//---
//--- line labels
int LINE_LABEL1_X;
// int LINE_LABEL2_X;
//     int LINE_LABEL2_2_X;
//     int LINE_LABEL3_X;
int LINE_LABEL1_WIDTH;
int LINE_LABEL1_HEIGHT;
int LINE_LABEL2_WIDTH;
int LINE_LABEL2_HEIGHT;
int LINE_LABEL3_WIDTH;
int LINE_LABEL3_HEIGHT;

//---
//--- position labels
int POSITION_LABEL1_WIDTH;
int POSITION_LABEL1_HEIGHT;
int POSITION_LABEL2_WIDTH;
int POSITION_LABEL2_HEIGHT;

int POSITION_MENU_CLOSE_WIDTH;
int POSITION_MENU_CLOSE_HEIGHT;

//---
//--- position menu
int POSITION_MENU_MAIN_WIDTH;
int POSITION_MENU_MAIN_HEIGHT;
int POSITION_MENU_SUB_WIDTH;
int POSITION_MENU_SUB_HEIGHT_01;
int POSITION_MENU_SUB_HEIGHT_02;
int POSITION_MENU_SUB_ROW_INDENT;
int POSITION_MENU_SUB_COL_INDENT;
int POSITION_MENU_SUB_LABEL_WIDTH;
int POSITION_MENU_SUB_LABEL_HEIGHT;
int POSITION_MENU_SUB_EDIT_WIDTH;
int POSITION_MENU_SUB_EDIT_HEIGHT;
int POSITION_MENU_SUB_BUTTON_WIDTH;
int POSITION_MENU_SUB_BUTTON_HEIGHT;

//---
//--- graph
int GRAPH_PANEL_MAIN_WIDTH;
int GRAPH_PANEL_MAIN_HEIGHT;
int GRAPH_PANEL_CANVAS_HEIGTH;
int GRAPH_PANEL_LABEL_WIDTH;

//---
//--- graph
int LINE_CANDLETIME_WIDTH;
int LINE_CANDLETIME_HEIGHT;

// 端末情報
double oringin_ratio = 1;
double oringin_ratio_not_zoom = 1;

// シンボル情報
int symbolInfo_filling_type;

// 注文情報
int order_filling_type;

// バックテストの判定用変数
bool is_tester = false;

// 許可口座一覧
bool accountControlEnable = false;
int accountList[] = {

};

//--- input parameters
input double      ORG_MaxLossMarginPercent=5; // 自動ロット計算設定：最大損失証拠金%
double MaxLossMarginPercent;
int ExitPercent=100;

string   main_Font                     = "Yu Gothic Medium";       // 文字フォント
int      ORG_my_caption_FontSize           = 9;                   // タイトルのフォントサイズ
color    my_caption_Color              = 0x000000;    // タイトルの文字色
color    my_caption_ColorBackground    = C'240,240,240';    // タイトルの背景色
color    my_caption_ColorBorder        = C'240,240,240';    // タイトルの枠の色

color    my_border_ColorBorder        = C'240,240,240';    // 外側の枠の色

color    my_client_ColorBackground    = C'240,240,240';     // 内側の背景の色
color    my_client_ColorBorder        = C'240,240,240';     // 内側の枠の色

int      ORG_menu_FontSize                = 10;                   // メニューボタンのフォントサイズ
color    menu_Color                   = 0x000000;    // メニューボタンの文字色
color    menu_ColorBackground         = C'216,216,216';    // メニューボタンの背景色

color    symbol_menu_ColorBackground = C'240,240,240';
color    symbol_menu_ColorSelected = C'98,193,251';

// 決済ボタンの文字列
string info_nonactive_text               = "...";
string info_active_text                  = "✕";
// 決済ボタンの色
color    menu_info_Color                     = 0x000000;          // 決済の文字色
color    menu_info_ColorBackground           = C'106,106,106';  // 決済の背景色
color    menu_info_nonactive_Color           = 0x000000;          // 決済の文字色（無効の時）
color    menu_info_nonactive_ColorBackground = C'216,216,216';  // 決済の背景色（無効の時）

int      ORG_trade_main_FontSize           = 14;                   // 取引ボタン（文字）のフォントサイズ
int      ORG_trade_price_FontSize          = 12;                   // 取引ボタン（価格）のフォントサイズ
color    trade_ask_Color                   = 0xFFFFFF;    // 取引ボタン（買う）の文字色
color    trade_ask_ColorBackground         = C'123,183,59';    // 取引ボタン（買う）の背景色
color    trade_ask_nonactive_Color                   = C'122,122,122';    // 取引ボタン（買う）の文字色（無効の時）
color    trade_ask_nonactive_ColorBackground         = C'39,57,19';    // 取引ボタン（買う）の背景色（無効の時）
color    trade_bid_Color                   = 0xFFFFFF;    // 取引ボタン（売る）の文字色
color    trade_bid_ColorBackground         = C'205,56,64';    // 取引ボタン（売る）の背景色
color    trade_bid_nonactive_Color                   = C'122,122,122';    // 取引ボタン（買う）の文字色（無効の時）
color    trade_bid_nonactive_ColorBackground         = C'42,0,1';    // 取引ボタン（買う）の背景色（無効の時）

int      ORG_common_FontSize               = 9;                   // その他文字のフォントサイズ
color    common_Color                  = 0x000000;    // その他文字の文字色

color    common_edit_ColorBackground     = 0xFFFFFF;    // ロット入力の背景色

color    common_line_ColorBorder        = clrGainsboro;    // 損切文字の下の水平線の色

color    lot_active_Color                   = 0x000000;    // ﾛｯﾄ自動手動切替ボタン（active）の文字色
color    lot_active_ColorBackground         = C'106,106,106';    // ﾛｯﾄ自動手動切替ボタン（active）の背景色
color    lot_nonactive_Color                = 0x000000;    // ﾛｯﾄ自動手動切替ボタン（nonactive）の文字色
color    lot_nonactive_ColorBackground      = C'216,216,216';    // ﾛｯﾄ自動手動切替ボタン（nonactive）の背景色

color    tp_active_Color                   = clrWhite;    // tp自動切替ボタン（active）の文字色
color    tp_active_ColorBackground         = clrDarkSlateGray;    // tp自動切替ボタン（active）の背景色
color    tp_nonactive_Color                = 0x000000;    // tp自動切替ボタン（nonactive）の文字色
color    tp_nonactive_ColorBackground      = clrDarkSlateGray;    // tp自動切替ボタン（nonactive）の背景色

color    sl_active_Color                   = clrWhite;    // sl自動切替ボタン（active）の文字色
color    sl_active_ColorBackground         = clrDarkSlateGray;    // sl自動切替ボタン（active）の背景色
color    sl_nonactive_Color                = 0x000000;    // sl自動切替ボタン（nonactive）の文字色
color    sl_nonactive_ColorBackground      = clrDarkSlateGray;    // sl自動切替ボタン（nonactive）の背景色

color    horizon_active_Color                   = clrBlack;    // 水平線切替ボタン（active）の文字色
color    horizon_active_ColorBackground         = C'106,106,106';    // 水平線切替ボタン（active）の背景色
color    horizon_nonactive_Color                = 0x000000;    // 水平線切替ボタン（nonactive）の文字色
color    horizon_nonactive_ColorBackground      = C'216,216,216';    //水平線切替ボタン（nonactive）の背景色

color    alerm_active_Color                   = clrBlack;    // アラーム切替ボタン（active）の文字色
color    alerm_active_ColorBackground         = C'106,106,106';    // アラーム切替ボタン（active）の背景色
color    alerm_nonactive_Color                = 0x000000;    // アラーム切替ボタン（nonactive）の文字色
color    alerm_nonactive_ColorBackground      = C'216,216,216';    // アラーム切替ボタン（nonactive）の背景色

color    bg_active_Color                   = clrBlack;    // 背景切替ボタン（active）の文字色
color    bg_active_ColorBackground         = C'216,216,216';    // 背景切替ボタン（active）の背景色
color    bg_nonactive_Color                = 0x000000;    // 背景切替ボタン（nonactive）の文字色
color    bg_nonactive_ColorBackground      = C'216,216,216';    // 背景切替ボタン（nonactive）の背景色

int      ORG_line_FontSize                = 10;   // 水平線のフォントサイズ

int      line_color                = 16777215;   // 水平線下の価格の文字色
color    tp_line_color                 = C'123,183,59';    // 利確水平線の線の色
color    tp_line_text_color            = 0xFFFFFF;    // 利確水平線の文字色
color    sl_line_color                 = C'205,56,64';    // 損切水平線の線の色
color    sl_line_text_color                 = 0xFFFFFF;    // 損切水平線の文字色
color    entry_line_color                 = C'253,170,31';    // エントリー水平線の線の色
color    entry_line_text_color                 = 0xFFFFFF;    // エントリー水平線の文字色

// カメラボタンの設定
color    camera_Color                = 0x000000;              // カメラボタンの文字色
color    camera_ColorBackground      = C'216,216,216';      // カメラボタンの背景色

// ポジションラベル＋ボタン
color    position_line_color                 = 0xF0F0F0;    // ポジションラベルの線の色
color    position_line_text_color            = 0x000000;    // ポジションラベルの文字色
color    position_line_button_color                 = 0xF0F0F0;    // ポジションメニューボタンの色
color    position_line_button_active_color          = 0xC0C0C0;    // ポジションメニューボタンの色（アクティブ時）
color    position_line_button_border_color          = 0xF0F0F0;    // ポジションメニューボタンの枠線の色
color    position_line_button_text_color            = 0x000000;    // ポジションメニューボタンの文字色

// ポジションTP、SLボタン
color    position_line_tp_button_color                 = 0xF0F0F0;    // ポジションメニューTPボタンの線の色
color    position_line_tp_button_border_color          = 0xF0F0F0;    // ポジションメニューTPボタンの枠線の色
color    position_line_tp_button_text_color            = 0x000000;    // ポジションメニューTPボタンの文字色
color    position_line_sl_button_color                 = 0xF0F0F0;    // ポジションメニューSLボタンの線の色
color    position_line_sl_button_border_color          = 0xF0F0F0;    // ポジションメニューSLボタンの枠線の色
color    position_line_sl_button_text_color            = 0x000000;    // ポジションメニューSLボタンの文字色
color    position_line_order_button_color                 = 0xF0F0F0;    // ポジションメニューORDERボタンの線の色
color    position_line_order_button_border_color          = 0xF0F0F0;    // ポジションメニューORDERボタンの枠線の色
color    position_line_order_button_text_color            = 0x000000;    // ポジションメニューORDERボタンの文字色

// ポジションメニュー
color    position_menu_ColorBackground    = C'244,244,244';     // ポジションメニューの内側の背景の色
color    position_menu_ColorBorder        = C'216,216,216';     // ポジションメニューの内側の枠の色
color    position_menu_active_ColorBackground    = C'98,193,251';     // ポジションメニューの選択行の背景の色
color    position_menu_close_ColorBackground    = C'244,244,244';     // ポジションメニューの閉じるの背景の色
color    position_menu_close_ColorBackground_active  = C'255,77,77';     // ポジションメニューの閉じるの背景の色
color    position_menu_close_ColorBorder        = C'106,106,106';     // ポジションメニューの閉じるの枠の色

//
color    graph_panel_ColorBackground    = C'240,240,240';     // ポジションメニューの内側の背景の色
color    graph_panel_ColorBorder        = C'216,216,216';     // ポジションメニューの内側の枠の色

int      ORG_POSITION_MENU_MAIN_WIDTH     = 150;               // ポジションメニューのサイズ（左パネルの横幅）
int      ORG_POSITION_MENU_MAIN_HEIGHT    = 30;                // ポジションメニューのサイズ（左パネルの１行の高さ）
int      ORG_POSITION_MENU_SUB_WIDTH      = 150;               // ポジションメニューのサイズ（右パネルの横幅）
int      ORG_POSITION_MENU_SUB_HEIGHT_01  = 60;                // ポジションメニューのサイズ（右パネルの%クローズの時の高さ）
int      ORG_POSITION_MENU_SUB_HEIGHT_02  = 90;                // ポジションメニューのサイズ（右パネルのTP,SL設定の時の高さ）
int      ORG_POSITION_MENU_CLOSE_WIDTH    = 30;                // ポジションメニューのサイズ（閉じるボタン）
int      ORG_POSITION_MENU_CLOSE_HEIGHT   = 30;                // ポジションメニューのサイズ（閉じるボタン）
int      ORG_POSITION_MENU_SUB_ROW_INDENT     = 5;             // ポジションメニューのサイズ（右パネルのobject余白）
int      ORG_POSITION_MENU_SUB_COL_INDENT     = 5;             // ポジションメニューのサイズ（右パネルのobject余白）
int      ORG_POSITION_MENU_SUB_LABEL_WIDTH    = 50;            // ポジションメニューのサイズ（右パネルのTPSLラベルの横幅）
int      ORG_POSITION_MENU_SUB_LABEL_HEIGHT   = 20;
int      ORG_POSITION_MENU_SUB_EDIT_WIDTH     = 70;            // ポジションメニューのサイズ（右パネルの入力の横幅）
int      ORG_POSITION_MENU_SUB_EDIT_HEIGHT    = 20;            // ポジションメニューのサイズ（右パネルの入力の高さ）
int      ORG_POSITION_MENU_SUB_BUTTON_WIDTH   = 30;            // ポジションメニューのサイズ（右パネルのボタンの横幅）
int      ORG_POSITION_MENU_SUB_BUTTON_HEIGHT  = 20;            // ポジションメニューのサイズ（右パネルのボタンの高さ）

int      ORG_GRAPH_PANEL_MAIN_WIDTH       = 450;
int      ORG_GRAPH_PANEL_MAIN_HEIGHT      = 565;
int      ORG_GRAPH_PANEL_CANVAS_HEIGHT    = 400;
int      ORG_GRAPH_PANEL_LABEL_WIDTH      = 300;

color    candletime_line_color             = clrBlack;   // ローソククローズまでの時間の線の色
color    candletime_line_text_color        = 0xFFFFFF;       // ローソククローズまでの時間の文字色

color    info_sell_exit_Color                   = 0xFFFFFF;    // 売り一括決済の文字色
color    info_sell_exit_ColorBackground         = C'205,56,64';    // 買い一括決済の背景色
color    info_sell_tatene_Color                   = 0xFFFFFF;    // 売り一括sl建値の文字色
color    info_sell_tatene_ColorBackground         = C'123,183,59';    // 買い一括sl建値の背景色
color    info_sell_deltp_Color                   = 0xFFFFFF;    // 売り一括tp削除の文字色
color    info_sell_deltp_ColorBackground         = C'141,39,14';    // 買い一括tp削除の背景色
color    info_buy_exit_Color                   = 0xFFFFFF;    // 売り一括決済の文字色
color    info_buy_exit_ColorBackground         = C'123,183,59';    // 買い一括決済の背景色
color    info_buy_tatene_Color                   = 0xFFFFFF;    // 売り一括sl建値の文字色
color    info_buy_tatene_ColorBackground         = C'0,106,106';    // 買い一括sl建値の背景色
color    info_buy_deltp_Color                   = 0xFFFFFF;    // 売り一括tp削除の文字色
color    info_buy_deltp_ColorBackground         = C'0,106,106';    // 買い一括tp削除の背景色
color    info_all_exit_Color                   = 0xFFFFFF;    // 全て一括決済の文字色
color    info_all_exit_ColorBackground         = C'253,170,31';    // 全て一括決済の背景色
color    info_all_tatene_Color                   = 0xFFFFFF;    // 全て一括sl建値の文字色
color    info_all_tatene_ColorBackground         = C'106,106,106';    // 全て一括sl建値の背景色
color    info_all_deltp_Color                   = 0xFFFFFF;    // 全て一括tp削除の文字色
color    info_all_deltp_ColorBackground         = C'106,106,106';    // 全て一括tp削除の背景色
color    info_pending_cancel_Color              = 0xFFFFFF;    // 待機注文一括削除の文字色
color    info_pending_cancel_ColorBackground    = C'53,53,53';    // 待機注文一括削除の背景色

enum bg_select {
   BlackBg=1, // 黒背景の時
   WhiteBg=2  // 白背景の時
};
input bg_select bg_select_p = BlackBg; // 水平線間の背景色カラーパターン選択


color    line_tp_fill_ColorBackground_black    = C'21,32,11';    // TP水平線の背景色
color    line_sl_fill_ColorBackground_black    = C'33,10,11';    // SL水平線の背景色
color    line_tp_fill_ColorBackground_white    = C'226,241,211';    // TP水平線の背景色
color    line_sl_fill_ColorBackground_white    = C'244,215,216';    // SL水平線の背景色
// input uchar    line_fill_Alpha                  = 100;    // 水平線の背景色の透明度（0-255）

color    updown_nonactive_Color                = 0x000000;    // 損失率updownボタンの文字色
color    updown_nonactive_ColorBackground      = clrGainsboro;    // 損失率updownボタンの背景色

enum tool_zoom_rate {
   lv1, // 1.0倍で表示
   lv2,  // 1.1倍で表示
   lv3,  // 1.2倍で表示
   lv4,  // 1.3倍で表示
   lv5,  // 1.4倍で表示
   lv6,  // 1.5倍で表示
   lv7,  // 1.6倍で表示
   lv8,  // 1.7倍で表示
   lv9,  // 1.8倍で表示
   lv10,  // 1.9倍で表示
   lv11  // 2.0倍で表示
};
tool_zoom_rate zoom_rate_select = lv1; // 注文ツールの表示倍率

enum ENUM_SWITCH
{
   ON,
   OFF
};
input bool           horizon_label_flg = true; // 水平線右はずのラベル false=OFF、true=ON
input ENUM_SWITCH    mktorder_check_tpsl_flg = ON; // 成行注文時に水平線ボタンOFFで売買を許可する
input bool           InpMAStopOnBarClose=false; // MA決済注文のブレイク判定を足確定まで待つ
input int            InpMATPSLInfo_FontSize=10;
input color          InpMATPSLInfo_FontColor=clrRed;
input int            InpTrailingStopInfo_FontSize=10;
input color          InpTrailingStopInfo_FontColor=clrRed;

int calc_timer_ms = 150; // ツールの全ての再計算をするタイマー間隔（ミリ秒）

// 実体変数
int      my_caption_FontSize  = 10;                   // タイトルのフォントサイズ
int      menu_FontSize        = 10;                   // メニューボタンのフォントサイズ
int      trade_main_FontSize  = 14;                   // 取引ボタン（文字）のフォントサイズ
int      trade_price_FontSize = 12;                   // 取引ボタン（価格）のフォントサイズ
int      common_FontSize      = 10;                   // その他文字のフォントサイズ
int      line_FontSize        = 10;                   // 水平線のフォントサイズ
int      graph_ProfitFontSize = 14;                   // グラフの損益表示フォント

//--- status parameters
int trade_mode = 1; // 1=成行、2=指値、3=逆指、4=決済
int trace_mode = 1; // 1=手動、2=追従
int auto_manual_flg = 1; // 1=自動、2=手動
int tp_set_flg = 1; // 0=OFF、1=ON
int sl_set_flg = 1; // 0=OFF、1=ON
int horizon_set_flg = 0; // 0=OFF、1=ON
int alerm_set_flg = 0; // 0=OFF、1=ON
int bg_set_flg = 1; // 0=OFF、1=ON
int position_panel_set_flg = 0; // 0=OFF、1=ON
int graph_panel_set_flg = 0; // 0=OFF、1=ON
datetime last_alerm_tp, last_alerm_sl;
double Lot = 0.10;
double sp, tp, sl, ep, ep_ask, tp_pips, sl_pips, plplan, slplan;
string plslrate, winrate;
ENUM_ORDER_TYPE order_type = ORDER_TYPE_BUY;
string  lastSymbol;
int last_line_fix_time = GetTickCount();
double last_tp, last_sl;

// 最小化中に足を切り替えるとパネルが表示されてしまう不具合対応
bool dialogMminimized=false;
bool symbolMenuExpanded=false;
bool graphSymbolMenuExpanded=false;

enum GRAPH_PERIOD {
   DAY,
   MONTH,
   YEAR
};
string       graphSymbol=_Symbol;
GRAPH_PERIOD graphPeriod=DAY; // 0=DAY, 1=MONTH, 2=YEAR

// ポジション制御のため
int position_tickets[];
int open_menu_position_ticket;
int position_tps[];
int position_sls[];
int order_tickets[];
int position_label_ys[];

struct CPositionTrailingStopSet
  {
   CPositionTrailingStopSet()
      : ticket(-1)
      , targetPips(0)
     {}
      
   ulong    ticket;
   double   targetPips;
  };
  
struct CPositionMAStopSet
  {
   CPositionMAStopSet()
      : ticket(-1)
      , timeframe(0)
      , maTpFlg(false)
      , maTpPeriod(0)
      , maTpMethod(0)
      , maSlFlg(false)
      , maSlPeriod(0)
      , maSlMethod(0)
     {}
     
   ulong             ticket;
   ENUM_TIMEFRAMES   timeframe;
   bool              maTpFlg;
   int               maTpPeriod;
   ENUM_MA_METHOD    maTpMethod;
   bool              maSlFlg;
   int               maSlPeriod;
   ENUM_MA_METHOD    maSlMethod;
  };

CPositionTrailingStopSet   _positionTrailingStopSets[];
CPositionMAStopSet         _positionMAStopSets[];

string                     _fileName_positionMAStopSets="SAT_positionMAStopSets";
string                     _fileName_positionTrailingStopSets="SAT_positionTrailingStopSets";

MqlTick latest_price;     // To be used for getting recent/latest price quotes
// copybuffer
MqlRates rates[];
string currency="";

int      _mkt_symbols_total;
string   _mkt_symbols[];

struct PROFIT_STATISTICS
{
   PROFIT_STATISTICS()
      : totalProfit(0)
      , totalTrades(0)
      , longTrades(0)      
      , shortTrades(0)
      , longTradesWinPercent(0)
      , shortTradesWinPercent(0)
      , profitFactor(0)
      , maxDrawdown(0)
      , maxDrawdownPercent(0)
   {}
   
   double   totalProfit;
   int      totalTrades;
   int      longTrades;   
   int      shortTrades;
   double   longTradesWinPercent;
   double   shortTradesWinPercent;
   double   profitFactor;
   double   maxDrawdown;
   double   maxDrawdownPercent;
};

class CGraphicCustom : public CGraphic
  {
   protected:
      virtual void      CreateHistory(void) {}
      virtual void      CreateGrid(void);
   
   public:
      void UpdatePLCurve(double& y[]);
  };
  
void CGraphicCustom::CreateGrid(void)
{
   int yc0=-1.0;
   for(int i=1; i<m_ysize-1; i++)
     {
      if(StringToDouble(m_yvalues[i])==0.0)
        {
         yc0=m_yc[i];
         break;
        }
     }
//---
   if(yc0>0)
      m_canvas.LineHorizontal(m_left+1,m_width-m_right,yc0,m_grid.clr_axis_line);
//---
}

void CGraphicCustom::UpdatePLCurve(double& y[])
{
   for (int i=CurvesTotal()-1;i>=0;i--)
      CurveRemoveByIndex(i);
   
   int y_size=ArraySize(y);
   
   if(y_size==0)  return;
      
   CPoint2D pt2Ds[];
   ArrayResize(pt2Ds,1,100);
   int total=1;
   pt2Ds[0].x = 0;
   pt2Ds[0].y = y[0];
      
   CPoint2D curPt2D;
   CPoint2D lastPt2D = pt2Ds[0];
   CPoint2D lastPt2D1 = pt2Ds[0];
   
   CCurve *curve;
   bool isNewCurveStarted = false;
   
   for(int i=1; i<y_size; i++)
     {
      curPt2D.x = i;
      curPt2D.y = y[i];
         
      if(lastPt2D.y*curPt2D.y<=0)
        {        
         curve = CurveAdd(pt2Ds,lastPt2D1.y>=0?ColorToARGB(clrGreen):ColorToARGB(clrRed),CURVE_LINES);
         curve.LinesWidth(2);
         
         isNewCurveStarted=true;
        }  
        
      if(isNewCurveStarted)
        {
         total=1;
         ArrayResize(pt2Ds,1,100);         
         pt2Ds[0]=lastPt2D;
         
         isNewCurveStarted = false;
        }
        
      total++;
      if(total>ArraySize(pt2Ds))
         ArrayResize(pt2Ds,total,100);
         
      pt2Ds[total-1] = curPt2D; 
      
      lastPt2D1 = lastPt2D;  
      lastPt2D = curPt2D;  
     }
   
   if(!isNewCurveStarted)
     {
      curve = CurveAdd(pt2Ds,lastPt2D.y>=0?ColorToARGB(clrGreen):ColorToARGB(clrRed),CURVE_LINES);
      curve.LinesWidth(2);
     }
}
  
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CAppWindowSelTradingTool : public CAppDialog
  {
protected:
   CSymbolInfo       m_symbolInfo;   
   CPositionInfo     m_position;                      // trade position object
   COrderInfo        m_order;                         // trade order object
   CTrade            m_trade;                         // trading object
   CAccountInfo      m_account;                       // account info wrapper

private:
   CPanel            my_border;
   CPanel            my_back;
   CWndClient        my_client;
   CEdit             my_caption;
   CBmpButton        my_minmaxbtn;
   CBmpButton        my_closebtn;
   CPanel            m_sub_main_panel;
   CEdit             m_menu_symbol;
   CEdit             m_menu_status;
   CPanel            m_menu_popup_panel;
   CEdit             m_menu_popup_items[];   
   CButton           m_menu_button_market;
   CButton           m_menu_button_limit;
   CButton           m_menu_button_stoplimit;
   CButton           m_menu_button_info;
   CLabel            m_menu_label_now_menu;   
   CButton           m_trade_button_ask;
   CButton           m_trade_button_bid;
   CLabel            m_trade_label_ask;
   CLabel            m_trade_label_bid;
   CLabel            m_tick_label_ask;
   CLabel            m_tick_label_bid;
   CLabel            m_common_label_lot_str;
   CLabel            m_common_label_risk_str;
   CLabel            m_common_label_pl_str;
   CLabel            m_common_label_sl_str;
   CLabel            m_common_label_pl_price;
   CLabel            m_common_label_sl_price;
   // CLabel            m_common_label_pl_pips;
   // CLabel            m_common_label_sl_pips;
   CLabel            m_common_label_pl_pips_str;
   CLabel            m_common_label_sl_pips_str;
   CLabel            m_common_label_plslrate;
   CLabel            m_common_label_plslrate_str;
   CLabel            m_common_label_winrate_str;
   // CLabel            m_common_label_winrate;
   CLabel            m_common_label_winrate_percent_str;
   CLabel            m_common_label_plplan_str;
   CLabel            m_common_label_slplan_str;
   // CLabel            m_common_label_plplan;
   // CLabel            m_common_label_slplan;
   CLabel            m_common_label_plplan_currency;
   CLabel            m_common_label_slplan_currency;
   CButton           m_common_button_auto;
   CButton           m_common_button_manual;
   CEdit             m_common_lot;
   CEdit             m_common_risk;
   CButton           m_common_risk_up;
   CButton           m_common_risk_down;

   CPanel            m_common_line1;
   CPanel            m_common_line2;

   CButton           m_common_button_tp;
   CButton           m_common_button_sl;
   CButton           m_common_button_horizon;
   CButton           m_common_button_alerm;
   CButton           m_common_button_bg;
   CButton           m_common_button_reset;
   CButton           m_common_button_graph;
   
   CLabel            m_info_label_position_sell;
   CLabel            m_info_label_position_sell_price;
   CLabel            m_info_label_position_buy;
   CLabel            m_info_label_position_buy_price;
   CLabel            m_info_label_position_all;
   CLabel            m_info_label_position_all_price;
   CLabel            m_info_label_account_info01;
   CLabel            m_info_label_account_info01_price;
   CLabel            m_info_label_account_info02;
   CLabel            m_info_label_account_info02_price;
   CLabel            m_info_label_account_info03;
   CLabel            m_info_label_account_info03_price;
   CLabel            m_info_label_account_info04;
   CLabel            m_info_label_account_info04_price;
   CLabel            m_info_label_order_all;
   CButton           m_info_button_exit_sell;
   CButton           m_info_button_tatene_sell;
   CButton           m_info_button_deltp_sell;
   CButton           m_info_button_exit_buy;
   CButton           m_info_button_tatene_buy;
   CButton           m_info_button_deltp_buy;
   CButton           m_info_button_exit_all;
   CButton           m_info_button_tatene_all;
   CButton           m_info_button_deltp_all;
   CButton           m_info_button_cancel_all;
   CPanel            m_info_line1;
   CPanel            m_info_line2;
   CPanel            m_info_line3;

   CPanel            m_position_panel;
   CLabel            m_position_label_list;
   CLabel            m_position_label_percent;
   CEdit             m_position_edit_percent;
   CButton           m_position_button_percent_up;
   CButton           m_position_button_percent_down;
   CButton           m_position_button_percent_up_10;
   CButton           m_position_button_percent_down_10;

   CButton           m_info_button_camera;

   CPanel            m_position_menu_main_panel;
   CPanel            m_position_menu_sub_panel;
   CPanel            m_position_menu_main_exit_panel;
   CPanel            m_position_menu_main_doten_panel;
   CPanel            m_position_menu_main_percent_exit_panel;
   CPanel            m_position_menu_main_sltatene_panel;
   CPanel            m_position_menu_main_trailingstop_panel;
   CPanel            m_position_menu_main_tpsl_panel;
   CPanel            m_position_menu_main_ma_tpsl_panel;
   CButton           m_position_menu_main_close;
   CLabel            m_position_menu_main_exit;
   CLabel            m_position_menu_main_doten;
   CLabel            m_position_menu_main_percent_exit;
   CLabel            m_position_menu_main_sltatene;
   CLabel            m_position_menu_main_trailingstop;
   CLabel            m_position_menu_main_tpsl;
   CLabel            m_position_menu_main_ma_tpsl;
   CLabel            m_position_menu_sub_percent_label;
   CEdit             m_position_menu_sub_percent_input;
   CButton           m_position_menu_sub_percent_exit;
   CCheckBoxEx       m_position_menu_sub_trailingstop_chk;
   CEdit             m_position_menu_sub_trailingstop_targetpips;
   CButton           m_position_menu_sub_trailingstop_set;
   CLabel            m_position_menu_sub_tp_label;
   CLabel            m_position_menu_sub_sl_label;
   CEdit             m_position_menu_sub_tpsl_tp_input;
   CEdit             m_position_menu_sub_tpsl_sl_input;
   CButton           m_position_menu_sub_tpsl_set;
   CCheckBoxEx       m_position_menu_sub_ma_tp_chk;
   CCheckBoxEx       m_position_menu_sub_ma_sl_chk;
   CComboBox         m_position_menu_sub_ma_tp_method;
   CComboBox         m_position_menu_sub_ma_sl_method;
   CEdit             m_position_menu_sub_ma_tp_period;
   CEdit             m_position_menu_sub_ma_sl_period;
   CButton           m_position_menu_sub_ma_tpsl_set;
   
   CPanel            m_graph_main_panel;
   CPanel            m_graph_popup_panel;
   CEdit             m_graph_symbol;
   CEdit             m_graph_popup_items[];
   //CPanel            m_graph_sub_top_panel;
   //CPanel            m_graph_sub_main_panel;
   //CPanel            m_graph_sub_bottom_panel;
   CButton           m_graph_pday_button;
   CButton           m_graph_pmonth_button;
   CButton           m_graph_pyear_button;
   
   CLabel            m_graph_totalProfit_label;    // 取引回数
   CLabel            m_graph_totalTrades_label;    // 取引回数
   CLabel            m_graph_longTrades_label;     // ロングポジション
   CLabel            m_graph_shortTrades_label;    // ショットポジション
   CLabel            m_graph_profitFactor_label;   // ブロフィットファクター
   CLabel            m_graph_maxDrawdown_label;    // 最大ドローダウン
   
   CGraphicCustom    m_graph_profitGraph;
public:
                     CAppWindowSelTradingTool(void);
                    ~CAppWindowSelTradingTool(void);
   //--- destroy                    
   virtual void      Destroy(const int reason=REASON_PROGRAM);                    
   //--- create
   virtual bool      CreateLine(void);
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   virtual bool      InitObject();
   virtual bool      CreateCLabel(CLabel &obj, string name, string text, string font, int font_size, color font_color, color bg_color, int w, int h, ENUM_ANCHOR_POINT align);
   virtual bool      CreateCButton(CButton &obj, string name, string text, string font, int font_size, color font_color, color bg_color, color border_color, int w, int h, ENUM_ALIGN_MODE align);
   virtual bool      CreateCEdit(CEdit &obj, string name, string text, string font, int font_size, color font_color, color bg_color, int w, int h, ENUM_ALIGN_MODE align, bool read_only = false);
   virtual bool      CreateCPanel(CPanel &obj, string name, color bg_color, color border_color, int w, int h, int zorder=0);
   virtual bool      CreateCBitmap(CPanel &obj, string name, color border_color, color bg_color, int w, int h, int zorder);
   bool              CreateCCombobox(CComboBox &obj, string name, int w, int h);
   bool              CreateCCheckBox(CCheckBoxEx &obj, string name, string text, string font, int font_size, color font_color, int w, int h);
   
   bool              CreatePositionStopInfoObj();
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- tick event
   virtual void      OnTick(void);
   //--- timer event
   virtual void      OnTimer(void);
   //--- line event
   // virtual void      OnLineDrag(string sparam);
   // virtual void      OnLineClick(string sparam);
   virtual bool      Hide(void);
   virtual bool      Show(void);
   virtual void      ReDraw(void);
   //--- calc
   virtual MqlTradeRequest   CreateBuyRequest(void);
   virtual MqlTradeRequest   CreateSellRequest(void);
   //--- 最小最大ボタンイベント
   virtual void  OnClickButtonMinMax();
   virtual void  Minimize();
   virtual void  Maximize();
   virtual bool  OnDialogDragStart();
   virtual bool  OnDialogDragProcess();
   virtual bool  OnDialogDragEnd();
   //--- position function
   virtual bool  CreateAndUpdatePositionObjects();
   virtual bool  CreatePositionObject(int tickt);
   virtual bool  CreatePositionTpObject(int tickt);
   virtual bool  CreatePositionSlObject(int tickt);
   virtual bool  CreateOrderObject(int tickt);
   virtual bool  DeletePositionObject(int tickt);
   virtual bool  DeletePositionTpObject(int tickt);
   virtual bool  DeletePositionSlObject(int tickt);   
   virtual bool  DeleteOrderObject(int tickt);
   virtual bool  MovePositionObject(int tickt);
   virtual bool  MovePositionTpObject(int tickt);
   virtual bool  MovePositionSlObject(int tickt);
   virtual bool  MoveOrderObject(int tickt);
   virtual void  ShowPositionStopInfo(ulong tickt);
   
   virtual bool  CreatePositionMenu(double x, double y, string sparam);
   virtual bool  RemovePositionTp(double x, double y, string sparam);
   virtual bool  RemovePositionSl(double x, double y, string sparam);
   virtual bool  RemoveOrder(double x, double y, string sparam);
   virtual bool  ChkOnMouse(double x, double y, string sparam);
   
   void UpdateGraph();
   
   bool ChkAxesOnPopupPanel(double x, double y);
protected:
   //--- create dependent controls
   bool              CreateSymbolPopupMenu();
   bool              CreateTopMenu(int x, int y);
   bool              CreateCommon(int x, int y);
   bool              CreateSub(void);
   bool              CreateMarket(void);
   bool              CreateLimit(void);
   bool              CreateStopLimit(void);
   bool              CreateInfo(void);
   bool              CreateGraphPanel(void);   
   bool              CreateGraph(void);
   bool              CreateSubGraph(void);
   bool              CreateGraphSymbolPopupMenu();
   //--- destoroy dependent controls
   bool              HideAll(string prefix);
   //--- handlers of the dependent controls events   
   void              OnClickMenuMarket(void);
   void              OnClickMenuLimit(void);
   void              OnClickMenuStopLimit(void);
   void              OnClickMenuInfo(void);
   void              OnClickMenuSymbol(void);
   void              OnClickPopupMenuSymbol(const long& lparam, const double& dparam, const string& sparam);
   //--- trade event
   void              OnClickAsk(void);
   void              OnClickBid(void);
   void              OnClickInfoSellExit(void);
   void              OnClickInfoSellSlTatene(void);
   void              OnClickInfoSellTpDelete(void);
   void              OnClickInfoBuyExit(void);
   void              OnClickInfoBuySlTatene(void);
   void              OnClickInfoBuyTpDelete(void);
   void              OnClickInfoAllExit(void);
   void              OnClickInfoAllSlTatene(void);
   void              OnClickInfoAllTpDelete(void);
   void              OnClickInfoAllCancel(void);
   void              OnClickRiskUp(void);
   void              OnClickRiskDown(void);
   void              OnClickPositionClose(void);
   void              OnClickPercentUp10(void);
   void              OnClickPercentUp(void);
   void              OnClickPercentDown(void);
   void              OnClickPercentDown10(void);
   //--- setting event
   void              OnClickAuto(void);
   void              OnClickManual(void);
   void              OnClickTpAuto(void);
   void              OnClickSlAuto(void);
   void              OnClickHorizon(void);
   void              OnClickAlerm(void);
   void              OnClickBg(void);
   void              OnClickReset(void);
   void              OnClickCamera(void);
   void              OnClickGraph(void);
   //--- edit event
   void              OnEndEditLot(void);
   void              OnEndEditRisk(void);
   void              OnEndEditPercent(void);
   //--- ポジションメニューイベント
   void              OnPositionMenuClose(void);
   void              OnPositionMenuExit(void);
   void              OnPositionMenuDoten(void);
   void              OnPositionMenuPercentExitMenu(void);
   void              OnPositionMenuSlTatene(void);
   void              OnPositionMenuTrailingStopMenu(void);
   void              OnPositionMenuTpSlMenu(void);
   void              OnPositionMenuMATpSlMenu(bool forceExpand=false);
   void              OnPositionMenuPercentExitExec(void);
   void              OnPositionMenuTpSlSet(void);
   // void              OnPositionMenuCloseFocus(void);
   // void              OnPositionMenuExitFocus(void);
   // void              OnPositionMenuDotenFocus(void);
   // void              OnPositionMenuPercentMenuFocus(void);
   // void              OnPositionMenuSlTateneFocus(void);
   // void              OnPositionMenuTpSlMenuFocus(void);
   // void              OnPositionMenuCloseFocusOut(void);
   // void              OnPositionMenuExitFocusOut(void);
   // void              OnPositionMenuDotenFocusOut(void);
   // void              OnPositionMenuPercentMenuFocusOut(void);
   // void              OnPositionMenuSlTateneFocusOut(void);
   // void              OnPositionMenuTpSlMenuFocusOut(void);
   void              OnPositionMenuTrailingStopSet(void);   
   void              OnPositionMenuMATpSlSet();
   
   void              OnCalculateMAStop();
   void              OnCalculateTrailingStop();
   
   //--- graph
   void              OnClickGraphSymbol(void);
   void              OnClickGraphPeriodDay(void);
   void              OnClickGraphPeriodMonth(void);
   void              OnClickGraphPeriodYear(void);
   
   bool              LoadPositionMAStopSets();
   bool              SavePositionMAStopSets();
   bool              LoadPositionTrailingStopSets();
   bool              SavePositionTrailingStopSets();
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CAppWindowSelTradingTool)
// メニュータブ切替
ON_EVENT(ON_CLICK,m_menu_button_market,OnClickMenuMarket)
ON_EVENT(ON_CLICK,m_menu_button_limit,OnClickMenuLimit)
ON_EVENT(ON_CLICK,m_menu_button_stoplimit,OnClickMenuStopLimit)
ON_EVENT(ON_CLICK,m_menu_button_info,OnClickMenuInfo)
ON_EVENT(ON_CLICK,m_menu_symbol,OnClickMenuSymbol)
// 売り買いボタン
ON_EVENT(ON_CLICK,m_trade_button_ask,OnClickAsk)
ON_EVENT(ON_CLICK,m_trade_label_ask,OnClickAsk)
ON_EVENT(ON_CLICK,m_tick_label_ask,OnClickAsk)
ON_EVENT(ON_CLICK,m_trade_button_bid,OnClickBid)
ON_EVENT(ON_CLICK,m_trade_label_bid,OnClickBid)
ON_EVENT(ON_CLICK,m_tick_label_bid,OnClickBid)
// 設定切替ボタン
ON_EVENT(ON_CLICK,m_common_button_auto,OnClickAuto)
ON_EVENT(ON_CLICK,m_common_button_manual,OnClickManual)
ON_EVENT(ON_CLICK,m_common_button_tp,OnClickTpAuto)
ON_EVENT(ON_CLICK,m_common_button_sl,OnClickSlAuto)
ON_EVENT(ON_CLICK,m_common_button_horizon,OnClickHorizon)
ON_EVENT(ON_CLICK,m_common_button_alerm,OnClickAlerm)
ON_EVENT(ON_CLICK,m_common_button_bg,OnClickBg)
ON_EVENT(ON_CLICK,m_common_button_reset,OnClickReset)
ON_EVENT(ON_CLICK,m_common_button_graph,OnClickGraph)
// Infoボタン
ON_EVENT(ON_CLICK,m_info_button_exit_sell,OnClickInfoSellExit)
ON_EVENT(ON_CLICK,m_info_button_tatene_sell,OnClickInfoSellSlTatene)
ON_EVENT(ON_CLICK,m_info_button_deltp_sell,OnClickInfoSellTpDelete)
ON_EVENT(ON_CLICK,m_info_button_exit_buy,OnClickInfoBuyExit)
ON_EVENT(ON_CLICK,m_info_button_tatene_buy,OnClickInfoBuySlTatene)
ON_EVENT(ON_CLICK,m_info_button_deltp_buy,OnClickInfoBuyTpDelete)
ON_EVENT(ON_CLICK,m_info_button_exit_all,OnClickInfoAllExit)
ON_EVENT(ON_CLICK,m_info_button_tatene_all,OnClickInfoAllSlTatene)
ON_EVENT(ON_CLICK,m_info_button_deltp_all,OnClickInfoAllTpDelete)
ON_EVENT(ON_CLICK,m_info_button_cancel_all,OnClickInfoAllCancel)
ON_EVENT(ON_CLICK,m_info_button_camera,OnClickCamera)
// ポジション一覧
ON_EVENT(ON_CLICK,m_position_button_percent_up_10,OnClickPercentUp10)
ON_EVENT(ON_CLICK,m_position_button_percent_up,OnClickPercentUp)
ON_EVENT(ON_CLICK,m_position_button_percent_down,OnClickPercentDown)
ON_EVENT(ON_CLICK,m_position_button_percent_down_10,OnClickPercentDown10)
ON_EVENT(ON_END_EDIT,m_position_edit_percent,OnEndEditPercent)
// ロット編集
ON_EVENT(ON_END_EDIT,m_common_lot,OnEndEditLot)
ON_EVENT(ON_END_EDIT,m_common_risk,OnEndEditRisk)
ON_EVENT(ON_CLICK,m_common_risk_up,OnClickRiskUp)
ON_EVENT(ON_CLICK,m_common_risk_down,OnClickRiskDown)
// ポジションメニュー
ON_EVENT(ON_CLICK,m_position_menu_main_close,OnPositionMenuClose)
ON_EVENT(ON_CLICK,m_position_menu_main_exit,OnPositionMenuExit)
ON_EVENT(ON_CLICK,m_position_menu_main_exit_panel,OnPositionMenuExit)
ON_EVENT(ON_CLICK,m_position_menu_main_doten,OnPositionMenuDoten)
ON_EVENT(ON_CLICK,m_position_menu_main_doten_panel,OnPositionMenuDoten)
ON_EVENT(ON_CLICK,m_position_menu_main_percent_exit,OnPositionMenuPercentExitMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_percent_exit_panel,OnPositionMenuPercentExitMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_sltatene,OnPositionMenuSlTatene)
ON_EVENT(ON_CLICK,m_position_menu_main_sltatene_panel,OnPositionMenuSlTatene)
ON_EVENT(ON_CLICK,m_position_menu_main_trailingstop,OnPositionMenuTrailingStopMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_trailingstop_panel,OnPositionMenuTrailingStopMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_tpsl,OnPositionMenuTpSlMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_tpsl_panel,OnPositionMenuTpSlMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_ma_tpsl,OnPositionMenuMATpSlMenu)
ON_EVENT(ON_CLICK,m_position_menu_main_ma_tpsl_panel,OnPositionMenuMATpSlMenu)
ON_EVENT(ON_CLICK,m_position_menu_sub_percent_exit,OnPositionMenuPercentExitExec)
ON_EVENT(ON_CLICK,m_position_menu_sub_tpsl_set,OnPositionMenuTpSlSet)
ON_EVENT(ON_CLICK,m_position_menu_sub_trailingstop_set,OnPositionMenuTrailingStopSet)
ON_EVENT(ON_CLICK,m_position_menu_sub_ma_tpsl_set,OnPositionMenuMATpSlSet)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_close,OnPositionMenuCloseFocus)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_exit,OnPositionMenuExitFocus)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_doten,OnPositionMenuDotenFocus)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_percent_exit,OnPositionMenuPercentMenuFocus)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_sltatene,OnPositionMenuSlTateneFocus)
// ON_EVENT(ON_MOUSE_FOCUS_SET,m_position_menu_main_tpsl,OnPositionMenuTpSlMenuFocus)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_close,OnPositionMenuCloseFocusOut)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_exit,OnPositionMenuExitFocusOut)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_doten,OnPositionMenuDotenFocusOut)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_percent_exit,OnPositionMenuPercentMenuFocusOut)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_sltatene,OnPositionMenuSlTateneFocusOut)
// ON_EVENT(ON_MOUSE_FOCUS_KILL,m_position_menu_main_tpsl,OnPositionMenuTpSlMenuFocusOut)

ON_EVENT(ON_CLICK,m_graph_symbol,OnClickGraphSymbol)
ON_EVENT(ON_CLICK,m_graph_pday_button,OnClickGraphPeriodDay)
ON_EVENT(ON_CLICK,m_graph_pmonth_button,OnClickGraphPeriodMonth)
ON_EVENT(ON_CLICK,m_graph_pyear_button,OnClickGraphPeriodYear)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CAppWindowSelTradingTool::CAppWindowSelTradingTool(void)
  {
   _mkt_symbols_total=SymbolsTotal(true);
   ArrayResize(_mkt_symbols, _mkt_symbols_total);   
   for (int i = 0; i < _mkt_symbols_total; i++) {
      _mkt_symbols[i] = SymbolName(i, true);
   }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CAppWindowSelTradingTool::~CAppWindowSelTradingTool(void)
  {
   
  }

void CAppWindowSelTradingTool::Destroy(const int reason=0)
  {
   //---
   if(reason==REASON_CLOSE)
     {
      SavePositionMAStopSets();
      SavePositionTrailingStopSets();
     }
   
   //---
   m_graph_profitGraph.Destroy();
   
   //---
   CAppDialog::Destroy(reason);
  }  
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   // window作成
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
   // ObjectSetInteger(0,name,OBJPROP_ZORDER,10);

   // obj取得
   int total=ExtDialog.ControlsTotal();
   // PrintFormat("%d total",total);
   for(int i=0;i<total;i++)
   {
      CWnd*obj=ExtDialog.Control(i);
      string name=obj.Name();
      // PrintFormat("%d is %s",i,name);
      if(StringFind(name,"Client")>0)
      {
         CWndClient *obj2=(CWndClient*)obj;
         my_client = obj2;
      }
      else if(StringFind(name,"Back")>0)
      {
         CPanel *obj2=(CPanel*)obj;
         my_back = obj2;
      }
      else if(StringFind(name,"Border")>0)
      {
         CPanel *obj2=(CPanel*)obj;
         my_border = obj2;
      }
      else if(StringFind(name,"Caption")>0)
      {
         CEdit *obj2=(CEdit*)obj;
         my_caption = obj2;
      }
      else if(StringFind(name,"MinMax")>0)
      {
         CBmpButton *obj2=(CBmpButton*)obj;
         my_minmaxbtn = obj2;
      }
      else if(StringFind(name,"Close")>0)
      {
         CBmpButton *obj2=(CBmpButton*)obj;
         my_closebtn = obj2;
      }
   }

   if(!InitObject())
      return(false);
      
   if(!CreatePositionStopInfoObj())
      return(false); 
         
   if(ArraySize(position_tickets)>0){
      ArrayRemove(position_tickets, 0, ArraySize(position_tickets));
      ObjectsDeleteAll(
         0,  // チャート識別子
         POSITION_NAME_PREFIX,  // オブジェクト名のプレフィックス
         -1,  // ウィンドウ番号
         -1   // オブジェクトの型
      );
   }
   if(!HideAll(POSITION_MENU_NAME_PREFIX))
      return(false);
   if(ArraySize(position_tps)>0){
      ArrayRemove(position_tps, 0, ArraySize(position_tps));
      ObjectsDeleteAll(
         0,  // チャート識別子
         POSITION_TP_NAME_PREFIX,  // オブジェクト名のプレフィックス
         -1,  // ウィンドウ番号
         -1   // オブジェクトの型
      );
   }
   if(ArraySize(position_sls)>0){
      ArrayRemove(position_sls, 0, ArraySize(position_sls));
      ObjectsDeleteAll(
         0,  // チャート識別子
         POSITION_SL_NAME_PREFIX,  // オブジェクト名のプレフィックス
         -1,  // ウィンドウ番号
         -1   // オブジェクトの型
      );
   }
   if(ArraySize(order_tickets)>0){
      ArrayRemove(order_tickets, 0, ArraySize(order_tickets));
      ObjectsDeleteAll(
         0,  // チャート識別子
         POSITION_ORDER_NAME_PREFIX,  // オブジェクト名のプレフィックス
         -1,  // ウィンドウ番号
         -1   // オブジェクトの型
      );
   }

   // 最小化されていたら最小化して終了する
   if(dialogMminimized || ExtDialog.Height() < 100){
      my_client.Hide();
      my_minmaxbtn.Pressed(true);
      dialogMminimized = true;
      return(true);
   }

   // 時間足変更で初期化されてしまう問題の対策
   switch(trade_mode){
      case 1:
         if(!CreateMarket())
            return(false);
         break;
      case 2:
         if(!CreateLimit())
            return(false);
         break;
      case 3:
         if(!CreateStopLimit())
            return(false);
         break;
      default:
         if(!CreateMarket())
            return(false);
         break;
         
   }

   if(position_panel_set_flg==1){
      if(!CreateSub())
         return(false);
      if(graph_panel_set_flg==1){
         CreateGraph();
      } else {
         HideAll(GRAPH_NAME_PREFIX);
         m_graph_profitGraph.Destroy();      
      }   
   }else{
      if(!HideAll(SUB_NAME_PREFIX))
         return(false);
      HideAll(GRAPH_NAME_PREFIX);
      m_graph_profitGraph.Destroy();      
   }
//---
   if(_eaFirstTimeAttached)
     {
      _eaFirstTimeAttached=false;
      
      //---
      LoadPositionMAStopSets();
      LoadPositionTrailingStopSets();
     }   
//--- succeed
   return(true);
  }
  
bool CAppWindowSelTradingTool::InitObject()
{
   /**
    * MainWindow
    */
   my_caption.Font(main_Font);
   my_caption.FontSize(my_caption_FontSize);
   my_caption.Color(my_caption_Color);
   my_caption.ColorBackground(my_caption_ColorBackground);
   my_caption.ColorBorder(my_caption_ColorBorder);//
   //my_caption.ZOrder(9999);
   double zoom_diff = MathAbs(my_caption.Height() - my_caption.Height()*getZoomRate(zoom_rate_select));
   //my_caption.Height(my_caption.Height()+zoom_diff/2);
   //my_caption.Move(my_caption.Left(), my_caption.Top()+zoom_diff/2);
   CAPTION_H = my_caption.Height();
   CAPTION_W = my_caption.Width();
   CAPTION_TOP = my_caption.Top()-Top();
   CAPTION_LEFT = my_caption.Left()-Left();
   
   my_border.ColorBorder(my_border_ColorBorder);
   my_border.ZOrder(9999);

   my_client.ColorBackground(my_client_ColorBackground);
   my_client.ColorBorder(my_client_ColorBorder);
   my_client.Height(my_client.Height()-zoom_diff);
   my_client.Move(my_client.Left(), my_client.Top()+zoom_diff);
   //my_client.ZOrder(9999);
   
   int cols = _mkt_symbols_total / SYMBOL_MENU_COL_ITEM_COUNT;
   int cols1 = (_mkt_symbols_total + 1) / SYMBOL_MENU_COL_ITEM_COUNT;
   if (MathMod(_mkt_symbols_total, SYMBOL_MENU_COL_ITEM_COUNT) > 0)
      cols++;
   if (MathMod((_mkt_symbols_total + 1), SYMBOL_MENU_COL_ITEM_COUNT) > 0)
      cols1++;   
   /**
    * CPanel
    */ 
   if(!CreateCPanel(m_sub_main_panel, "m_sub_main_panel", my_client_ColorBackground, common_line_ColorBorder, my_border.Width(), 0))
      return false;
   if(!CreateCPanel(m_common_line1, "m_common_line1", my_client_ColorBackground, common_line_ColorBorder, COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+COMMON_LABEL_COL3_WIDTH+BODY_INDENT_LEFT*7/8, 0))
      return false;   
   if(!CreateCPanel(m_common_line2, "m_common_line2", my_client_ColorBackground, common_line_ColorBorder, COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+COMMON_LABEL_COL3_WIDTH+BODY_INDENT_LEFT*7/8, 0))
      return false;
   if(!CreateCPanel(m_info_line1, "sub_info_line1", my_client_ColorBackground, common_line_ColorBorder, COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+COMMON_LABEL_COL3_WIDTH+BODY_INDENT_LEFT, 0))
      return false;
   if(!CreateCPanel(m_info_line2, "sub_info_line2", my_client_ColorBackground, common_line_ColorBorder, COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+COMMON_LABEL_COL3_WIDTH+BODY_INDENT_LEFT, 0))
      return false;
   if(!CreateCPanel(m_position_panel, "sub_position_panel", my_client_ColorBackground, my_client_ColorBorder, ExtDialog.Width(), ExtDialog.Height(), 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_panel, POSITION_MENU_NAME_PREFIX+"main_menu_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT*7, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_sub_panel, POSITION_MENU_NAME_PREFIX+"sub_menu_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_SUB_WIDTH, POSITION_MENU_SUB_HEIGHT_01, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_exit_panel, POSITION_MENU_NAME_PREFIX+"main_menu_exit_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH-POSITION_MENU_CLOSE_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_doten_panel, POSITION_MENU_NAME_PREFIX+"main_menu_doten_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_percent_exit_panel, POSITION_MENU_NAME_PREFIX+"main_menu_percent_exit_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_sltatene_panel, POSITION_MENU_NAME_PREFIX+"main_menu_sltatene_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;
   if(!CreateCPanel(m_position_menu_main_trailingstop_panel, POSITION_MENU_NAME_PREFIX+"main_menu_trailingstop_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;   
   if(!CreateCPanel(m_position_menu_main_tpsl_panel, POSITION_MENU_NAME_PREFIX+"main_menu_tpsl_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;    
   if(!CreateCPanel(m_position_menu_main_ma_tpsl_panel, POSITION_MENU_NAME_PREFIX+"main_menu_ma_tpsl_panel", position_menu_ColorBackground, position_menu_ColorBorder, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT, 9999))
      return false;   
   if(!CreateCPanel(m_menu_popup_panel, SYMBOL_MENU_NAME_PREFIX+"panel", common_edit_ColorBackground, C'178,195,207', MENU_PANEL_EDIT_WIDTH * cols + 2, MENU_EDIT_HEIGHT * SYMBOL_MENU_COL_ITEM_COUNT + 2, 9999))
      return false;
   if(!CreateCPanel(m_graph_popup_panel, GRAPH_SYMBOL_MENU_NAME_PREFIX+"panel", common_edit_ColorBackground, C'178,195,207', MENU_EDIT_WIDTH * cols1 + 2, MENU_EDIT_HEIGHT * SYMBOL_MENU_COL_ITEM_COUNT + 2, 9999))
      return false;   
   if(!CreateCPanel(m_graph_main_panel, GRAPH_NAME_PREFIX+"main_panel", graph_panel_ColorBackground, graph_panel_ColorBorder, GRAPH_PANEL_MAIN_WIDTH, GRAPH_PANEL_MAIN_HEIGHT, 9999))
      return false;        
   /**
    * CEdit
    */
   if(!CreateCEdit(m_common_lot, "m_common_lot", DoubleToString(Lot, 2), main_Font, common_FontSize, common_Color, common_edit_ColorBackground, COMMON_LABEL_COL3_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_common_risk, "m_common_risk", DoubleToString(MaxLossMarginPercent,1), main_Font, common_FontSize, common_Color, common_edit_ColorBackground, COMMON_LABEL_COL4_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_edit_percent, "sub_position_edit_percent", ExitPercent, main_Font, common_FontSize, common_Color, common_edit_ColorBackground, POSITION_EDIT1_WIDTH, POSITION_EDIT1_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_menu_sub_percent_input, POSITION_MENU_NAME_PREFIX+"sub_menu_percent_input", "", main_Font, common_FontSize, common_Color, common_edit_ColorBackground, POSITION_MENU_SUB_EDIT_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_menu_sub_trailingstop_targetpips, POSITION_MENU_NAME_PREFIX+"sub_menu_trailingstop_targetpips", "", main_Font, common_FontSize, menu_Color, clrWhite, POSITION_MENU_SUB_EDIT_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;   
   if(!CreateCEdit(m_position_menu_sub_tpsl_tp_input, POSITION_MENU_NAME_PREFIX+"sub_menu_tpsl_tp_input", "", main_Font, common_FontSize, common_Color, common_edit_ColorBackground, POSITION_MENU_SUB_EDIT_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_menu_sub_tpsl_sl_input, POSITION_MENU_NAME_PREFIX+"sub_menu_tpsl_sl_input", "", main_Font, common_FontSize, common_Color, common_edit_ColorBackground, POSITION_MENU_SUB_EDIT_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_menu_sub_ma_tp_period, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tp_period", "", main_Font, common_FontSize, menu_Color, clrWhite, POSITION_EDIT1_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;
   if(!CreateCEdit(m_position_menu_sub_ma_sl_period, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_sl_period", "", main_Font, common_FontSize, menu_Color, clrWhite, POSITION_EDIT1_WIDTH, POSITION_MENU_SUB_EDIT_HEIGHT, ALIGN_RIGHT))
      return false;
      
   ArrayResize(m_graph_popup_items, _mkt_symbols_total + 1, 100);
   for (int i = 0; i < cols1; i++) {
      for (int j = 0; j < SYMBOL_MENU_COL_ITEM_COUNT; j++) {
         int k = i * SYMBOL_MENU_COL_ITEM_COUNT + j;         
         if (k >= _mkt_symbols_total) break;                     
         if(!CreateCEdit(m_graph_popup_items[k], GRAPH_SYMBOL_MENU_NAME_PREFIX+"item_"+k, (i==0 && j==0) ? "全銘柄" : _mkt_symbols[k-1], main_Font, common_FontSize, common_Color, common_edit_ColorBackground, MENU_EDIT_WIDTH, MENU_EDIT_HEIGHT, ALIGN_LEFT, true))
            return false;
      }
   }     
   if(!CreateCEdit(m_graph_symbol, GRAPH_NAME_PREFIX+"symbol", graphSymbol, main_Font, common_FontSize, common_Color, symbol_menu_ColorBackground, MENU_EDIT_WIDTH, MENU_EDIT_HEIGHT, ALIGN_LEFT, true))
      return false;

   ArrayResize(m_menu_popup_items, _mkt_symbols_total, 100);
   for (int i = 0; i < cols; i++) {
      for (int j = 0; j < SYMBOL_MENU_COL_ITEM_COUNT; j++) {
         int k = i * SYMBOL_MENU_COL_ITEM_COUNT + j;         
         if (k >= _mkt_symbols_total) break;            
         if(!CreateCEdit(m_menu_popup_items[k], SYMBOL_MENU_NAME_PREFIX+"item_"+k, _mkt_symbols[k], main_Font, common_FontSize, common_Color, common_edit_ColorBackground, MENU_PANEL_EDIT_WIDTH, MENU_EDIT_HEIGHT, ALIGN_LEFT, true))
            return false;
      }
   }  
   
   if(!CreateCEdit(m_menu_symbol, "m_menu_symbol", _Symbol, main_Font, common_FontSize, common_Color, symbol_menu_ColorBackground, MENU_EDIT_WIDTH, MENU_EDIT_HEIGHT, ALIGN_LEFT, true))
      return false;   
   if(!CreateCEdit(m_menu_status, "m_menu_status", "", main_Font, common_FontSize, common_Color, symbol_menu_ColorBackground, MENU_EDIT_WIDE_WIDTH, MENU_EDIT_HEIGHT, ALIGN_RIGHT, true))
      return false;
   
   /**
    * CButton
    */
   if(!CreateCButton(m_menu_button_market, "m_menu_button_market", "成行", main_Font, menu_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_menu_button_limit, "m_menu_button_limit", "指値", main_Font, menu_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_menu_button_stoplimit, "m_menu_button_stoplimit", "逆指", main_Font, menu_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_menu_button_info, "m_menu_button_info", info_nonactive_text, main_Font, menu_FontSize, menu_info_nonactive_Color, menu_info_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_INFO_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_trade_button_ask, "m_trade_button_ask", "", main_Font, trade_main_FontSize, trade_ask_Color, trade_ask_ColorBackground, C'178,195,207', TRADE_BUTTON_WIDTH, TRADE_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_trade_button_bid, "m_trade_button_bid", "", main_Font, trade_main_FontSize, trade_bid_Color, trade_bid_ColorBackground, C'178,195,207', TRADE_BUTTON_WIDTH, TRADE_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_auto, "m_common_button_auto", "自動", main_Font, common_FontSize, lot_nonactive_Color, lot_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_COL2_WIDTH/2, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_manual, "m_common_button_manual", "手動", main_Font, common_FontSize, lot_nonactive_Color, lot_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_COL2_WIDTH/2, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_risk_up, "m_common_risk_up", "+", main_Font, common_FontSize, updown_nonactive_Color, updown_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_COL5_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_risk_down, "m_common_risk_down", "-", main_Font, common_FontSize, updown_nonactive_Color, updown_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_COL6_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_horizon, "m_common_button_horizon", "水平線", main_Font, common_FontSize, sl_nonactive_Color, sl_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_alerm, "m_common_button_alerm", "アラーム", main_Font, common_FontSize, sl_nonactive_Color, sl_nonactive_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_reset, "sub_common_button_reset", "リセット", main_Font, common_FontSize, bg_active_Color, bg_active_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_common_button_graph, "sub_common_button_graph", "損益グラフ", main_Font, common_FontSize, bg_active_Color, bg_active_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_WIDTH*1.5, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;   
   if(!CreateCButton(m_info_button_exit_sell, "sub_info_button_exit_sell", "売り一括", main_Font, common_FontSize, info_sell_exit_Color, info_sell_exit_ColorBackground, C'178,195,207', INFO_BUTTON1_WIDTH, INFO_BUTTON1_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_info_button_exit_buy, "sub_info_button_exit_buy", "買い一括", main_Font, common_FontSize, info_buy_exit_Color, info_buy_exit_ColorBackground, C'178,195,207', INFO_BUTTON1_WIDTH, INFO_BUTTON1_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_info_button_exit_all, "sub_info_button_exit_all", "一括決済", main_Font, common_FontSize, info_all_exit_Color, info_all_exit_ColorBackground, C'178,195,207', INFO_BUTTON1_WIDTH, INFO_BUTTON1_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_info_button_cancel_all, "sub_info_button_cancel_all", "待機注文一括削除", main_Font, common_FontSize, info_pending_cancel_Color, info_pending_cancel_ColorBackground, C'178,195,207', INFO_BUTTON2_WIDTH, INFO_BUTTON2_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_button_percent_down_10, "sub_position_button_percent_down_10", "-10", main_Font, common_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', POSITION_BUTTON1_WIDTH, POSITION_BUTTON1_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_button_percent_down, "sub_position_button_percent_down", "-", main_Font, common_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', POSITION_BUTTON2_WIDTH, POSITION_BUTTON2_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_button_percent_up, "sub_position_button_percent_up", "+", main_Font, common_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', POSITION_BUTTON3_WIDTH, POSITION_BUTTON3_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_button_percent_up_10, "sub_position_button_percent_up_10", "+10", main_Font, common_FontSize, menu_Color, menu_ColorBackground, C'178,195,207', POSITION_BUTTON4_WIDTH, POSITION_BUTTON4_HEIGHT, ALIGN_CENTER))
      return false;

   if(!CreateCButton(m_position_menu_main_close, POSITION_MENU_NAME_PREFIX+"main_menu_close", "×", main_Font, common_FontSize, menu_Color, position_menu_close_ColorBackground, position_menu_close_ColorBorder, POSITION_MENU_CLOSE_WIDTH, POSITION_MENU_CLOSE_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_menu_sub_percent_exit, POSITION_MENU_NAME_PREFIX+"sub_menu_percent_exit", "決済", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_menu_sub_trailingstop_set, POSITION_MENU_NAME_PREFIX+"sub_menu_trailingstop_set", "設定", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;   
   if(!CreateCButton(m_position_menu_sub_tpsl_set, POSITION_MENU_NAME_PREFIX+"sub_menu_tpsl_set", "設定", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_position_menu_sub_ma_tpsl_set, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tpsl_set", "設定", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;    
   
   if(!CreateCButton(m_graph_pday_button, GRAPH_NAME_PREFIX+"period_day", "日次", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   if(!CreateCButton(m_graph_pmonth_button, GRAPH_NAME_PREFIX+"period_month", "月次", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;   
   if(!CreateCButton(m_graph_pyear_button, GRAPH_NAME_PREFIX+"period_year", "年次", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, C'178,195,207', POSITION_MENU_SUB_BUTTON_WIDTH, POSITION_MENU_SUB_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   /**
    * CLabel
    */
   if(!CreateCLabel(m_menu_label_now_menu, "m_menu_label_now_menu", "成行", main_Font, menu_FontSize, menu_Color, menu_ColorBackground, MENU_LABEL_WIDTH, MENU_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_trade_label_ask, "m_trade_label_ask", "買い", main_Font, trade_main_FontSize, trade_ask_Color, trade_ask_ColorBackground, TRADE_LABEL_WIDTH, TRADE_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_tick_label_ask, "m_tick_label_ask", "-", main_Font, trade_price_FontSize, trade_ask_Color, trade_ask_ColorBackground, TRADE_LABEL_WIDTH, TRADE_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_trade_label_bid, "m_trade_label_bid", "売り", main_Font, trade_main_FontSize, trade_bid_Color, trade_bid_ColorBackground, TRADE_LABEL_WIDTH, TRADE_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_tick_label_bid, "m_tick_label_bid", "-", main_Font, trade_price_FontSize, trade_bid_Color, trade_bid_ColorBackground, TRADE_LABEL_WIDTH, TRADE_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_common_label_lot_str, "m_common_label_lot_str", "ロット", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_common_label_risk_str, "m_common_label_risk_str", "許容損失率(%)", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_common_label_pl_str, "m_common_label_pl_str", "利確", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_common_label_pl_price, "m_common_label_pl_price", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   // if(!CreateCLabel(m_common_label_pl_pips, "m_common_label_pl_pips", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_1_1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
   //    return false;
   if(!CreateCLabel(m_common_label_pl_pips_str, "m_common_label_pl_pips_str", "pips", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_1_1_WIDTH+COMMON_LABEL_COL3_1_2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_common_label_sl_str, "m_common_label_sl_str", "損切", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_common_label_sl_price, "m_common_label_sl_price", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   // if(!CreateCLabel(m_common_label_sl_pips, "m_common_label_sl_pips", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_1_1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
   //    return false;
   if(!CreateCLabel(m_common_label_sl_pips_str, "m_common_label_sl_pips_str", "pips", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_1_1_WIDTH+COMMON_LABEL_COL3_1_2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_common_label_plslrate_str, "m_common_label_plslrate_str", "損益比", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_common_label_plslrate, "m_common_label_plslrate", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_common_label_winrate_str, "m_common_label_winrate_str", "必要勝率", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   // if(!CreateCLabel(m_common_label_winrate, "m_common_label_winrate", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_2_1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
   //    return false;
   if(!CreateCLabel(m_common_label_winrate_percent_str, "m_common_label_winrate_percent_str", "%", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_2_1_WIDTH+COMMON_LABEL_COL3_2_2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_common_label_plplan_str, "m_common_label_plplan_str", "利益見込", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   // if(!CreateCLabel(m_common_label_plplan, "m_common_label_plplan", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_3_1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
   //    return false;
   if(!CreateCLabel(m_common_label_plplan_currency, "m_common_label_plplan_currency", currency, main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_3_1_WIDTH+COMMON_LABEL_COL3_3_2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_common_label_slplan_str, "m_common_label_slplan_str", "損失見込", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   // if(!CreateCLabel(m_common_label_slplan, "m_common_label_slplan", "-", main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_3_1_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
   //    return false;
   if(!CreateCLabel(m_common_label_slplan_currency, "m_common_label_slplan_currency", currency, main_Font, common_FontSize, common_Color, "", COMMON_LABEL_COL3_3_1_WIDTH+COMMON_LABEL_COL3_3_2_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_position_sell, "sub_info_label_position_sell", "Sell(-)", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_position_buy, "sub_info_label_position_buy", "Buy(-)", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_position_all, "sub_info_label_position_all", "All(-)", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_position_sell_price, "sub_info_label_position_sell_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_position_buy_price, "sub_info_label_position_buy_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_position_all_price, "sub_info_label_position_all_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_account_info01, "sub_info_label_account_info01", "口座残高", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_account_info01_price, "sub_info_label_account_info01_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_account_info02, "sub_info_label_account_info02", "有効証拠金", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_account_info02_price, "sub_info_label_account_info02_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_account_info03, "sub_info_label_account_info03", "必要証拠金", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_account_info03_price, "sub_info_label_account_info03_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_info_label_account_info04, "sub_info_label_account_info04", "証拠金率(%)", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL1_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;
   if(!CreateCLabel(m_info_label_account_info04_price, "sub_info_label_account_info04_price", "-", main_Font, common_FontSize, common_Color, "", INFO_LABEL_COL2_WIDTH, INFO_LABEL_HEIGHT, ANCHOR_RIGHT))
      return false;
   if(!CreateCLabel(m_position_label_percent, "sub_position_label_percent", "一括決済(％)", main_Font, common_FontSize, common_Color, "", POSITION_LABEL_COL1_WIDTH, POSITION_LABEL_HEIGHT, ANCHOR_LEFT))
      return false;

   if(!CreateCLabel(m_position_menu_main_exit, POSITION_MENU_NAME_PREFIX+"main_menu_exit", "", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH-POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_main_doten, POSITION_MENU_NAME_PREFIX+"main_menu_doten", "　ドテン", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_main_percent_exit, POSITION_MENU_NAME_PREFIX+"main_menu_percent_exit", "　分割決済 　　　　　＞", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_main_sltatene, POSITION_MENU_NAME_PREFIX+"main_menu_sltatene", "　SL建値", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_main_trailingstop, POSITION_MENU_NAME_PREFIX+"main_menu_trailingstop", "　自動SL建値　　　   ＞", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;    
   if(!CreateCLabel(m_position_menu_main_tpsl, POSITION_MENU_NAME_PREFIX+"main_menu_tpsl", "　TP/SL編集　　　　＞", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_main_ma_tpsl, POSITION_MENU_NAME_PREFIX+"main_menu_ma_tpsl", "　TP/SL (MA) 　　　＞", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_MAIN_WIDTH, POSITION_MENU_MAIN_HEIGHT/2, ANCHOR_LEFT_UPPER))
      return false;   
   if(!CreateCLabel(m_position_menu_sub_percent_label, POSITION_MENU_NAME_PREFIX+"sub_menu_percent_label", "分割決済　％", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_SUB_WIDTH, POSITION_MENU_MAIN_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;   
   if(!CreateCLabel(m_position_menu_sub_tp_label, POSITION_MENU_NAME_PREFIX+"sub_menu_tp_label", "TP", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_SUB_LABEL_WIDTH, POSITION_MENU_MAIN_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_position_menu_sub_sl_label, POSITION_MENU_NAME_PREFIX+"sub_menu_sl_label", "SL", main_Font, common_FontSize, menu_Color, position_menu_ColorBackground, POSITION_MENU_SUB_LABEL_WIDTH, POSITION_MENU_MAIN_HEIGHT, ANCHOR_LEFT_UPPER))
      return false; 
   
   if(!CreateCLabel(m_graph_totalProfit_label, GRAPH_NAME_PREFIX+"totalProfit_label", GRAPH_LABEL_TRADES_PREFIX, main_Font, graph_ProfitFontSize, menu_Color, graph_panel_ColorBackground, MENU_EDIT_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_CENTER))
      return false;
   if(!CreateCLabel(m_graph_totalTrades_label, GRAPH_NAME_PREFIX+"totalTrades_label", GRAPH_LABEL_TRADES_PREFIX, main_Font, common_FontSize, menu_Color, graph_panel_ColorBackground, GRAPH_PANEL_LABEL_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_graph_longTrades_label, GRAPH_NAME_PREFIX+"longTrades_label", GRAPH_LABEL_LONG_TRADES_PREFIX, main_Font, common_FontSize, menu_Color, graph_panel_ColorBackground, GRAPH_PANEL_LABEL_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_graph_shortTrades_label, GRAPH_NAME_PREFIX+"shortTrades_label", GRAPH_LABEL_SHORT_TRADES_PREFIX, main_Font, common_FontSize, menu_Color, graph_panel_ColorBackground, GRAPH_PANEL_LABEL_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;
   if(!CreateCLabel(m_graph_profitFactor_label, GRAPH_NAME_PREFIX+"profitFactor_label", GRAPH_LABEL_PROFITFACTOR_PREFIX, main_Font, common_FontSize, menu_Color, graph_panel_ColorBackground, GRAPH_PANEL_LABEL_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;         
   if(!CreateCLabel(m_graph_maxDrawdown_label, GRAPH_NAME_PREFIX+"maxDrawdown_label", GRAPH_LABEL_MDD_PREFIX, main_Font, common_FontSize, menu_Color, graph_panel_ColorBackground, GRAPH_PANEL_LABEL_WIDTH, COMMON_LABEL_HEIGHT, ANCHOR_LEFT_UPPER))
      return false;
   
   /**
    * CComboBox
    */   
   if(!CreateCCombobox(m_position_menu_sub_ma_tp_method, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tpsl_tp_method", 60, POSITION_MENU_SUB_LABEL_HEIGHT))
      return false;
   m_position_menu_sub_ma_tp_method.ItemAdd("SMA",MODE_SMA);
   m_position_menu_sub_ma_tp_method.ItemAdd("EMA",MODE_EMA);
   m_position_menu_sub_ma_tp_method.ItemAdd("SMMA",MODE_SMMA);
   m_position_menu_sub_ma_tp_method.ItemAdd("LWMA",MODE_LWMA);
   m_position_menu_sub_ma_tp_method.SelectByValue(MODE_SMA);
   if(!CreateCCombobox(m_position_menu_sub_ma_sl_method, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tpsl_sl_method", 60, POSITION_MENU_SUB_LABEL_HEIGHT))
      return false;
   m_position_menu_sub_ma_sl_method.ItemAdd("SMA",MODE_SMA);
   m_position_menu_sub_ma_sl_method.ItemAdd("EMA",MODE_EMA);
   m_position_menu_sub_ma_sl_method.ItemAdd("SMMA",MODE_SMMA);
   m_position_menu_sub_ma_sl_method.ItemAdd("LWMA",MODE_LWMA);
   m_position_menu_sub_ma_sl_method.SelectByValue(MODE_SMA); 
   
   /**
    * CCheckBox
    */
   if(!CreateCCheckBox(m_position_menu_sub_trailingstop_chk, POSITION_MENU_NAME_PREFIX+"sub_menu_trailingstop_chk", "自動SL建値(Pips)", main_Font, common_FontSize, menu_Color,POSITION_MENU_SUB_WIDTH-10, POSITION_MENU_SUB_LABEL_HEIGHT))
      return false; 
   if(!CreateCCheckBox(m_position_menu_sub_ma_tp_chk, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tpsl_tp_chk", "TP", main_Font, common_FontSize, menu_Color, POSITION_MENU_SUB_LABEL_WIDTH, POSITION_MENU_SUB_LABEL_HEIGHT))
      return false;
   if(!CreateCCheckBox(m_position_menu_sub_ma_sl_chk, POSITION_MENU_NAME_PREFIX+"sub_menu_ma_tpsl_sl_chk", "SL", main_Font, common_FontSize, menu_Color, POSITION_MENU_SUB_LABEL_WIDTH, POSITION_MENU_SUB_LABEL_HEIGHT))
      return false;              
      
   /**
    * CButton
    */
   if(!CreateCButton(m_info_button_camera, "m_info_button_camera", "カメラ", main_Font, common_FontSize, camera_Color, camera_ColorBackground, C'178,195,207', COMMON_LABEL_FOOTER_WIDTH, COMMON_BUTTON_HEIGHT, ALIGN_CENTER))
      return false;
   
   CalcInfo();


   return true;

}

bool CAppWindowSelTradingTool::CreatePositionStopInfoObj(void)
  {
   if(ObjectFind(0,LABEL_MA_TPSL_INFO_NAME)<0)
     {
      if(!ObjectCreate(0,LABEL_MA_TPSL_INFO_NAME,OBJ_LABEL,0,0,0))
         return(false);
     }
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_ANCHOR,ANCHOR_RIGHT_UPPER);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_XDISTANCE,8);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_YDISTANCE,-100);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_ALIGN,ALIGN_RIGHT);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_FONTSIZE,InpMATPSLInfo_FontSize);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_COLOR,InpMATPSLInfo_FontColor);
   ObjectSetString(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TEXT," ");
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
     
   if(ObjectFind(0,LABEL_TRAILINGSTOP_INFO_NAME)<0)
     {
      if(!ObjectCreate(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJ_LABEL,0,0,0))
         return(false);
     }  
   
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_ANCHOR,ANCHOR_RIGHT_UPPER);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_XDISTANCE,8);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_YDISTANCE,-100);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_ALIGN,ALIGN_RIGHT);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_FONTSIZE,InpTrailingStopInfo_FontSize);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_COLOR,InpTrailingStopInfo_FontColor);
   ObjectSetString(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TEXT," ");
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
     
   return(true);
  }  
  
bool CAppWindowSelTradingTool::CreateCButton(CButton &obj, string name, string text, string font, int font_size, color font_color, color bg_color, color border_color, int w, int h, ENUM_ALIGN_MODE align)
{
   if(!obj.Create(0,name,0,
      0,
      0,
      w,
      h
   ))
      return(false);
   obj.Text(text);
   obj.Font(font);
   obj.FontSize(font_size);
   obj.Color(font_color);
   if(bg_color != "")
      obj.ColorBackground(bg_color);
   if(border_color != "")
      obj.ColorBorder(border_color);
   // obj.TextAlign(align);
   obj.Locking(false);
   obj.Pressed(false);
   obj.Hide();
   // ObjectSetInteger(0,name,OBJPROP_ZORDER,9999999);
   obj.ZOrder(9999);
   if(!ExtDialog.Add(obj))
      return(false);
   
   return true;
}

bool CAppWindowSelTradingTool::CreateCEdit(CEdit &obj, string name, string text, string font, int font_size, color font_color, color bg_color, int w, int h, ENUM_ALIGN_MODE align, bool read_only)
{
   if(!obj.Create(0,name,0,
      0,
      0,
      w,
      h
   ))
      return(false);
   obj.Text(text);
   obj.Font(font);
   obj.FontSize(font_size);
   obj.Color(font_color);
   if(bg_color != "")
      obj.ColorBackground(bg_color);
   obj.TextAlign(align);
   obj.ReadOnly(read_only);
   obj.Hide();
   obj.ZOrder(9999);
   if(!ExtDialog.Add(obj))
      return(false);
   
   return true;

}

bool CAppWindowSelTradingTool::CreateCPanel(CPanel &obj, string name, color bg_color, color border_color, int w, int h, int zorder)
{
   if(!obj.Create(0,name,0,
      0,
      0,
      w,
      h
   ))
      return(false);
   obj.ColorBackground(bg_color);
   obj.ColorBorder(border_color);
   obj.Hide();
   obj.ZOrder(zorder);
   if(!ExtDialog.Add(obj))
      return(false);
   
   return true;

}

bool CAppWindowSelTradingTool::CreateCLabel(CLabel &obj, string name, string text, string font, int font_size, color font_color, color bg_color, int w, int h, ENUM_ANCHOR_POINT align)
{
   // Labelは影響を受けるので補正する
   //--- 画面に1.5インチの幅のボタンを作成します
   double screen_dpi = TerminalInfoInteger(TERMINAL_SCREEN_DPI); // ユーザーのモニターのDPIを取得します
   double base_width = 144;                                     // DPI=96の標準モニターの画面のドットの基本の幅
   oringin_ratio      = 96 / screen_dpi;         // ユーザーモニター（DPIを含む）のボタンの幅を計算します

   if(!obj.Create(0,name,0,
      0,
      0,
      w*oringin_ratio,
      h*oringin_ratio
   ))
      return(false);
    
   obj.Text(text);
   obj.Font(font);
   obj.FontSize(font_size);
   obj.Color(font_color);
   obj.ColorBorder(clrRed);
   if(bg_color != "")
      obj.ColorBackground(bg_color);
   ObjectSetInteger(0,name,OBJPROP_ANCHOR,align);
   obj.Hide();  
   obj.ZOrder(9999);
   if(!ExtDialog.Add(obj))
      return(false);
   

   return true;
}

//+------------------------------------------------------------------+ 
//| Create the "Combobox" element                                    | 
//+------------------------------------------------------------------+ 
bool CAppWindowSelTradingTool::CreateCCombobox(CComboBox &obj, string name, int w, int h) 
  {
  if(!obj.Create(0,name,0,
                  0,
                  0,
                  w,
                  h
                 ))
      return(false);
   
   obj.Hide();
   if(!ExtDialog.Add(obj))
      return(false);
//--- succeed 
   return(true); 
  }
  
//+------------------------------------------------------------------+ 
//| Create the "Checkbox" element                                    | 
//+------------------------------------------------------------------+ 
bool CAppWindowSelTradingTool::CreateCCheckBox(CCheckBoxEx &obj,string name,string text,string font,int font_size,color font_color,int w,int h)
  {
  if(!obj.Create(0,name,0,
                  0,
                  0,
                  w,
                  h
                 ))
      return(false);
   
   obj.Hide();
   if(!ExtDialog.Add(obj))
      return(false);
      
   obj.Text(text);
   obj.Font(font);
   obj.FontSize(font_size);
   obj.Color(font_color);
//--- succeed 
   return(true); 
  }  
  
//+------------------------------------------------------------------+
//| Global Variable                                                  |
//+------------------------------------------------------------------+
CAppWindowSelTradingTool ExtDialog;
//+------------------------------------------------------------------+
//| Create the "Symbol" dropdown menu                                |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateSymbolPopupMenu()
{
   if (!symbolMenuExpanded)
     {
      int x = m_menu_symbol.Left();
      int y = m_menu_symbol.Top();      
      
      y += MENU_EDIT_HEIGHT;      
      m_menu_popup_panel.Move(x-1, y-1);
      m_menu_popup_panel.Show();      
      
      int items_total = ArraySize(m_menu_popup_items);
      int cols = items_total / SYMBOL_MENU_COL_ITEM_COUNT;
      if (MathMod(items_total, SYMBOL_MENU_COL_ITEM_COUNT) > 0)
         cols++;
      for (int i = 0; i < cols; i++)
        {
         for (int j = 0; j < SYMBOL_MENU_COL_ITEM_COUNT; j++)
         {
            int k = i * SYMBOL_MENU_COL_ITEM_COUNT + j;
            if (k >= items_total) 
               break;
            
            m_menu_popup_items[k].Move(x + MENU_PANEL_EDIT_WIDTH * i, y + MENU_EDIT_HEIGHT * j); 
            m_menu_popup_items[k].ColorBorder(common_edit_ColorBackground);
            m_menu_popup_items[k].Show();
         }         
        }
      
      symbolMenuExpanded = true;
     }
   else
     {
      HideAll(SYMBOL_MENU_NAME_PREFIX);
        
      symbolMenuExpanded = false;
     }  
   
//--- succeed
   return(true);
}

bool CAppWindowSelTradingTool::CreateGraphSymbolPopupMenu()
{
   if (!graphSymbolMenuExpanded)
     {
      int x = m_graph_symbol.Left();
      int y = m_graph_symbol.Top();      
      
      y += MENU_EDIT_HEIGHT;      
      m_graph_popup_panel.Move(x-1, y-1);
      m_graph_popup_panel.Show();      
      
      int items_total = ArraySize(m_graph_popup_items);
      int cols = items_total / SYMBOL_MENU_COL_ITEM_COUNT;
      if (MathMod(items_total, SYMBOL_MENU_COL_ITEM_COUNT) > 0)
         cols++;
      for (int i = 0; i < cols; i++)
        {
         for (int j = 0; j < SYMBOL_MENU_COL_ITEM_COUNT; j++)
         {
            int k = i * SYMBOL_MENU_COL_ITEM_COUNT + j;
            if (k >= items_total) 
               break;
            
            m_graph_popup_items[k].Move(x + MENU_EDIT_WIDTH * i, y + MENU_EDIT_HEIGHT * j); 
            m_graph_popup_items[k].ColorBorder(common_edit_ColorBackground);
            m_graph_popup_items[k].Show();
         }         
        }
      
      graphSymbolMenuExpanded = true;
     }
   else
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
        
      graphSymbolMenuExpanded = false;
     }  
   
//--- succeed
   return(true);
}
//+------------------------------------------------------------------+
//| Create the "Common" button                                      |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateTopMenu(int x, int y)
{
   //---
   HideAll(SYMBOL_MENU_NAME_PREFIX);
   symbolMenuExpanded = false;
   
   //---
   y+=BODY_INDENT_ROW/3;
   m_menu_symbol.Move(x, y);
   m_menu_symbol.Text(_Symbol);
   m_menu_symbol.ColorBorder(symbol_menu_ColorBackground);
   m_menu_symbol.Show();
   
   x = ExtDialog.Right()-BODY_INDENT_LEFT-MENU_INDENT_LEFT;
   m_menu_status.Move(x-MENU_EDIT_WIDE_WIDTH, y);
   m_menu_status.ColorBorder(symbol_menu_ColorBackground);//common_edit_ColorBackground
   m_menu_status.Show();
   
   return (true);
}
//+------------------------------------------------------------------+
//| Create the "Common" button                                      |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateCommon(int x, int y)
{
   // trade button
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   y += BODY_INDENT_TOP/2;
   m_trade_button_bid.Move(x, y);
   m_trade_button_bid.Show();
   x+=TRADE_BUTTON_WIDTH;
   m_trade_button_ask.Move(x, y);
   m_trade_button_ask.Show();

   y += TRADE_BUTTON_HEIGHT/7;

   // tick label
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_trade_label_bid.Move(x+TRADE_LABEL_WIDTH/1.35, y+TRADE_LABEL_HEIGHT/2);
   m_trade_label_bid.Show();
   x+=TRADE_BUTTON_WIDTH;
   m_trade_label_ask.Move(x+TRADE_LABEL_WIDTH/1.35, y+TRADE_LABEL_HEIGHT/2);
   m_trade_label_ask.Show();

   y += TRADE_BUTTON_HEIGHT/9*4;
   // y += TRADE_BUTTON_HEIGHT/5*2;

   // tick label
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_tick_label_bid.Move(x+TICK_LABEL_WIDTH/1.35, y+TICK_LABEL_HEIGHT/2);
   m_tick_label_bid.Show();
   x+=TRADE_BUTTON_WIDTH;
   m_tick_label_ask.Move(x+TICK_LABEL_WIDTH/1.35, y+TICK_LABEL_HEIGHT/2);
   m_tick_label_ask.Show();

   y += TRADE_BUTTON_HEIGHT/5*2;

   y+=BODY_INDENT_ROW;
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_line1.Move(x, y);
   m_common_line1.Show();
   y += BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_lot_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_lot_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH;
   m_common_button_auto.Move(x, y);
   m_common_button_auto.Show();
   x+=COMMON_LABEL_COL2_WIDTH/2;
   m_common_button_manual.Move(x, y);
   m_common_button_manual.Show();
   x+=COMMON_LABEL_COL2_WIDTH/2+BODY_INDENT_CENTER;
   m_common_lot.Move(x, y);
   m_common_lot.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_risk_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_risk_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH + COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   m_common_risk_down.Move(x, y);
   m_common_risk_down.Show();
   x+=COMMON_LABEL_COL5_WIDTH;
   m_common_risk.Move(x, y);
   m_common_risk.Show();
   x+=COMMON_LABEL_COL4_WIDTH;
   m_common_risk_up.Move(x, y);
   m_common_risk_up.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;
   
   y += BODY_INDENT_ROW/2;
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_line2.Move(x, y);
   m_common_line2.Show();
   y += BODY_INDENT_ROW*2/3;
   
   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_pl_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_pl_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH;
   m_common_label_pl_price.Move(x+COMMON_LABEL_COL2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_pl_price.Show();
   x+=COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   // m_common_label_pl_pips.Move(x+COMMON_LABEL_COL3_1_1_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   // m_common_label_pl_pips.Show();
   x+=COMMON_LABEL_COL3_1_1_WIDTH;
   m_common_label_pl_pips_str.Move(x+COMMON_LABEL_COL3_1_2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_pl_pips_str.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_sl_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_sl_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH;
   m_common_label_sl_price.Move(x+COMMON_LABEL_COL2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_sl_price.Show();
   x+=COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   // m_common_label_sl_pips.Move(x+COMMON_LABEL_COL3_1_1_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   // m_common_label_sl_pips.Show();
   x+=COMMON_LABEL_COL3_1_1_WIDTH;
   m_common_label_sl_pips_str.Move(x+COMMON_LABEL_COL3_1_2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_sl_pips_str.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;   

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_plplan_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_plplan_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   // m_common_label_plplan.Move(x+COMMON_LABEL_COL3_3_1_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   // m_common_label_plplan.Show();
   x+=COMMON_LABEL_COL3_3_1_WIDTH;
   m_common_label_plplan_currency.Move(x+COMMON_LABEL_COL3_3_2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_plplan_currency.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_slplan_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_slplan_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   // m_common_label_slplan.Move(x+COMMON_LABEL_COL3_3_1_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   // m_common_label_slplan.Show();
   x+=COMMON_LABEL_COL3_3_1_WIDTH;
   m_common_label_slplan_currency.Move(x+COMMON_LABEL_COL3_3_2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_slplan_currency.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_winrate_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_winrate_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   // m_common_label_winrate.Move(x+COMMON_LABEL_COL3_2_1_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   // m_common_label_winrate.Show();
   x+=COMMON_LABEL_COL3_2_1_WIDTH;
   m_common_label_winrate_percent_str.Move(x+COMMON_LABEL_COL3_2_2_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_winrate_percent_str.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT;
   m_common_label_plslrate_str.Move(x, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_plslrate_str.Show();
   x+=COMMON_LABEL_COL1_WIDTH+COMMON_LABEL_COL2_WIDTH+BODY_INDENT_CENTER;
   m_common_label_plslrate.Move(x+COMMON_LABEL_COL3_WIDTH, y+COMMON_LABEL_HEIGHT/2);
   m_common_label_plslrate.Show();

   y += COMMON_LABEL_HEIGHT+BODY_INDENT_ROW+BODY_INDENT_ROW;

   x=ExtDialog.Left()+BODY_INDENT_LEFT+COMMON_LABEL_FOOTER_INFO_INDENT;
   m_common_button_horizon.Move(x, y);
   m_common_button_horizon.Show();
   x+=COMMON_LABEL_FOOTER_WIDTH+COMMON_LABEL_FOOTER_INDENT;
   m_common_button_alerm.Move(x, y);
   m_common_button_alerm.Show();
   x+=COMMON_LABEL_FOOTER_WIDTH+COMMON_LABEL_FOOTER_INDENT;
   m_info_button_camera.Move(x, y);
   m_info_button_camera.Show();
   x += COMMON_LABEL_FOOTER_WIDTH+COMMON_LABEL_FOOTER_INDENT;
   m_menu_button_info.Move(x, y);
   m_menu_button_info.Show();

   int height_diff = this.Height() - my_client.Height();
   this.Height(m_menu_button_info.Bottom() - this.Top() + BODY_INDENT_ROW);
   my_client.Height(this.Height() - height_diff);
   //my_client.Move(ExtDialog.Left()+MENU_INDENT_LEFT, ExtDialog.Top()+MENU_INDENT_TOP);
   //my_client.Show();
   
   m_sub_main_panel.Width(my_client.Width());
   //m_sub_main_panel.Height(my_client.Height()-MENU_EDIT_HEIGHT-MENU_INDENT_TOP-BODY_INDENT_ROW/3*2);
   m_sub_main_panel.Move(ExtDialog.Left()+MENU_INDENT_LEFT, ExtDialog.Top()+MENU_INDENT_TOP+MENU_EDIT_HEIGHT+BODY_INDENT_ROW/3*2);
   m_sub_main_panel.Show();

//--- succeed
   return(true);
}

bool CAppWindowSelTradingTool::CreateSub()
{
   // サブパネルを表示したまま最小化して足を切り替えると、初期化でサブパネルのサイズが小さくなってしまう不具合対応
   m_position_panel.Width(ExtDialog.Width());
   m_position_panel.Height(ExtDialog.Height());
   // ダイアログ表示
   int x, y;
   x=ExtDialog.Left()+ExtDialog.Width();
   y=ExtDialog.Top();
   // パネル
   m_position_panel.Move(x, y);
   m_position_panel.Show();
   // 部分決済
   x+=BODY_INDENT_LEFT;
   y+=BODY_INDENT_ROW;
   m_position_label_percent.Move(x, y+POSITION_LABEL_HEIGHT/2);
   m_position_label_percent.Show();
   x+=POSITION_LABEL_COL1_WIDTH;
   m_position_button_percent_down_10.Move(x, y);
   m_position_button_percent_down_10.Show();
   x+=POSITION_BUTTON1_WIDTH+BODY_INDENT_CENTER;
   m_position_button_percent_down.Move(x, y);
   m_position_button_percent_down.Show();
   x+=POSITION_BUTTON2_WIDTH+BODY_INDENT_CENTER;
   m_position_edit_percent.Move(x, y);
   m_position_edit_percent.Show();
   x+=POSITION_EDIT1_WIDTH+BODY_INDENT_CENTER;
   m_position_button_percent_up.Move(x, y);
   m_position_button_percent_up.Show();
   x+=POSITION_BUTTON3_WIDTH+BODY_INDENT_CENTER;
   m_position_button_percent_up_10.Move(x, y);
   m_position_button_percent_up_10.Show();

   // 決済ボタン
   int space = m_position_panel.Width() - (INFO_BUTTON1_WIDTH*3 + BODY_INDENT_CENTER*2);
   x=ExtDialog.Left()+ExtDialog.Width()+space/2;
   y=ExtDialog.Top()+MENU_INDENT_TOP;
   y += MENU_BUTTON_HEIGHT;

   m_info_button_exit_sell.Move(x, y);
   m_info_button_exit_sell.Show();
   x+=INFO_BUTTON1_WIDTH + BODY_INDENT_CENTER;
   m_info_button_exit_buy.Move(x, y);
   m_info_button_exit_buy.Show();
   x+=INFO_BUTTON1_WIDTH + BODY_INDENT_CENTER;
   m_info_button_exit_all.Move(x, y);
   m_info_button_exit_all.Show();
   y += INFO_BUTTON1_HEIGHT+BODY_INDENT_ROW;

   // 注文削除
   // x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   // x+=INFO_BUTTON1_WIDTH + BODY_INDENT_CENTER;
   x = m_info_button_exit_all.Right() - m_info_button_cancel_all.Width();
   m_info_button_cancel_all.Move(x, y);
   m_info_button_cancel_all.Show();
   y += INFO_BUTTON1_HEIGHT+BODY_INDENT_ROW;

   // 水平線
   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_line1.Move(x, y);
   m_info_line1.Show();
   y += BODY_INDENT_ROW + BODY_INDENT_ROW/2;

   // ポジション情報
   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_position_buy.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_buy.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_position_buy_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_buy_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_position_sell.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_sell.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_position_sell_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_sell_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_position_all.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_all.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_position_all_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_position_all_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   // 水平線
   y = m_common_line2.Top();
   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_line2.Move(x, y);
   m_info_line2.Show();
   y += BODY_INDENT_ROW;
   
   // 証拠金情報
   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_account_info01.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info01.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_account_info01_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info01_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_account_info02.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info02.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_account_info02_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info02_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_account_info03.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info03.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_account_info03_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info03_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   m_info_label_account_info04.Move(x, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info04.Show();
   x+=INFO_LABEL_COL1_WIDTH;
   m_info_label_account_info04_price.Move(x+INFO_LABEL_COL2_WIDTH, y+INFO_LABEL_HEIGHT/2);
   m_info_label_account_info04_price.Show();
   y += INFO_LABEL_HEIGHT+BODY_INDENT_ROW;

   // リセットボタン
   x=ExtDialog.Left()+ExtDialog.Width()+BODY_INDENT_LEFT;
   y=m_menu_button_info.Top();
   m_common_button_reset.Move(x, y);
   m_common_button_reset.Show();
   
   x+=COMMON_LABEL_FOOTER_WIDTH+COMMON_LABEL_FOOTER_INDENT;
   m_common_button_graph.Move(x, y);
   m_common_button_graph.Show();
   // x+=COMMON_LABEL_FOOTER_WIDTH+COMMON_LABEL_FOOTER_INDENT;
   // x=ExtDialog.Left()+ExtDialog.Width()+ExtDialog.Width()-BODY_INDENT_LEFT-INFO_CAMERA_WIDTH;
   // m_info_button_camera.Move(x, y);
   // m_info_button_camera.Show();
//--- succeed
   return(true);
}

bool CAppWindowSelTradingTool::CreatePositionMenu(double x, double y, string sparam){
   // 選択したpositionチケットを設定する
   string tmp_ticket = sparam;
   StringReplace(tmp_ticket, POSITION_NAME_PREFIX + "_button_", "");
   // 既に開いていたら閉じる
   if(
      m_position_menu_main_panel.IsVisible()
      && StringToInteger(tmp_ticket) == open_menu_position_ticket
   ){
      // ボタンの色を戻す
      ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, position_line_button_color);
      ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
      ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
      HideAll(POSITION_MENU_NAME_PREFIX);
      return true;
   }else if(StringToInteger(tmp_ticket) != open_menu_position_ticket){
      // 違うボタンが押されたので、前のボタンの色を戻す
      ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   }
   // ボタンの色を押してる風に変える
   ObjectSetInteger(0, sparam, OBJPROP_BGCOLOR, position_line_button_active_color);

   open_menu_position_ticket = StringToInteger(tmp_ticket);
   m_position_menu_main_exit.Text("　決済　" + tmp_ticket);
   // Print("open_menu_position_ticket: ", open_menu_position_ticket);
   // Print("x=", x, " y=", y);

   // 色を変える
   m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   // メニューを表示する
   x=(int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS)-(int)ObjectGetInteger(0,sparam,OBJPROP_XDISTANCE)+POSITION_LABEL1_WIDTH;
   y=(int)ObjectGetInteger(0,sparam,OBJPROP_YDISTANCE)+POSITION_BUTTON2_WIDTH;
   int height = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
   if(y + m_position_menu_main_panel.Height() > height)
      y = (int)ObjectGetInteger(0,sparam,OBJPROP_YDISTANCE)-m_position_menu_main_panel.Height();
   //x = x - POSITION_MENU_MAIN_WIDTH - POSITION_MENU_SUB_WIDTH - POSITION_LABEL1_WIDTH;   
   // パネル
   m_position_menu_main_panel.Move(x, y);
   m_position_menu_main_panel.Show();
   // 部品
   m_position_menu_main_close.Move(x + POSITION_MENU_MAIN_WIDTH - POSITION_MENU_CLOSE_WIDTH, y);
   m_position_menu_main_close.Show();
   m_position_menu_main_exit_panel.Move(x, y);
   m_position_menu_main_exit_panel.Show();
   m_position_menu_main_exit.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_exit.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_doten_panel.Move(x, y);
   m_position_menu_main_doten_panel.Show();
   m_position_menu_main_doten.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_doten.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_percent_exit_panel.Move(x, y);
   m_position_menu_main_percent_exit_panel.Show();
   m_position_menu_main_percent_exit.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_percent_exit.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_sltatene_panel.Move(x, y);
   m_position_menu_main_sltatene_panel.Show();
   m_position_menu_main_sltatene.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_sltatene.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_trailingstop_panel.Move(x, y);
   m_position_menu_main_trailingstop_panel.Show();
   m_position_menu_main_trailingstop.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_trailingstop.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_tpsl_panel.Move(x, y);
   m_position_menu_main_tpsl_panel.Show();
   m_position_menu_main_tpsl.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_tpsl.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_main_ma_tpsl_panel.Move(x, y);
   m_position_menu_main_ma_tpsl_panel.Show();
   m_position_menu_main_ma_tpsl.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_main_ma_tpsl.Show();
   
   //---
   ShowPositionStopInfo(open_menu_position_ticket);

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::RemovePositionTp(double x, double y, string sparam){
   // 選択したpositionチケットを設定する
   string tmp_ticket = sparam;
   StringReplace(tmp_ticket, POSITION_TP_NAME_PREFIX, "");
   int ticket = StringToInteger(tmp_ticket);
   Print("ticket: ", ticket);

   if(m_position.SelectByTicket(ticket)){
      MqlTradeRequest request;
      MqlTradeResult  result;
      MqlTradeCheckResult chkresult;
      ZeroMemory(request);
      ZeroMemory(result);
      ZeroMemory(chkresult);
      //--- 操作パラメータの設定
      request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
      request.position=m_position.Ticket();   // ポジションシンボル
      request.symbol=m_position.Symbol();     // シンボル
      request.sl      =m_position.StopLoss();               // ポジションのStop Loss
      request.tp      =0;               // ポジションのTake Profit
      //--- 変更情報の出力
      PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
      //--- 変更できるかチェック
      if(!OrderCheck(request, chkresult)){
         Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
         return (false);
      }
      //--- リクエストの送信
      if(!OrderSend(request,result)){
         PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
         return (false);
      }
      //--- 操作情報 
      PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
      ObjectDelete(0,sparam);
   }

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::RemovePositionSl(double x, double y, string sparam){
   // 選択したpositionチケットを設定する
   string tmp_ticket = sparam;
   StringReplace(tmp_ticket, POSITION_SL_NAME_PREFIX, "");
   int ticket = StringToInteger(tmp_ticket);
   Print("ticket: ", ticket);

   if(m_position.SelectByTicket(ticket)){
      MqlTradeRequest request;
      MqlTradeResult  result;
      MqlTradeCheckResult chkresult;
      ZeroMemory(request);
      ZeroMemory(result);
      ZeroMemory(chkresult);
      //--- 操作パラメータの設定
      request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
      request.position=m_position.Ticket();   // ポジションシンボル
      request.symbol=m_position.Symbol();     // シンボル
      request.sl      =0;               // ポジションのStop Loss
      request.tp      =m_position.TakeProfit();               // ポジションのTake Profit
      //--- 変更情報の出力
      PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
      //--- 変更できるかチェック
      if(!OrderCheck(request, chkresult)){
         Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
         return (false);
      }
      //--- リクエストの送信
      if(!OrderSend(request,result)){
         PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
         return (false);
      }
      //--- 操作情報 
      PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
      ObjectDelete(0,sparam);
   }

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::RemoveOrder(double x, double y, string sparam){
   // 選択したpositionチケットを設定する
   string tmp_ticket = sparam;
   StringReplace(tmp_ticket, POSITION_ORDER_NAME_PREFIX, "");
   int ticket = StringToInteger(tmp_ticket);
   Print("ticket: ", ticket);

   if(m_order.Select(ticket)){
      MqlTradeRequest request;
      MqlTradeResult  result;
      MqlTradeCheckResult chkresult;
      ZeroMemory(request);
      ZeroMemory(result);
      ZeroMemory(chkresult);
      //--- 操作パラメータの設定
      request.action  =TRADE_ACTION_REMOVE; // 取引操作タイプ
      request.order = m_order.Ticket();
      if(!OrderSend(request,result)){
         PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
      }
      ObjectDelete(0,sparam);
   }

   //--- succeed
   return(true);
}
  
bool CAppWindowSelTradingTool::ChkOnMouse(double x, double y, string sparam){
   // Print("ChkOnMouse ", x, " ", y, " ", sparam);

   if(m_position_menu_main_panel.IsVisible()){
      // ポジションメニューが出ている
      // ×ボタン
      if(
         m_position_menu_main_close.Left() <= x && 
         m_position_menu_main_close.Left() + m_position_menu_main_close.Width() >= x &&
         m_position_menu_main_close.Top() <= y && 
         m_position_menu_main_close.Top() + m_position_menu_main_close.Height() >= y
      ){
         if(m_position_menu_main_close.ColorBackground() == position_menu_close_ColorBackground){
            m_position_menu_main_close.ColorBackground(position_menu_close_ColorBackground_active);
         }
      }else if(m_position_menu_main_close.ColorBackground() == position_menu_close_ColorBackground_active){
         m_position_menu_main_close.ColorBackground(position_menu_close_ColorBackground);
      }
      // 決済ボタン
      if(
         m_position_menu_main_exit_panel.Left() <= x && 
         m_position_menu_main_exit_panel.Left() + m_position_menu_main_exit_panel.Width() >= x &&
         m_position_menu_main_exit_panel.Top() <= y && 
         m_position_menu_main_exit_panel.Top() + m_position_menu_main_exit_panel.Height() >= y
      ){
         if(m_position_menu_main_exit_panel.ColorBackground() == position_menu_ColorBackground){
            m_position_menu_main_exit_panel.ColorBackground(position_menu_active_ColorBackground);
         }
      }else if(m_position_menu_main_exit_panel.ColorBackground() == position_menu_active_ColorBackground){
         m_position_menu_main_exit_panel.ColorBackground(position_menu_ColorBackground);
      }
      // ドテンボタン
      if(
         m_position_menu_main_doten_panel.Left() <= x && 
         m_position_menu_main_doten_panel.Left() + m_position_menu_main_doten_panel.Width() >= x &&
         m_position_menu_main_doten_panel.Top() <= y && 
         m_position_menu_main_doten_panel.Top() + m_position_menu_main_doten_panel.Height() >= y
      ){
         if(m_position_menu_main_doten_panel.ColorBackground() == position_menu_ColorBackground){
            m_position_menu_main_doten_panel.ColorBackground(position_menu_active_ColorBackground);
         }
      }else if(m_position_menu_main_doten_panel.ColorBackground() == position_menu_active_ColorBackground){
         m_position_menu_main_doten_panel.ColorBackground(position_menu_ColorBackground);
      }
      // %決済ボタン
      if(!m_position_menu_sub_percent_input.IsVisible()){
         if(
            m_position_menu_main_percent_exit_panel.Left() <= x && 
            m_position_menu_main_percent_exit_panel.Left() + m_position_menu_main_percent_exit_panel.Width() >= x &&
            m_position_menu_main_percent_exit_panel.Top() <= y && 
            m_position_menu_main_percent_exit_panel.Top() + m_position_menu_main_percent_exit_panel.Height() >= y
         ){
            if(m_position_menu_main_percent_exit_panel.ColorBackground() == position_menu_ColorBackground){
               m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_active_ColorBackground);
            }
         }else if(m_position_menu_main_percent_exit_panel.ColorBackground() == position_menu_active_ColorBackground){
            m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
         }
      }
      // SL建値ボタン
      if(
         m_position_menu_main_sltatene_panel.Left() <= x && 
         m_position_menu_main_sltatene_panel.Left() + m_position_menu_main_sltatene_panel.Width() >= x &&
         m_position_menu_main_sltatene_panel.Top() <= y && 
         m_position_menu_main_sltatene_panel.Top() + m_position_menu_main_sltatene_panel.Height() >= y
      ){
         if(m_position_menu_main_sltatene_panel.ColorBackground() == position_menu_ColorBackground){
            m_position_menu_main_sltatene_panel.ColorBackground(position_menu_active_ColorBackground);
         }
      }else if(m_position_menu_main_sltatene_panel.ColorBackground() == position_menu_active_ColorBackground){
         m_position_menu_main_sltatene_panel.ColorBackground(position_menu_ColorBackground);
      }
      // 自動SL建値ボタン
      if(!m_position_menu_sub_trailingstop_targetpips.IsVisible()){
         if(
            m_position_menu_main_trailingstop_panel.Left() <= x && 
            m_position_menu_main_trailingstop_panel.Left() + m_position_menu_main_trailingstop_panel.Width() >= x &&
            m_position_menu_main_trailingstop_panel.Top() <= y && 
            m_position_menu_main_trailingstop_panel.Top() + m_position_menu_main_trailingstop_panel.Height() >= y
         ){
            if(m_position_menu_main_trailingstop_panel.ColorBackground() == position_menu_ColorBackground){
               m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_active_ColorBackground);
            }
         }else if(m_position_menu_main_trailingstop_panel.ColorBackground() == position_menu_active_ColorBackground){
            m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
         }
      }
      // TPSL設定ボタン
      if(!m_position_menu_sub_tpsl_tp_input.IsVisible()){
         if(
            m_position_menu_main_tpsl_panel.Left() <= x && 
            m_position_menu_main_tpsl_panel.Left() + m_position_menu_main_tpsl_panel.Width() >= x &&
            m_position_menu_main_tpsl_panel.Top() <= y && 
            m_position_menu_main_tpsl_panel.Top() + m_position_menu_main_tpsl_panel.Height() >= y
         ){
            if(m_position_menu_main_tpsl_panel.ColorBackground() == position_menu_ColorBackground){
               m_position_menu_main_tpsl_panel.ColorBackground(position_menu_active_ColorBackground);
            }
         }else if(m_position_menu_main_tpsl_panel.ColorBackground() == position_menu_active_ColorBackground){
            m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
         }
      }
      // MA TPSL設定ボタン
      if(!m_position_menu_sub_ma_tp_period.IsVisible()){
         if(
            m_position_menu_main_ma_tpsl_panel.Left() <= x && 
            m_position_menu_main_ma_tpsl_panel.Left() + m_position_menu_main_ma_tpsl_panel.Width() >= x &&
            m_position_menu_main_ma_tpsl_panel.Top() <= y && 
            m_position_menu_main_ma_tpsl_panel.Top() + m_position_menu_main_ma_tpsl_panel.Height() >= y
         ){
            if(m_position_menu_main_ma_tpsl_panel.ColorBackground() == position_menu_ColorBackground){
               m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_active_ColorBackground);
            }
         }else if(m_position_menu_main_ma_tpsl_panel.ColorBackground() == position_menu_active_ColorBackground){
            m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
         }
      }   
   }
   
   if (m_menu_popup_panel.IsVisible())
     {
      int vidx = -1, hidx = -1;
      int idx = -1;
      if(m_menu_popup_panel.Left() <= x && 
         m_menu_popup_panel.Left() + m_menu_popup_panel.Width() >= x &&
         m_menu_popup_panel.Top() <= y && 
         m_menu_popup_panel.Top() + m_menu_popup_panel.Height() >= y)
        {
         hidx = (x - m_menu_popup_panel.Left()) / MENU_PANEL_EDIT_WIDTH;
         vidx = (y - m_menu_popup_panel.Top()) / MENU_EDIT_HEIGHT;
         if (vidx < SYMBOL_MENU_COL_ITEM_COUNT)
           {
            idx = hidx * SYMBOL_MENU_COL_ITEM_COUNT + vidx;
            if (idx < ArraySize(m_menu_popup_items))
              {
               m_menu_popup_items[idx].ColorBackground(symbol_menu_ColorSelected);   
              }
           }
        }
       
       for (int i = 0; i < ArraySize(m_menu_popup_items); i++)
        {
         if (i == idx) continue;
         m_menu_popup_items[i].ColorBackground(common_edit_ColorBackground);
        } 
     }
   
   if (m_menu_symbol.IsVisible())
     {
      if(m_menu_symbol.Left() <= x && 
         m_menu_symbol.Left() + m_menu_symbol.Width() >= x &&
         m_menu_symbol.Top() <= y && 
         m_menu_symbol.Top() + m_menu_symbol.Height() >= y)
        {
         m_menu_symbol.ColorBorder(C'178,195,207');
        }
      else
        {
         m_menu_symbol.ColorBorder(symbol_menu_ColorBackground);
        }  
     }  
   
   // graph symbol menu
   if (m_graph_popup_panel.IsVisible())
     {
      int vidx = -1, hidx = -1;
      int idx = -1;
      if(m_graph_popup_panel.Left() <= x && 
         m_graph_popup_panel.Left() + m_graph_popup_panel.Width() >= x &&
         m_graph_popup_panel.Top() <= y && 
         m_graph_popup_panel.Top() + m_graph_popup_panel.Height() >= y)
        {
         hidx = (x - m_graph_popup_panel.Left()) / MENU_EDIT_WIDTH;
         vidx = (y - m_graph_popup_panel.Top()) / MENU_EDIT_HEIGHT;
         if (vidx < SYMBOL_MENU_COL_ITEM_COUNT)
           {
            idx = hidx * SYMBOL_MENU_COL_ITEM_COUNT + vidx;
            if (idx < ArraySize(m_graph_popup_items))
              {
               m_graph_popup_items[idx].ColorBackground(symbol_menu_ColorSelected);   
              }
           }  
        }
       
       for (int i = 0; i < ArraySize(m_graph_popup_items); i++)
        {
         if (i == idx) continue;
         m_graph_popup_items[i].ColorBackground(common_edit_ColorBackground);
        } 
     }
       
   if (m_graph_symbol.IsVisible())
     {
      if(m_graph_symbol.Left() <= x && 
         m_graph_symbol.Left() + m_graph_symbol.Width() >= x &&
         m_graph_symbol.Top() <= y && 
         m_graph_symbol.Top() + m_graph_symbol.Height() >= y)
        {
         m_graph_symbol.ColorBorder(C'178,195,207');
        }
      else
        {
         m_graph_symbol.ColorBorder(symbol_menu_ColorBackground);
        }  
     }    
   //--- succeed
   return(true);
}

bool CAppWindowSelTradingTool::ChkAxesOnPopupPanel(double x, double y)
{
   if (m_menu_popup_panel.IsVisible())
     {         
      if(m_menu_popup_panel.Left() <= x &&
         m_menu_popup_panel.Left() + m_menu_popup_panel.Width() >= x &&
         m_menu_popup_panel.Top() <= y &&
         m_menu_popup_panel.Top() + m_menu_popup_panel.Height() >= y)
        {
         return(true);
        }
     }
     
   if (m_graph_popup_panel.IsVisible())
     {
      if(m_graph_popup_panel.Left() <= x && 
         m_graph_popup_panel.Left() + m_graph_popup_panel.Width() >= x &&
         m_graph_popup_panel.Top() <= y && 
         m_graph_popup_panel.Top() + m_graph_popup_panel.Height() >= y)
        {
         return(true);
        }
     }
        
   return(false);    
}
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateMarket(void)
  {
   trade_mode=1;
   ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTABLE,false);
   ReDraw();

   if(!HideAll("m_"))
      return(false);
   
   int x=ExtDialog.Left()+MENU_INDENT_LEFT;
   int y=ExtDialog.Top()+MENU_INDENT_TOP;
   
   //---   
   CreateTopMenu(x, y);
   //---
   y += MENU_EDIT_HEIGHT+BODY_INDENT_ROW/3*2;
   m_menu_label_now_menu.Move(x+MENU_BUTTON_WIDTH/2, y+MENU_BUTTON_HEIGHT/2);
   m_menu_label_now_menu.Text("成行");
   m_menu_label_now_menu.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_button_limit.Move(x, y);
   m_menu_button_limit.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_button_stoplimit.Move(x, y);
   m_menu_button_stoplimit.Show();

   y += MENU_BUTTON_HEIGHT;

   //--- 共通パーツ描画
   CreateCommon(x, y);

//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateLimit(void)
  {
   trade_mode=2;
   ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTABLE,true);
   ReDraw();

   if(!HideAll("m_"))
      return(false);
   
   int x=ExtDialog.Left()+MENU_INDENT_LEFT;
   int y=ExtDialog.Top()+MENU_INDENT_TOP;
   
   //---   
   CreateTopMenu(x, y);
   //---   
   y += MENU_EDIT_HEIGHT+BODY_INDENT_ROW/3*2;
   m_menu_button_market.Move(x, y);
   m_menu_button_market.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_label_now_menu.Move(x+MENU_BUTTON_WIDTH/2, y+MENU_BUTTON_HEIGHT/2);
   m_menu_label_now_menu.Text("指値");
   m_menu_label_now_menu.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_button_stoplimit.Move(x, y);
   m_menu_button_stoplimit.Show();

   y += MENU_BUTTON_HEIGHT;

   // 共通パーツ描画
   CreateCommon(x, y);


//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "Button3"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateStopLimit(void)
  {
   trade_mode=3;
   ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTABLE,true);
   ReDraw();

   if(!HideAll("m_"))
      return(false);
   
   int x=ExtDialog.Left()+MENU_INDENT_LEFT;
   int y=ExtDialog.Top()+MENU_INDENT_TOP;   
   //---   
   CreateTopMenu(x, y);
   //---
   y += MENU_EDIT_HEIGHT+BODY_INDENT_ROW/3*2;
   m_menu_button_market.Move(x, y);
   m_menu_button_market.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_button_limit.Move(x, y);
   m_menu_button_limit.Show();
   x += MENU_BUTTON_WIDTH;
   m_menu_label_now_menu.Move(x+MENU_BUTTON_WIDTH/2, y+MENU_BUTTON_HEIGHT/2);
   m_menu_label_now_menu.Text("逆指");
   m_menu_label_now_menu.Show();

   y += MENU_BUTTON_HEIGHT;

   // 共通パーツ描画
   CreateCommon(x, y);


//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "Button4"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateInfo(void)
  {
      HideAll(SYMBOL_MENU_NAME_PREFIX);
      symbolMenuExpanded = false;
         
      if(position_panel_set_flg==1){
         // 閉じる処理
         position_panel_set_flg=0;
         
         if(!HideAll("sub_"))
            return(false);
            
         HideAll(GRAPH_NAME_PREFIX);
         m_graph_profitGraph.Destroy();   
      
      } else {         
         // 開く処理
         position_panel_set_flg=1;
         
         CreateSub();
         
         if(graph_panel_set_flg==1){
            CreateGraph();
         }
      }

//--- succeed
   return(true);
  }
  
void CAppWindowSelTradingTool::UpdateGraph(void)
{
   if(graphSymbolMenuExpanded)
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
      graphSymbolMenuExpanded = false;
     }
   
   CreateGraph();
}  

bool CAppWindowSelTradingTool::CreateGraphPanel(void)
{
   if (graph_panel_set_flg==1)
   {
      graph_panel_set_flg=0;
      
      HideAll(GRAPH_NAME_PREFIX);
      
      m_graph_profitGraph.Destroy();
   }
   else
   {
      graph_panel_set_flg=1;
      
      CreateGraph();   
   }
   
   return(true);
}

bool CAppWindowSelTradingTool::CreateGraph(void)
{
   //---
   int x = m_position_panel.Right();
   int y = m_position_panel.Top();   
   m_graph_main_panel.Move(x, y);
   m_graph_main_panel.Show();
   
   // top menus
   if(graphSymbolMenuExpanded)
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
      graphSymbolMenuExpanded = false;
     }
   
   x = m_graph_main_panel.Left() + GRAPH_INDENT_LEFT + 15;
   y = m_graph_main_panel.Top() + GRAPH_INDENT_TOP;
   m_graph_symbol.Move(x, y);
   m_graph_symbol.Text(graphSymbol);
   m_graph_symbol.ColorBorder(symbol_menu_ColorBackground);
   m_graph_symbol.Show();
   
   x = m_graph_main_panel.Right() - GRAPH_INDENT_LEFT - POSITION_MENU_SUB_BUTTON_WIDTH;
   m_graph_pyear_button.Move(x, y);     
   m_graph_pyear_button.Show();
   
   x -= m_graph_pmonth_button.Width();
   m_graph_pmonth_button.Move(x, y);
   m_graph_pmonth_button.Show();
   
   x -= m_graph_pday_button.Width();
   m_graph_pday_button.Move(x, y);
   m_graph_pday_button.Show();
   
   x = (m_graph_pday_button.Left()+m_graph_symbol.Right()) / 2;
   m_graph_totalProfit_label.Move(x, y+COMMON_LABEL_HEIGHT/2+2);
   m_graph_totalProfit_label.Show();
   
   // graph
   CreateSubGraph();
   
   // bottom labels
   y += POSITION_MENU_SUB_BUTTON_HEIGHT + m_graph_profitGraph.Height() + BODY_INDENT_ROW;
   x = m_graph_main_panel.Left() + GRAPH_INDENT_LEFT;
   
   m_graph_totalTrades_label.Move(x, y);
   m_graph_totalTrades_label.Show();
   
   y += COMMON_LABEL_HEIGHT + BODY_INDENT_ROW;
   m_graph_longTrades_label.Move(x, y);
   m_graph_longTrades_label.Show();
   
   y += COMMON_LABEL_HEIGHT + BODY_INDENT_ROW;
   m_graph_shortTrades_label.Move(x, y);
   m_graph_shortTrades_label.Show();
   
   y += COMMON_LABEL_HEIGHT + BODY_INDENT_ROW;
   m_graph_profitFactor_label.Move(x, y);
   m_graph_profitFactor_label.Show();
   
   y += COMMON_LABEL_HEIGHT + BODY_INDENT_ROW;
   m_graph_maxDrawdown_label.Move(x, y);
   m_graph_maxDrawdown_label.Show();
    
   return(true);
}  

double _x_Axis[];
double _y_Axis[];
string TimeFormat(double x, void *cbdata)
  {
   if(x<0.f || ArraySize(_x_Axis)<=x)
      return "";
   
   string strDate = StringSubstr(TimeToString((datetime)_x_Axis[(int)x], TIME_DATE),5);
   string arrDate[];
   StringSplit(strDate,'.',arrDate);
   
   return(IntegerToString(StringToInteger(arrDate[0]))+"/"+IntegerToString(StringToInteger(arrDate[1])));
  }
  
bool CAppWindowSelTradingTool::CreateSubGraph(void)
{
   m_graph_profitGraph.Destroy();
   m_graph_profitGraph.Create(0,"m_graph_pfGraphic",0,0,0,GRAPH_PANEL_MAIN_WIDTH-BODY_INDENT_LEFT*2,GRAPH_PANEL_CANVAS_HEIGTH);
   m_graph_profitGraph.BackgroundColor(graph_panel_ColorBackground);
   
   int x = m_graph_main_panel.Left() + BODY_INDENT_LEFT;
   int y = m_graph_main_panel.Top() + GRAPH_INDENT_TOP + POSITION_MENU_SUB_BUTTON_HEIGHT + BODY_INDENT_ROW/2;
   ObjectSetInteger(ChartID(),"m_graph_pfGraphic",OBJPROP_XDISTANCE,x);
   ObjectSetInteger(ChartID(),"m_graph_pfGraphic",OBJPROP_YDISTANCE,y);
   
   //double _x_Axis[]={-10,-4,-1,2,3,4,5,6,7,8};
   //double _y_Axis[]={-5,4,-10,23,17,18,-9,13,17,4};
   CalcProfitPoints(_x_Axis,_y_Axis);
   
   /*CCurve *curve;
   if (m_graph_profitGraph.CurvesTotal()>0)
   {
      curve=m_graph_profitGraph.CurveGetByIndex(0);
      curve.Update(_y_Axis);
   }
   else   
   {
      curve=m_graph_profitGraph.CurveAdd(_y_Axis,CURVE_LINES);
      //curve.Name("損益グラフ");      
      //curve.LinesSmooth(true);
      //m_graph_profitGraph.HistoryNameWidth(0);            
      //m_graph_profitGraph.XAxis().Name("X - axis");
      //m_graph_profitGraph.XAxis().NameSize(12);          
      //m_graph_profitGraph.YAxis().Name("Y - axis");      
      //m_graph_profitGraph.YAxis().NameSize(12);      
   }*/
   
   m_graph_profitGraph.UpdatePLCurve(_y_Axis);
   
   //m_graph_profitGraph.IndentLeft(100);
   //m_graph_profitGraph.IndentUp(100);
   m_graph_profitGraph.HistoryNameWidth(0);
   m_graph_profitGraph.XAxis().ValuesWidth(20);
   m_graph_profitGraph.YAxis().ValuesWidth(30);
   
   //m_graph_profitGraph.XAxis().AutoScale(false);
   m_graph_profitGraph.XAxis().Type(AXIS_TYPE_CUSTOM);
   m_graph_profitGraph.XAxis().ValuesFunctionFormat(TimeFormat);
   //m_graph_profitGraph.XAxis().DefaultStep((double)ArraySize(_x_Axis)/10);
   
   m_graph_profitGraph.CalculateMaxMinValues();
   
   m_graph_profitGraph.CurvePlotAll();
   m_graph_profitGraph.Update();
   
   return(true);
}

//+------------------------------------------------------------------+
//| Create the "Lines"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateLine(void)
  {
      if(!ObjectCreate(0,HLINE_TP_NAME,OBJ_HLINE,0,0,tp))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,HLINE_SL_NAME,OBJ_HLINE,0,0,sl))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,HLINE_ENTRY_NAME,OBJ_HLINE,0,0,ep))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      // 反対線
      if(!ObjectCreate(0,HLINE_TP_SHADOW_NAME,OBJ_HLINE,0,0,tp))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,HLINE_SL_SHADOW_NAME,OBJ_HLINE,0,0,sl))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,HLINE_ENTRY_SHADOW_NAME,OBJ_HLINE,0,0,ep))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal line! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,RECTANGLE_TP_NAME,OBJ_RECTANGLE_LABEL,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal rectangle! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,RECTANGLE_SL_NAME,OBJ_RECTANGLE_LABEL,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create a horizontal rectangle! Error code = ",GetLastError());
         return(false);
      }
      //--- 線の色を設定する
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_COLOR,tp_line_color);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_COLOR,sl_line_color);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_COLOR,entry_line_color);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_COLOR,tp_line_color);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_COLOR,sl_line_color);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_COLOR,entry_line_color);
      //--- 線の表示スタイルを設定する
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_STYLE,STYLE_DOT);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_STYLE,STYLE_DOT);
      //--- 線の幅を設定する
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_WIDTH,1);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_WIDTH,1);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_WIDTH,1);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_WIDTH,1);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_WIDTH,1);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_WIDTH,1);
      //--- 前景（false）または背景（true）に表示
      ObjectSetInteger(0,HLINE_TP_NAME,            OBJPROP_BACK,false);
      ObjectSetInteger(0,HLINE_SL_NAME,            OBJPROP_BACK,false);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,         OBJPROP_BACK,false);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,     OBJPROP_BACK,true);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,     OBJPROP_BACK,true);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,  OBJPROP_BACK,true);
      //--- マウスで線を移動させるモードを有効（true）か無効（false）にする
      //--- ObjectCreate 関数を使用してグラフィックオブジェクトを作成する際、オブジェクトは
      //--- デフォルトではハイライトされたり動かされたり出来ない。このメソッド内では、選択パラメータは
      //--- デフォルトでは true でハイライトと移動を可能にする。
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_SELECTED,false);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_SELECTED,false);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_SELECTED,false);
      //--- オブジェクトリストのグラフィックオブジェクトを非表示（true）か表示（false）にする
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_HIDDEN,true);
      //--- チャートのマウスクリックのイベントを受信するための優先順位を設定する
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_ZORDER,-1);

      // 非表示にする
      // ObjectSetInteger(0, HLINE_TP_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      // ObjectSetInteger(0, HLINE_SL_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      // ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);


      // 塗りつぶし
      int x, y, x2, y2, x3, y3;
      datetime time = iTime(_Symbol,0,0);
      ChartTimePriceToXY(0, 0, time, ep, x, y);
      ChartTimePriceToXY(0, 0, time, tp, x2, y2);
      ChartTimePriceToXY(0, 0, time, sl, x3, y3);
      //--- ラベル座標を設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_XDISTANCE,0);
      if(y>y2){
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YDISTANCE,y2);
      }else{
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YDISTANCE,y);
      }
      //--- ラベルサイズを設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_XSIZE,5000);
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YSIZE,MathAbs(y-y2));
      //--- 背景色を設定する
      if(bg_select_p == BlackBg)
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_BGCOLOR,line_tp_fill_ColorBackground_black);
      else
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_BGCOLOR,line_tp_fill_ColorBackground_white);
      //--- 境界線を設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      //--- ポイント座標が相対的に定義されているチャートのコーナーを設定
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      //--- フラット境界線色を設定する（Flat モード）
      if(bg_select_p == BlackBg)
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_COLOR,line_tp_fill_ColorBackground_black);
      else
         ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_COLOR,line_tp_fill_ColorBackground_white);
      //--- フラット境界線スタイルを設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_STYLE,STYLE_SOLID);
      //--- フラット境界線幅を設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_WIDTH,0);
      //--- 前景（false）または背景（true）に表示
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_BACK,true);
      //--- マウスでラベルを移動させるモードを有効（true）か無効（false）にする
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_SELECTED,false);
      //--- オブジェクトリストのグラフィックオブジェクトを非表示（true）か表示（false）にする
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_HIDDEN,true);
      //--- チャートのマウスクリックのイベントを受信するための優先順位を設定する
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_ZORDER,0);

      //--- ラベル座標を設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_XDISTANCE,0);
      if(y>y3){
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YDISTANCE,y3);
      }else{
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YDISTANCE,y);
      }
      //--- ラベルサイズを設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_XSIZE,5000);
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YSIZE,MathAbs(y-y3));
      //--- 背景色を設定する
      // Print(ColorToARGB(line_sl_fill_ColorBackground, line_fill_Alpha));
      if(bg_select_p == BlackBg)
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_BGCOLOR,line_sl_fill_ColorBackground_black);
      else
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_BGCOLOR,line_sl_fill_ColorBackground_white);
      //--- 境界線を設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      //--- ポイント座標が相対的に定義されているチャートのコーナーを設定
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      //--- フラット境界線色を設定する（Flat モード）
      if(bg_select_p == BlackBg)
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_COLOR,line_sl_fill_ColorBackground_black);
      else
         ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_COLOR,line_sl_fill_ColorBackground_white);
      //--- フラット境界線スタイルを設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_STYLE,STYLE_SOLID);
      //--- フラット境界線幅を設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_WIDTH,0);
      //--- 前景（false）または背景（true）に表示
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_BACK,true);
      //--- マウスでラベルを移動させるモードを有効（true）か無効（false）にする
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_SELECTED,false);
      //--- オブジェクトリストのグラフィックオブジェクトを非表示（true）か表示（false）にする
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_HIDDEN,true);
      //--- チャートのマウスクリックのイベントを受信するための優先順位を設定する
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_ZORDER,0);

      // ラベル（ボタン）
      if(!ObjectCreate(0,LABEL_TP1_NAME,     OBJ_EDIT,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,LABEL_SL1_NAME,     OBJ_EDIT,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ",GetLastError());
         return(false);
      }
      if(!ObjectCreate(0,LABEL_ENTRY1_NAME,  OBJ_EDIT,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ",GetLastError());
         return(false);
      }
      //--- create a bitmap
      if(!ObjectCreate(0,LABEL_REVERSE_ICON_NAME,OBJ_BITMAP_LABEL,0,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create a bitmap in the chart window! Error code = ",GetLastError());
         return(false);
        }
   //--- set the path to the image file
      if(!ObjectSetString(0,LABEL_REVERSE_ICON_NAME,OBJPROP_BMPFILE,0,"::reverse.bmp"))
        {
         Print(__FUNCTION__,
               ": failed to load the image! Error code = ",GetLastError());
         return(false);
        }        
      /*if(!ObjectSetString(0,LABEL_REVERSE_ICON_NAME,OBJPROP_BMPFILE,1,"reverse.bmp"))
        {
         Print(__FUNCTION__,
               ": failed to load the image! Error code = ",GetLastError());
         return(false);
        }  */
      if(!ObjectCreate(0,LABEL_CANDLETIME_NAME,  OBJ_EDIT,0,0,0))
      {
         Print(__FUNCTION__,
               ": failed to create text label! Error code = ",GetLastError());
         return(false);
      }
      
      //--- ラベルサイズを設定する
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_XSIZE,LINE_LABEL1_WIDTH);
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_YSIZE,LINE_LABEL1_HEIGHT);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_XSIZE,LINE_LABEL1_WIDTH);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_YSIZE,LINE_LABEL1_HEIGHT);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_XSIZE,LINE_LABEL1_WIDTH);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_YSIZE,LINE_LABEL1_HEIGHT);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_XSIZE,LINE_LABEL1_HEIGHT);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_YSIZE,LINE_LABEL1_HEIGHT);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_XSIZE,LINE_CANDLETIME_WIDTH);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_YSIZE,LINE_CANDLETIME_HEIGHT);
      // //--- ラベル座標を設定する
      ChartTimePriceToXY(0, 0, time, tp, x, y);
      y -= LINE_LABEL1_HEIGHT;
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_XDISTANCE,LINE_LABEL1_X);
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_YDISTANCE,y);
      ChartTimePriceToXY(0, 0, time, sl, x, y);
      y -= LINE_LABEL1_HEIGHT;
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_XDISTANCE,LINE_LABEL1_X);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_YDISTANCE,y);
      ChartTimePriceToXY(0, 0, time, ep, x, y);
      y -= LINE_LABEL1_HEIGHT;
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_XDISTANCE,LINE_LABEL1_X);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_XDISTANCE,LINE_LABEL1_X);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_XDISTANCE,LINE_CANDLETIME_WIDTH);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_YDISTANCE,30);
      //--- オブジェクトでのテキスト配置のタイプを設定する
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_ALIGN, ALIGN_CENTER);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_ALIGN, ALIGN_CENTER);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,     OBJPROP_ALIGN, ALIGN_CENTER);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,     OBJPROP_ALIGN, ALIGN_CENTER);
      //--- コーナーを設定する
      ObjectSetInteger(0,LABEL_TP1_NAME,      OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,LABEL_SL1_NAME,      OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,   OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,   OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,   OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      //--- テキストを設定する
      ObjectSetString(0,LABEL_TP1_NAME,      OBJPROP_TEXT,"TP " + DoubleToString(tp_pips, 1));
      ObjectSetString(0,LABEL_SL1_NAME,      OBJPROP_TEXT,"SL " + DoubleToString(sl_pips, 1));
      ObjectSetString(0,LABEL_ENTRY1_NAME,   OBJPROP_TEXT,"RR " + plslrate);
      ObjectSetString(0,LABEL_CANDLETIME_NAME,   OBJPROP_TEXT,"00:00:00");
      //--- テキストフォントを設定する
      ObjectSetString(0,LABEL_TP1_NAME,      OBJPROP_FONT,main_Font);
      ObjectSetString(0,LABEL_SL1_NAME,      OBJPROP_FONT,main_Font);
      ObjectSetString(0,LABEL_ENTRY1_NAME,   OBJPROP_FONT,main_Font);
      ObjectSetString(0,LABEL_CANDLETIME_NAME,   OBJPROP_FONT,main_Font);
      //--- フォントサイズを設定する
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_FONTSIZE,line_FontSize);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_FONTSIZE,line_FontSize);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_FONTSIZE,line_FontSize);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_FONTSIZE,line_FontSize);
      //--- 色を設定
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_COLOR,tp_line_text_color);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_COLOR,sl_line_text_color);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_COLOR,entry_line_text_color);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_COLOR,candletime_line_text_color);
      //--- 背景色を設定
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_BGCOLOR,tp_line_color);
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_BORDER_COLOR,tp_line_color);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_BGCOLOR,sl_line_color);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_BORDER_COLOR,sl_line_color);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_BGCOLOR,entry_line_color);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_BORDER_COLOR,entry_line_color);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_BGCOLOR,candletime_line_color);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_BORDER_COLOR,candletime_line_color);
      //--- 前景（false）または背景（true）に表示
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_BACK,false);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_BACK,false);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_BACK,false);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_BACK,false);
      //--- マウスでラベルを移動させるモードを有効（true）か無効（false）にする
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_SELECTED,false);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_SELECTED,false);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_SELECTED, false);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_SELECTED,false);
      //--- オブジェクトリストのグラフィックオブジェクトを非表示（true）か表示（false）にする
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_HIDDEN, true);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_HIDDEN,true);
      //--- チャートのマウスクリックのイベントを受信するための優先順位を設定する
      ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_ZORDER,-1);
      ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_ZORDER,0);
      ObjectSetInteger(0,LABEL_CANDLETIME_NAME,  OBJPROP_ZORDER,-1);

      if(horizon_label_flg){
         ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      }else{
         ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      }
      if(horizon_set_flg==1){
         ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_TP_NAME,        OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_SL_NAME,        OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_ENTRY_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_TP_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_SL_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         if(horizon_label_flg){
            ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
            ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
            ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
            ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         }else{
            ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
            ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
            ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
            ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         }
      }else{
         ObjectSetInteger(0, HLINE_TP_NAME,        OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, HLINE_SL_NAME,        OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, HLINE_ENTRY_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, HLINE_TP_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, HLINE_SL_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      }

      

//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Create the "PositionButtons"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::CreateAndUpdatePositionObjects(void)
{
   if(ArraySize(position_label_ys)>0) ArrayRemove(position_label_ys, 0, ArraySize(position_label_ys));
   if(horizon_set_flg==1){
      // ポジションラベルを削除する
      if(ArraySize(position_tickets)>0){
         ArrayRemove(position_tickets, 0, ArraySize(position_tickets));
         ObjectsDeleteAll(
            0,  // チャート識別子
            POSITION_NAME_PREFIX,  // オブジェクト名のプレフィックス
            -1,  // ウィンドウ番号
            -1   // オブジェクトの型
         );
      }
      if(ArraySize(position_tps)>0){
         ArrayRemove(position_tps, 0, ArraySize(position_tps));
         ObjectsDeleteAll(
            0,  // チャート識別子
            POSITION_TP_NAME_PREFIX,  // オブジェクト名のプレフィックス
            -1,  // ウィンドウ番号
            -1   // オブジェクトの型
         );
      }
      if(ArraySize(position_sls)>0){
         ArrayRemove(position_sls, 0, ArraySize(position_sls));
         ObjectsDeleteAll(
            0,  // チャート識別子
            POSITION_SL_NAME_PREFIX,  // オブジェクト名のプレフィックス
            -1,  // ウィンドウ番号
            -1   // オブジェクトの型
         );
      }
      if(ArraySize(order_tickets)>0){
         ArrayRemove(order_tickets, 0, ArraySize(order_tickets));
         ObjectsDeleteAll(
            0,  // チャート識別子
            POSITION_ORDER_NAME_PREFIX,  // オブジェクト名のプレフィックス
            -1,  // ウィンドウ番号
            -1   // オブジェクトの型
         );
      }
      // ポジションメニューを削除する
      ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
      ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
      HideAll(POSITION_MENU_NAME_PREFIX);
   }else{
      // 不要なobjectを削除する
      int totalTp = ArraySize(position_tps);
      for(int i = totalTp-1; i >= 0; i--){
         if(!m_position.SelectByTicket(position_tps[i])){
            if(DeletePositionTpObject(position_tps[i])){
               ArrayRemove(position_tps, i, 1);
            }
         }else if(!(m_position.TakeProfit() > 0)){
            if(DeletePositionTpObject(position_tps[i])){
               ArrayRemove(position_tps, i, 1);
            }
         }
      }
      int totalSl = ArraySize(position_sls);
      for(int i = totalSl-1; i >= 0; i--){
         if(!m_position.SelectByTicket(position_sls[i])){
            if(DeletePositionSlObject(position_sls[i])){
               ArrayRemove(position_sls, i, 1);
            }
         }else if(!(m_position.StopLoss() > 0)){
            if(DeletePositionSlObject(position_sls[i])){
               ArrayRemove(position_sls, i, 1);
            }
         }
      }
      int totalOrder = ArraySize(order_tickets);
      for(int i = totalOrder-1; i >= 0; i--){
         if(!m_order.Select(order_tickets[i])){
            if(DeleteOrderObject(order_tickets[i])){
               ArrayRemove(order_tickets, i, 1);
            }
         }
      }
      int total = ArraySize(position_tickets);
      for(int i = total-1; i >= 0; i--){
         if(!m_position.SelectByTicket(position_tickets[i])){
            if(DeletePositionObject(position_tickets[i])){
               ArrayRemove(position_tickets, i, 1);
            }
         }
      }
      // 新しいobjectsを作成する
      totalTp = ArraySize(position_tps);
      totalSl = ArraySize(position_sls);
      totalOrder = ArraySize(order_tickets);
      total = ArraySize(position_tickets);
      for(int i=OrdersTotal()-1;i>=0;i--){
         if(m_order.Symbol()==Symbol()){
            if(m_order.SelectByIndex(i)){
               int ticket = m_order.Ticket();
               totalOrder = ArraySize(order_tickets);
               bool findFlg = false;
               for(int j = totalOrder-1; j >= 0; j--){
                  if(ticket == order_tickets[j]){
                     findFlg = true;
                     break;
                  }
               }
               if(!findFlg){
                  if(CreateOrderObject(ticket)){
                     ArrayResize(order_tickets, ArraySize(order_tickets)+1);
                     order_tickets[totalOrder] = ticket;
                     totalOrder++;
                  }
               }else{
                  MoveOrderObject(ticket);
               }
            }
         }
      }
      for(int i=PositionsTotal()-1;i>=0;i--){
         if(m_position.SelectByIndex(i)){
            if(m_position.Symbol()==Symbol()){
               int ticket = m_position.Ticket();
               total = ArraySize(position_tickets);
               bool findFlg = false;
               bool findTpFlg = 0;  // 0=不要、1=作成、2=移動
               bool findSlFlg = 0;  // 0=不要、1=作成、2=移動
               for(int j = total-1; j >= 0; j--){
                  if(ticket == position_tickets[j]){
                     findFlg = true;
                     break;
                  }
               }
               if(m_position.TakeProfit() > 0){
                  findTpFlg = 1;
                  for(int j = totalTp-1; j >= 0; j--){
                     if(ticket == position_tps[j]){
                        findTpFlg = 2;
                        break;
                     }
                  }
               }
               if(m_position.StopLoss() > 0){
                  findSlFlg = 1;
                  for(int j = totalSl-1; j >= 0; j--){
                     if(ticket == position_sls[j]){
                        findSlFlg = 2;
                        break;
                     }
                  }
               }
               if(!findFlg){
                  if(CreatePositionObject(ticket)){
                     ArrayResize(position_tickets, ArraySize(position_tickets)+1);
                     position_tickets[total] = ticket;
                     total++;
                  }
               }else{
                  MovePositionObject(ticket);
               }
               if(findTpFlg==1){
                  if(CreatePositionTpObject(ticket)){
                     ArrayResize(position_tps, ArraySize(position_tps)+1);
                     position_tps[totalTp] = ticket;
                     totalTp++;
                  }
               }else if(findTpFlg==2){
                  MovePositionTpObject(ticket);
               }
               if(findSlFlg==1){
                  if(CreatePositionSlObject(ticket)){
                     ArrayResize(position_sls, ArraySize(position_sls)+1);
                     position_sls[totalSl] = ticket;
                     totalSl++;
                  }
               }else if(findSlFlg==2){
                  MovePositionSlObject(ticket);
               }
            }
         }
      }
   }
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::CreatePositionObject(int tickt)
{
   string button_name = POSITION_NAME_PREFIX + "_button_" + IntegerToString(tickt);
   string label_name = POSITION_NAME_PREFIX + "_label_" + IntegerToString(tickt);
   double price = m_position.PriceOpen();
   double volume = m_position.Volume();
   string side = "Buy";
   if(m_position.PositionType() == POSITION_TYPE_SELL)
      side = "Sell";
   ENUM_POSITION_TYPE type = m_position.PositionType();  // POSITION_TYPE_BUY or POSITION_TYPE_SELL
   double profit = m_position.Profit();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   if(!ObjectCreate(0,button_name,     OBJ_EDIT,0,0,0) || !ObjectCreate(0,label_name,     OBJ_EDIT,0,0,0))
   {
      Print(__FUNCTION__,
            ": failed to create text label! Error code = ",GetLastError());
      return(false);
   }
   int widthScreen=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   ObjectSetInteger(0,button_name,     OBJPROP_XSIZE,        POSITION_LABEL1_WIDTH);
   ObjectSetInteger(0,button_name,     OBJPROP_YSIZE,        POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH + widthScreen/2);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_CORNER,       CORNER_RIGHT_UPPER);
   ObjectSetString(0,button_name,      OBJPROP_TEXT,         "...");
   ObjectSetString(0,button_name,      OBJPROP_FONT,         main_Font);
   ObjectSetInteger(0,button_name,     OBJPROP_FONTSIZE,     line_FontSize);
   ObjectSetInteger(0,button_name,     OBJPROP_COLOR,        position_line_button_text_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BGCOLOR,      position_line_button_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BORDER_COLOR, position_line_button_border_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BACK,         false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTED,     false);
   ObjectSetInteger(0,button_name,     OBJPROP_READONLY,     true);
   ObjectSetInteger(0,button_name,     OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0,button_name,     OBJPROP_ZORDER,       -1);
   ObjectSetInteger(0, button_name,    OBJPROP_TIMEFRAMES,   OBJ_ALL_PERIODS);
   ObjectSetInteger(0,label_name,     OBJPROP_XSIZE,        POSITION_LABEL2_WIDTH);
   ObjectSetInteger(0,label_name,     OBJPROP_YSIZE,        POSITION_LABEL2_HEIGHT);
   ObjectSetInteger(0,label_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH + POSITION_LABEL2_WIDTH + 1 + widthScreen/2);
   ObjectSetInteger(0,label_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,label_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,label_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,label_name,     OBJPROP_CORNER,       CORNER_RIGHT_UPPER);
   ObjectSetString(0,label_name,      OBJPROP_TEXT,         side + " | " + DoubleToString(volume, 2) + " | " + DoubleToString(profit, 2) + " " + currency);
   ObjectSetString(0,label_name,      OBJPROP_FONT,         main_Font);
   ObjectSetInteger(0,label_name,     OBJPROP_FONTSIZE,     line_FontSize);
   ObjectSetInteger(0,label_name,     OBJPROP_COLOR,        position_line_text_color);
   ObjectSetInteger(0,label_name,     OBJPROP_BGCOLOR,      position_line_color);
   ObjectSetInteger(0,label_name,     OBJPROP_BORDER_COLOR, position_line_color);
   ObjectSetInteger(0,label_name,     OBJPROP_BACK,         false);
   ObjectSetInteger(0,label_name,     OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0,label_name,     OBJPROP_SELECTED,     false);
   ObjectSetInteger(0,label_name,     OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0,label_name,     OBJPROP_ZORDER,       -1);
   ObjectSetInteger(0, label_name,    OBJPROP_TIMEFRAMES,   OBJ_ALL_PERIODS);

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::CreatePositionTpObject(int tickt)
{
   string button_name = POSITION_TP_NAME_PREFIX + IntegerToString(tickt);
   double price = m_position.TakeProfit();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   if(!ObjectCreate(0,button_name,     OBJ_EDIT,0,0,0))
   {
      Print(__FUNCTION__,
            ": failed to create button! Error code = ",GetLastError());
      return(false);
   }
   ObjectSetInteger(0,button_name,     OBJPROP_XSIZE,        POSITION_LABEL1_WIDTH);
   ObjectSetInteger(0,button_name,     OBJPROP_YSIZE,        POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_CORNER,       CORNER_RIGHT_UPPER);
   ObjectSetString(0,button_name,      OBJPROP_TEXT,         "×");
   ObjectSetString(0,button_name,      OBJPROP_FONT,         main_Font);
   ObjectSetInteger(0,button_name,     OBJPROP_FONTSIZE,     line_FontSize);
   ObjectSetInteger(0,button_name,     OBJPROP_COLOR,        position_line_tp_button_text_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BGCOLOR,      position_line_tp_button_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BORDER_COLOR, position_line_tp_button_border_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BACK,         false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTED,     false);
   ObjectSetInteger(0,button_name,     OBJPROP_READONLY,     true);
   ObjectSetInteger(0,button_name,     OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0,button_name,     OBJPROP_ZORDER,       -1);
   ObjectSetInteger(0, button_name,    OBJPROP_TIMEFRAMES,   OBJ_ALL_PERIODS);

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::CreatePositionSlObject(int tickt)
{
   string button_name = POSITION_SL_NAME_PREFIX + IntegerToString(tickt);
   double price = m_position.StopLoss();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   if(!ObjectCreate(0,button_name,     OBJ_EDIT,0,0,0))
   {
      Print(__FUNCTION__,
            ": failed to create button! Error code = ",GetLastError());
      return(false);
   }
   ObjectSetInteger(0,button_name,     OBJPROP_XSIZE,        POSITION_LABEL1_WIDTH);
   ObjectSetInteger(0,button_name,     OBJPROP_YSIZE,        POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_CORNER,       CORNER_RIGHT_UPPER);
   ObjectSetString(0,button_name,      OBJPROP_TEXT,         "×");
   ObjectSetString(0,button_name,      OBJPROP_FONT,         main_Font);
   ObjectSetInteger(0,button_name,     OBJPROP_FONTSIZE,     line_FontSize);
   ObjectSetInteger(0,button_name,     OBJPROP_COLOR,        position_line_sl_button_text_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BGCOLOR,      position_line_sl_button_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BORDER_COLOR, position_line_sl_button_border_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BACK,         false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTED,     false);
   ObjectSetInteger(0,button_name,     OBJPROP_READONLY,     true);
   ObjectSetInteger(0,button_name,     OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0,button_name,     OBJPROP_ZORDER,       -1);
   ObjectSetInteger(0, button_name,    OBJPROP_TIMEFRAMES,   OBJ_ALL_PERIODS);

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::CreateOrderObject(int tickt)
{
   string button_name = POSITION_ORDER_NAME_PREFIX + IntegerToString(tickt);
   double price = m_order.PriceOpen();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   if(!ObjectCreate(0,button_name,     OBJ_EDIT,0,0,0))
   {
      Print(__FUNCTION__,
            ": failed to create button! Error code = ",GetLastError());
      return(false);
   }
   ObjectSetInteger(0,button_name,     OBJPROP_XSIZE,        POSITION_LABEL1_WIDTH);
   ObjectSetInteger(0,button_name,     OBJPROP_YSIZE,        POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,button_name,     OBJPROP_ALIGN,        ALIGN_CENTER);
   ObjectSetInteger(0,button_name,     OBJPROP_CORNER,       CORNER_RIGHT_UPPER);
   ObjectSetString(0,button_name,      OBJPROP_TEXT,         "×");
   ObjectSetString(0,button_name,      OBJPROP_FONT,         main_Font);
   ObjectSetInteger(0,button_name,     OBJPROP_FONTSIZE,     line_FontSize);
   ObjectSetInteger(0,button_name,     OBJPROP_COLOR,        position_line_order_button_text_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BGCOLOR,      position_line_order_button_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BORDER_COLOR, position_line_order_button_border_color);
   ObjectSetInteger(0,button_name,     OBJPROP_BACK,         false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0,button_name,     OBJPROP_SELECTED,     false);
   ObjectSetInteger(0,button_name,     OBJPROP_READONLY,     true);
   ObjectSetInteger(0,button_name,     OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0,button_name,     OBJPROP_ZORDER,       -1);
   ObjectSetInteger(0, button_name,    OBJPROP_TIMEFRAMES,   OBJ_ALL_PERIODS);

   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::DeletePositionObject(int tickt)
{
   string button_name = POSITION_NAME_PREFIX + "_button_" + IntegerToString(tickt);
   string label_name = POSITION_NAME_PREFIX + "_label_" + IntegerToString(tickt);
   if(!ObjectDelete(0,label_name) || !ObjectDelete(0,button_name))
   {
      Print(__FUNCTION__,
            ": failed to delete text label! Error code = ",GetLastError());
      return(false);
   }
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::DeletePositionTpObject(int tickt)
{
   string button_name = POSITION_TP_NAME_PREFIX + IntegerToString(tickt);
   if(!ObjectDelete(0,button_name))
   {
      Print(__FUNCTION__,
            ": failed to delete button! Error code = ",GetLastError());
      return(false);
   }
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::DeletePositionSlObject(int tickt)
{
   string button_name = POSITION_SL_NAME_PREFIX + IntegerToString(tickt);
   if(!ObjectDelete(0,button_name))
   {
      Print(__FUNCTION__,
            ": failed to delete button! Error code = ",GetLastError());
      return(false);
   }
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::DeleteOrderObject(int tickt)
{
   string button_name = POSITION_ORDER_NAME_PREFIX + IntegerToString(tickt);
   if(!ObjectDelete(0,button_name))
   {
      Print(__FUNCTION__,
            ": failed to delete button! Error code = ",GetLastError());
      return(false);
   }
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::MovePositionObject(int tickt)
{
   string button_name = POSITION_NAME_PREFIX + "_button_" + IntegerToString(tickt);
   string label_name = POSITION_NAME_PREFIX + "_label_" + IntegerToString(tickt);
   double price = m_position.PriceOpen();
   double volume = m_position.Volume();
   string side = "Buy";
   if(m_position.PositionType() == POSITION_TYPE_SELL)
      side = "Sell";
   ENUM_POSITION_TYPE type = m_position.PositionType();  // POSITION_TYPE_BUY or POSITION_TYPE_SELL
   double profit = m_position.Profit();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   int widthScreen=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH + widthScreen/2);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);   
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0,label_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH + POSITION_LABEL2_WIDTH + 1 + widthScreen/2);
   ObjectSetInteger(0,label_name,     OBJPROP_YDISTANCE,    y);
   ObjectSetString(0,label_name,      OBJPROP_TEXT,         side + " | " + DoubleToString(volume, 2) + " | " + DoubleToString(profit, 2) + " " + currency);
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::MovePositionTpObject(int tickt)
{
   string button_name = POSITION_TP_NAME_PREFIX + IntegerToString(tickt);
   double price = m_position.TakeProfit();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::MovePositionSlObject(int tickt)
{
   string button_name = POSITION_SL_NAME_PREFIX + IntegerToString(tickt);
   double price = m_position.StopLoss();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   //--- succeed
   return(true);
}
bool CAppWindowSelTradingTool::MoveOrderObject(int tickt)
{
   string button_name = POSITION_ORDER_NAME_PREFIX + IntegerToString(tickt);
   double price = m_order.PriceOpen();
   int x, y;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, price, x, y);
   ObjectSetInteger(0,button_name,     OBJPROP_XDISTANCE,    POSITION_LABEL1_WIDTH);
   y = getNonDuplicateY(y, POSITION_LABEL1_HEIGHT);
   ObjectSetInteger(0,button_name,     OBJPROP_YDISTANCE,    y);
   //--- succeed
   return(true);
}

void CAppWindowSelTradingTool::ShowPositionStopInfo(ulong tickt)
  {
   bool maTpSlSet=false;   
   bool trailingStopSet=false;
   
   for(int i=0;i<ArraySize(_positionMAStopSets);i++)
     {
      if(_positionMAStopSets[i].ticket==tickt)
        {
         string text="";
         if(_positionMAStopSets[i].maTpFlg)
           {
            text+=tf2str(_positionMAStopSets[i].timeframe)+", TP MA"+IntegerToString(_positionMAStopSets[i].maTpPeriod)+" ON";
           }
         if(_positionMAStopSets[i].maSlFlg)
           {
            if(_positionMAStopSets[i].maTpFlg)
               text+=", ";
            else
               text+=tf2str(_positionMAStopSets[i].timeframe)+", ";
                  
            text+="SL MA"+IntegerToString(_positionMAStopSets[i].maSlPeriod)+" ON";
           }
         if(_positionMAStopSets[i].maTpFlg ||
            _positionMAStopSets[i].maSlFlg)
           {  
            ObjectSetString(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TEXT,text);
            maTpSlSet=true;
           }
         break;
        }
     }
   if(maTpSlSet)
      ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
   else
      ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   
   ObjectSetString(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TEXT,"");
   for(int i=0;i<ArraySize(_positionTrailingStopSets);i++)
     {
      if(_positionTrailingStopSets[i].ticket==tickt)
        {
         ObjectSetString(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TEXT,"自動SL建値 "+DoubleToString(_positionTrailingStopSets[i].targetPips,1)+"Pips ON");
         trailingStopSet=true;
         break;
        }
     } 
   if(trailingStopSet)
      ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_ALL_PERIODS);
   else
      ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
  }
//+------------------------------------------------------------------+
//| Destoroy the "Button1"                                             |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::HideAll(string prefix)
  {
//---
   int total=ExtDialog.ControlsTotal();
   // CWndClient*myclient;
   for(int i=0;i<total;i++)
   {
      CWnd*obj=ExtDialog.Control(i);
      string name=obj.Name();
      // PrintFormat("%d is %s",i,name);
      if(StringFind(name,"Client")>0)
      {
         CWndClient *client=(CWndClient*)obj;
         int client_total=client.ControlsTotal();
         for(int j=0;j<client_total;j++)
         {
            CWnd*client_obj=client.Control(j);
            string client_name=client_obj.Name();
            if(StringFind(client_name,prefix)==0)
            {
               client_obj.Hide();
               client_obj.Move(-2000, -2000);
            }
         }
      }
   }
//--- succeed
   return(true);
  }

//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CAppWindowSelTradingTool::OnClickBg(void)
{
   Print("OnClickBg");
   if(bg_set_flg==1){
      bg_set_flg=0;
      ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   }else{
      bg_set_flg=1;
      ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   }
   ReDraw();
}
void CAppWindowSelTradingTool::OnClickReset(void)
{
   Print("OnClickReset");
   m_common_button_reset.Locking(false);
   m_common_button_reset.Pressed(false);
   ep = latest_price.ask;
   ObjectSetDouble(0,HLINE_ENTRY_NAME,OBJPROP_PRICE,ep);
   long stoplevel;
   if(!SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL, stoplevel))
   {
      Alert("Error getting the stoplevel - error:",GetLastError(),"!!");
      ResetLastError();
      return ;
   }
   tp = NormalizeDouble(ep + (stoplevel * _Point), _Digits);
   ObjectSetDouble(0,HLINE_TP_NAME,OBJPROP_PRICE,tp);
   sl = NormalizeDouble(ep - (stoplevel * _Point), _Digits);
   ObjectSetDouble(0,HLINE_SL_NAME,OBJPROP_PRICE,sl);

   ReDraw();
}
void CAppWindowSelTradingTool::OnClickGraph(void)
{
   Print("OnClickGraph");   
   if(!CreateGraphPanel())
      return ;
}
void CAppWindowSelTradingTool::OnClickMenuMarket(void)
  {
   Print("OnClickMenuMarket");
   if(!CreateMarket())
      return ;
  }
void CAppWindowSelTradingTool::OnClickMenuLimit(void)
  {
   Print("OnClickMenuLimit");
   if(!CreateLimit())
      return ;
  }
void CAppWindowSelTradingTool::OnClickMenuStopLimit(void)
  {
   Print("OnClickMenuStopLimit");
   if(!CreateStopLimit())
      return ;
  }
void CAppWindowSelTradingTool::OnClickMenuInfo(void)
  {
   Print("OnClickMenuInfo");
   if(!CreateInfo())
      return ;
  }
void CAppWindowSelTradingTool::OnClickMenuSymbol(void)
  {
   Print("OnClickMenuSymbol");
   if(!CreateSymbolPopupMenu())
      return ;
  }
void CAppWindowSelTradingTool::OnClickPopupMenuSymbol(const long& lparam,const double& dparam,const string& sparam)
{
   string strCurrency = ObjectGetString(0, sparam, OBJPROP_TEXT);
   
   Print("OnClickPopupMenuSymbol, Currency = " + strCurrency);         
   if(StringFind(sparam, "m_menu_symbol") != -1){            
      ChartSetSymbolPeriod(ChartID(), strCurrency, PERIOD_CURRENT);
   }
}
void CAppWindowSelTradingTool::OnClickAsk(void)
{
   Print("OnClickAsk");
   double price, sl=0, tp=0;
   MqlTradeRequest request;
   MqlTradeCheckResult result;
   ZeroMemory(request);     // Initialization of request structure
   ZeroMemory(result);     // Initialization of request structure
   // モードと設定に合わせたリクエスト構造体を作成
   request = CreateBuyRequest();
   // 注文可能かチェック＆注文
   if(!OrderCheck(request, result)){
      Print("OrderCheck Error: ", result.retcode, " ", result.comment);
      Print(request.sl, ", ", request.tp);
      return ;
   }
   // 1=成行、2=指値、3=逆指、4=決済
   switch(trade_mode)
   {
      case 1:
         if(!m_trade.Buy(
            request.volume,
            request.symbol,
            request.price,
            request.sl,
            request.tp,
            ""
         )){
            Print("m_trade.Buy Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
      case 2:
         if(!m_trade.BuyLimit(
            request.volume,
            request.price,
            request.symbol,
            request.sl,
            request.tp,
            ORDER_TIME_GTC,
            0,
            ""
         )){
            Print("m_trade.BuyLimit Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
      case 3:
         if(!m_trade.BuyStop(
            request.volume,
            request.price,
            request.symbol,
            request.sl,
            request.tp,
            ORDER_TIME_GTC,
            0,
            ""
         )){
            Print("m_trade.BuyStop Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
   }
   if(horizon_set_flg==1){
      OnClickHorizon();
   }else
      ReDraw();
}
void CAppWindowSelTradingTool::OnClickBid(void)
{
   Print("OnClickBid");
   double price, sl=0, tp=0;
   MqlTradeRequest request;
   MqlTradeCheckResult result;
   ZeroMemory(request);     // Initialization of request structure
   ZeroMemory(result);     // Initialization of request structure
   // モードと設定に合わせたリクエスト構造体を作成
   request = CreateSellRequest();
   // 注文可能かチェック＆注文
   if(!OrderCheck(request, result)){
      Print("OrderCheck Error: ", result.retcode, " ", result.comment);
      return ;
   }
   // 1=成行、2=指値、3=逆指、4=決済
   switch(trade_mode)
   {
      case 1:
         if(!m_trade.Sell(
            request.volume,
            request.symbol,
            request.price,
            request.sl,
            request.tp,
            ""
         )){
            Print("m_trade.Sell Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
      case 2:
         if(!m_trade.SellLimit(
            request.volume,
            request.price,
            request.symbol,
            request.sl,
            request.tp,
            ORDER_TIME_GTC,
            0,
            ""
         )){
            Print("m_trade.SellLimit Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
      case 3:
         if(!m_trade.SellStop(
            request.volume,
            request.price,
            request.symbol,
            request.sl,
            request.tp,
            ORDER_TIME_GTC,
            0,
            ""
         )){
            Print("m_trade.SellStop Error: ", GetLastError());
            ResetLastError();
            return;
         }
         break;
   }
   if(horizon_set_flg==1){
      OnClickHorizon();
   }else
      ReDraw();
}
void CAppWindowSelTradingTool::OnClickAuto(void)
{
   Print("OnClickAuto");
   auto_manual_flg=1;
   ReDraw();
}
void CAppWindowSelTradingTool::OnClickManual(void)
{
   Print("OnClickManual");
   auto_manual_flg=0;
   ReDraw();
}
void CAppWindowSelTradingTool::OnClickTpAuto(void)
{
   Print("OnClickTpAuto");
   if(tp_set_flg==1){
      tp_set_flg=0;
   }else{
      tp_set_flg=1;
   }
   ReDraw();
}
void CAppWindowSelTradingTool::OnClickSlAuto(void)
{
   Print("OnClickSlAuto");
   if(sl_set_flg==1){
      sl_set_flg=0;
   }else{
      sl_set_flg=1;
   }
   ReDraw();
}
void CAppWindowSelTradingTool::OnClickHorizon(void)
{
   Print("OnClickHorizon");
   if(horizon_set_flg==1){
      horizon_set_flg=0;
      ep = latest_price.ask;
      ObjectSetDouble(0,HLINE_ENTRY_NAME,OBJPROP_PRICE,ep);
      long stoplevel;
      if(SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL, stoplevel)) {
         tp = NormalizeDouble(ep + (stoplevel * _Point), _Digits);
         ObjectSetDouble(0,HLINE_TP_NAME,OBJPROP_PRICE,tp);   
         sl = NormalizeDouble(ep - (stoplevel * _Point), _Digits);
         ObjectSetDouble(0,HLINE_SL_NAME,OBJPROP_PRICE,sl);
      }
      else {         
         Alert("Error getting the stoplevel - error:",GetLastError(),"!!");
         ResetLastError();
      }
      
      ObjectSetInteger(0, HLINE_TP_NAME,        OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, HLINE_SL_NAME,        OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, HLINE_ENTRY_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, HLINE_TP_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, HLINE_SL_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   }else{
      horizon_set_flg=1;
      ObjectSetInteger(0, RECTANGLE_TP_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, RECTANGLE_SL_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_TP_NAME,        OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_SL_NAME,        OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_ENTRY_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_TP_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_SL_SHADOW_NAME, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      if(horizon_label_flg){
         ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
         ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      }else{
         ObjectSetInteger(0, LABEL_TP1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_SL1_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_ENTRY1_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
         ObjectSetInteger(0, LABEL_REVERSE_ICON_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      }
      // 再表示でドラッグできなくなったので、再設定する
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTABLE,true);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,HLINE_TP_NAME,   OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_SL_NAME,   OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_ENTRY_NAME,OBJPROP_SELECTED,true);
      ObjectSetInteger(0,HLINE_TP_SHADOW_NAME,   OBJPROP_SELECTED,false);
      ObjectSetInteger(0,HLINE_SL_SHADOW_NAME,   OBJPROP_SELECTED,false);
      ObjectSetInteger(0,HLINE_ENTRY_SHADOW_NAME,OBJPROP_SELECTED,false);
      // 再表示で注文ツールよりも上になってしまうので、一瞬非表示にして戻す
      HideAll("m_");
      my_back.Hide();
      my_border.Hide();
      my_client.Hide();
      my_caption.Hide();
      my_minmaxbtn.Hide();
      my_closebtn.Hide();
      my_back.Show();
      my_border.Show();
      my_client.Show();
      my_caption.Show();
      my_minmaxbtn.Show();
      my_closebtn.Show();
      switch(trade_mode){
         case 1:
            CreateMarket();
            break;
         case 2:
            CreateLimit();
            break;
         case 3:
            CreateStopLimit();
            break;
         default:
            CreateMarket();
            break;
            
      }
      if(position_panel_set_flg==1){
         HideAll(SUB_NAME_PREFIX);
         CreateSub();
      }
   }
   ReDraw();
   //CreateAndUpdatePositionObjects();
}

void CAppWindowSelTradingTool::OnClickAlerm(void)
{
   Print("OnClickAlerm");
   if(alerm_set_flg==1){
      alerm_set_flg=0;
   }else{
      alerm_set_flg=1;
      last_line_fix_time = GetTickCount();
   }
   ReDraw();
}

void CAppWindowSelTradingTool::OnEndEditLot(void)
{
   Print("OnEndEditLot");
   Lot = NormalizeDouble(StringToDouble(m_common_lot.Text()), 2);
   CalcInfo();
}

void CAppWindowSelTradingTool::OnEndEditRisk(void)
{
   Print("OnEndEditRisk");
   MaxLossMarginPercent = StringToDouble(m_common_risk.Text());
   CalcInfo();
}

void CAppWindowSelTradingTool::OnClickRiskUp(void)
{
   Print("OnClickRiskUp");
   MaxLossMarginPercent = StringToDouble(m_common_risk.Text())+1;
   m_common_risk.Text(DoubleToString(MaxLossMarginPercent,1));
   CalcInfo();
}

void CAppWindowSelTradingTool::OnClickRiskDown(void)
{
   Print("OnClickRiskDown");
   MaxLossMarginPercent = StringToDouble(m_common_risk.Text())-1;
   m_common_risk.Text(DoubleToString(MaxLossMarginPercent,1));
   CalcInfo();
}

void CAppWindowSelTradingTool::OnEndEditPercent(void)
{
   Print("OnEndEditPercent");
   ExitPercent = StringToInteger(m_position_edit_percent.Text());
   if(ExitPercent < 0) ExitPercent = 0;
   if(ExitPercent > 100) ExitPercent = 100;
   m_position_edit_percent.Text(IntegerToString(ExitPercent));
}

void CAppWindowSelTradingTool::OnClickPercentUp10(void)
{
   Print("OnClickPercentUp10");
   ExitPercent = StringToInteger(m_position_edit_percent.Text())+10;
   if(ExitPercent < 0) ExitPercent = 0;
   if(ExitPercent > 100) ExitPercent = 100;
   m_position_edit_percent.Text(IntegerToString(ExitPercent));
}

void CAppWindowSelTradingTool::OnClickPercentUp(void)
{
   Print("OnClickPercentUp");
   ExitPercent = StringToInteger(m_position_edit_percent.Text())+1;
   if(ExitPercent < 0) ExitPercent = 0;
   if(ExitPercent > 100) ExitPercent = 100;
   m_position_edit_percent.Text(IntegerToString(ExitPercent));
}

void CAppWindowSelTradingTool::OnClickPercentDown(void)
{
   Print("OnClickPercentDown");
   ExitPercent = StringToInteger(m_position_edit_percent.Text())-1;
   if(ExitPercent < 0) ExitPercent = 0;
   if(ExitPercent > 100) ExitPercent = 100;
   m_position_edit_percent.Text(IntegerToString(ExitPercent));
}

void CAppWindowSelTradingTool::OnClickPercentDown10(void)
{
   Print("OnClickPercentDown10");
   ExitPercent = StringToInteger(m_position_edit_percent.Text())-10;
   if(ExitPercent < 0) ExitPercent = 0;
   if(ExitPercent > 100) ExitPercent = 100;
   m_position_edit_percent.Text(IntegerToString(ExitPercent));
}

// void CAppWindowSelTradingTool::OnPositionMenuCloseFocus(void)
// {
//    Print("OnPositionMenuCloseFocus");
//    m_position_menu_main_close.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuCloseFocusOut(void)
// {
//    Print("OnPositionMenuCloseFocusOut");
//    m_position_menu_main_close.ColorBackground(position_menu_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuExitFocus(void)
// {
//    Print("OnPositionMenuExitFocus");
//    m_position_menu_main_exit.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuExitFocusOut(void)
// {
//    Print("OnPositionMenuExitFocusOut");
//    m_position_menu_main_exit.ColorBackground(position_menu_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuDotenFocus(void)
// {
//    Print("OnPositionMenuDotenFocus");
//    m_position_menu_main_doten.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuDotenFocusOut(void)
// {
//    Print("OnPositionMenuDotenFocusOut");
//    m_position_menu_main_doten.ColorBackground(position_menu_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuPercentMenuFocus(void)
// {
//    Print("OnPositionMenuPercentMenuFocus");
//    m_position_menu_main_percent_exit.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuPercentMenuFocusOut(void)
// {
//    Print("OnPositionMenuPercentMenuFocusOut");
//    m_position_menu_main_percent_exit.ColorBackground(position_menu_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuSlTateneFocus(void)
// {
//    Print("OnPositionMenuSlTateneFocus");
//    m_position_menu_main_sltatene.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuSlTateneFocusOut(void)
// {
//    Print("OnPositionMenuSlTateneFocusOut");
//    m_position_menu_main_sltatene.ColorBackground(position_menu_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuTpSlMenuFocus(void)
// {
//    Print("OnPositionMenuTpSlMenuFocus");
//    m_position_menu_main_tpsl.ColorBackground(position_menu_active_ColorBackground);
// }

// void CAppWindowSelTradingTool::OnPositionMenuTpSlMenuFocusOut(void)
// {
//    Print("OnPositionMenuTpSlMenuFocusOut");
//    m_position_menu_main_tpsl.ColorBackground(position_menu_ColorBackground);
// }

void CAppWindowSelTradingTool::OnPositionMenuClose(void)
{
   Print("OnPositionMenuClose");
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnPositionMenuExit(void)
{
   Print("OnPositionMenuExit");
   if(m_position.SelectByTicket(open_menu_position_ticket)) // selects the position by index for further access to its properties
      m_trade.PositionClose(m_position.Ticket());
   CalcInfo();
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnPositionMenuDoten(void)
{
   Print("OnPositionMenuDoten");
   if(m_position.SelectByTicket(open_menu_position_ticket)){ // selects the position by index for further access to its properties
      double volume = m_position.Volume();
      ENUM_POSITION_TYPE type = m_position.PositionType();
      if(!m_trade.PositionClose(m_position.Ticket())){
         Print("m_trade.PositionClose Error: ", GetLastError());
         ResetLastError();
      }else{
         if(type == POSITION_TYPE_SELL){
            if(!m_trade.Buy(
               volume,
               _Symbol,
               NormalizeDouble(latest_price.ask,_Digits),
               0,
               0,
               ""
            )){
               Print("m_trade.Buy Error: ", GetLastError());
               ResetLastError();
            }
         }else{
            if(!m_trade.Sell(
               volume,
               _Symbol,
               NormalizeDouble(latest_price.bid,_Digits),
               0,
               0,
               ""
            )){
               Print("m_trade.Sell Error: ", GetLastError());
               ResetLastError();
            }
         }
      }
   }
   CalcInfo();
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnPositionMenuSlTatene(void)
{
   Print("OnPositionMenuSlTatene");
   if(m_position.SelectByTicket(open_menu_position_ticket)){ // selects the position by index for further access to its properties
      MqlTradeRequest request;
      MqlTradeResult  result;
      MqlTradeCheckResult chkresult;
      ZeroMemory(request);
      ZeroMemory(result);
      ZeroMemory(chkresult);
      //--- 操作パラメータの設定
      request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
      request.position=m_position.Ticket();   // ポジションシンボル
      request.symbol=m_position.Symbol();     // シンボル
      request.sl      =m_position.PriceOpen();               // ポジションのStop Loss
      request.tp      =m_position.TakeProfit();               // ポジションのTake Profit
      //--- 変更情報の出力
      PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
      //--- 変更できるかチェック
      if(!OrderCheck(request, chkresult)){
         Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
      }
      //--- リクエストの送信
      if(!OrderSend(request,result))
         PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
      //--- 操作情報 
      PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
   }
   CalcInfo();
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnPositionMenuPercentExitMenu(void)
{
   Print("OnPositionMenuPercentExitMenu");
   // 既に開いていたら閉じる
   if(m_position_menu_sub_percent_input.IsVisible()){
      // percent exit設定をどかす
      m_position_menu_sub_percent_label.Hide();
      m_position_menu_sub_percent_label.Move(-2000, -2000);
      m_position_menu_sub_percent_input.Hide();
      m_position_menu_sub_percent_input.Move(-2000, -2000);
      m_position_menu_sub_percent_exit.Hide();
      m_position_menu_sub_percent_exit.Move(-2000, -2000);
      // サブパネルどかす
      m_position_menu_sub_panel.Hide();
      m_position_menu_sub_panel.Move(-2000, -2000);
      // 色を変える
      m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
      m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
      return;
   }
   // ts設定をどかす
   m_position_menu_sub_trailingstop_chk.Hide();
   m_position_menu_sub_trailingstop_chk.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_targetpips.Hide();
   m_position_menu_sub_trailingstop_targetpips.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_set.Hide();
   m_position_menu_sub_trailingstop_set.Move(-2000, -2000);
   // tpsl設定をどかす
   m_position_menu_sub_tp_label.Hide();
   m_position_menu_sub_tp_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_tp_input.Hide();
   m_position_menu_sub_tpsl_tp_input.Move(-2000, -2000);
   m_position_menu_sub_sl_label.Hide();
   m_position_menu_sub_sl_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_sl_input.Hide();
   m_position_menu_sub_tpsl_sl_input.Move(-2000, -2000);
   m_position_menu_sub_tpsl_set.Hide();
   m_position_menu_sub_tpsl_set.Move(-2000, -2000);
   // ma tpsl設定をどかす
   m_position_menu_sub_ma_tp_chk.Hide();
   m_position_menu_sub_ma_tp_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_method.Hide();
   m_position_menu_sub_ma_tp_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_tp_period.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_chk.Hide();
   m_position_menu_sub_ma_sl_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_method.Hide();
   m_position_menu_sub_ma_sl_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_sl_period.Hide();
   m_position_menu_sub_ma_sl_period.Move(-2000, -2000);
   m_position_menu_sub_ma_tpsl_set.Hide();
   m_position_menu_sub_ma_tpsl_set.Move(-2000, -2000);
   // 色を変える
   m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_active_ColorBackground);
   m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   // ポジションサブパネルを開く
   int x, y;
   x = m_position_menu_main_percent_exit_panel.Right();
   y = m_position_menu_main_percent_exit_panel.Top();
   // パネル
   m_position_menu_sub_panel.Height(POSITION_MENU_SUB_HEIGHT_01);
   m_position_menu_sub_panel.Move(x, y);
   m_position_menu_sub_panel.Show();
   // 部品
   x+=POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_percent_label.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_percent_label.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_sub_percent_input.Text(100);
   m_position_menu_sub_percent_input.Move(x, y);
   m_position_menu_sub_percent_input.Show();
   x+=POSITION_MENU_SUB_EDIT_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_percent_exit.Move(x, y);
   m_position_menu_sub_percent_exit.Show();
}

void CAppWindowSelTradingTool::OnPositionMenuTrailingStopMenu(void)
{
   Print("OnPositionMenuTrailingStopMenu");
   // 既に開いていたら閉じる
   if(m_position_menu_sub_trailingstop_targetpips.IsVisible()){
      // ts設定をどかす
      m_position_menu_sub_trailingstop_chk.Hide();
      m_position_menu_sub_trailingstop_chk.Move(-2000, -2000);
      m_position_menu_sub_trailingstop_targetpips.Hide();
      m_position_menu_sub_trailingstop_targetpips.Move(-2000, -2000);
      m_position_menu_sub_trailingstop_set.Hide();
      m_position_menu_sub_trailingstop_set.Move(-2000, -2000);
      // サブパネルどかす
      m_position_menu_sub_panel.Hide();
      m_position_menu_sub_panel.Move(-2000, -2000);
      // 色を変える
      m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
      m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);
      return;
   }
   // percent exit設定をどかす
   m_position_menu_sub_percent_label.Hide();
   m_position_menu_sub_percent_label.Move(-2000, -2000);
   m_position_menu_sub_percent_input.Hide();
   m_position_menu_sub_percent_input.Move(-2000, -2000);
   m_position_menu_sub_percent_exit.Hide();
   m_position_menu_sub_percent_exit.Move(-2000, -2000);
   // tpsl設定をどかす
   m_position_menu_sub_tp_label.Hide();
   m_position_menu_sub_tp_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_tp_input.Hide();
   m_position_menu_sub_tpsl_tp_input.Move(-2000, -2000);
   m_position_menu_sub_sl_label.Hide();
   m_position_menu_sub_sl_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_sl_input.Hide();
   m_position_menu_sub_tpsl_sl_input.Move(-2000, -2000);
   m_position_menu_sub_tpsl_set.Hide();
   m_position_menu_sub_tpsl_set.Move(-2000, -2000);
   // ma tpsl設定をどかす
   m_position_menu_sub_ma_tp_chk.Hide();
   m_position_menu_sub_ma_tp_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_method.Hide();
   m_position_menu_sub_ma_tp_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_tp_period.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_chk.Hide();
   m_position_menu_sub_ma_sl_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_method.Hide();
   m_position_menu_sub_ma_sl_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_sl_period.Hide();
   m_position_menu_sub_ma_sl_period.Move(-2000, -2000);
   m_position_menu_sub_ma_tpsl_set.Hide();
   m_position_menu_sub_ma_tpsl_set.Move(-2000, -2000);
   // 色を変える
   m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_active_ColorBackground);
   m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);   
   m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   // ポジションサブパネルを開く
   int x, y;
   x = m_position_menu_main_trailingstop_panel.Right();
   y = m_position_menu_main_trailingstop_panel.Top();
   // パネル
   m_position_menu_sub_panel.Height(POSITION_MENU_SUB_HEIGHT_01);
   m_position_menu_sub_panel.Move(x, y);
   m_position_menu_sub_panel.Show();
   // 部品
   x+=POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_trailingstop_chk.Checked(false);
   m_position_menu_sub_trailingstop_chk.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_trailingstop_chk.Show();
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_sub_trailingstop_targetpips.Text("5.0");
   m_position_menu_sub_trailingstop_targetpips.Move(x, y);
   m_position_menu_sub_trailingstop_targetpips.Show();
   x+=POSITION_MENU_SUB_EDIT_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_trailingstop_set.Move(x, y);
   m_position_menu_sub_trailingstop_set.Show();
   
   //---
   for(int i=0;i<ArraySize(_positionTrailingStopSets);i++)
     {
      if(_positionTrailingStopSets[i].ticket==open_menu_position_ticket)
        {
         m_position_menu_sub_trailingstop_chk.Checked(true);
         m_position_menu_sub_trailingstop_targetpips.Text(DoubleToString(_positionTrailingStopSets[i].targetPips,1));
         break;
        }
     }
}

void CAppWindowSelTradingTool::OnPositionMenuTpSlMenu(void)
{
   Print("OnPositionMenuTpSlMenu");
   // 既に開いていたら閉じる
   if(m_position_menu_sub_tpsl_tp_input.IsVisible()){
      // tpsl設定をどかす
      m_position_menu_sub_tp_label.Hide();
      m_position_menu_sub_tp_label.Move(-2000, -2000);
      m_position_menu_sub_tpsl_tp_input.Hide();
      m_position_menu_sub_tpsl_tp_input.Move(-2000, -2000);
      m_position_menu_sub_sl_label.Hide();
      m_position_menu_sub_sl_label.Move(-2000, -2000);
      m_position_menu_sub_tpsl_sl_input.Hide();
      m_position_menu_sub_tpsl_sl_input.Move(-2000, -2000);
      m_position_menu_sub_tpsl_set.Hide();
      m_position_menu_sub_tpsl_set.Move(-2000, -2000);
      // サブパネルどかす
      m_position_menu_sub_panel.Hide();
      m_position_menu_sub_panel.Move(-2000, -2000);
      // 色を変える
      m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
      m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
      return;
   }
   string tp = 0;
   string sl = 0;
   if(m_position.SelectByTicket(open_menu_position_ticket)){
      tp = DoubleToString(m_position.TakeProfit(), _Digits);
      sl = DoubleToString(m_position.StopLoss(), _Digits);
   }
   // ts設定をどかす
   m_position_menu_sub_trailingstop_chk.Hide();
   m_position_menu_sub_trailingstop_chk.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_targetpips.Hide();
   m_position_menu_sub_trailingstop_targetpips.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_set.Hide();
   m_position_menu_sub_trailingstop_set.Move(-2000, -2000);
   // tpsl設定をどかす
   m_position_menu_sub_percent_label.Hide();
   m_position_menu_sub_percent_label.Move(-2000, -2000);
   m_position_menu_sub_percent_input.Hide();
   m_position_menu_sub_percent_input.Move(-2000, -2000);
   m_position_menu_sub_percent_exit.Hide();
   m_position_menu_sub_percent_exit.Move(-2000, -2000);
   // ma tpsl設定をどかす
   m_position_menu_sub_ma_tp_chk.Hide();
   m_position_menu_sub_ma_tp_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_method.Hide();
   m_position_menu_sub_ma_tp_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_tp_period.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_chk.Hide();
   m_position_menu_sub_ma_sl_chk.Move(-2000, -2000);
   m_position_menu_sub_ma_sl_method.Hide();
   m_position_menu_sub_ma_sl_method.Move(-2000, -2000);
   m_position_menu_sub_ma_tp_period.Hide();
   m_position_menu_sub_ma_sl_period.Hide();
   m_position_menu_sub_ma_sl_period.Move(-2000, -2000);
   m_position_menu_sub_ma_tpsl_set.Hide();
   m_position_menu_sub_ma_tpsl_set.Move(-2000, -2000);
   // 色を変える
   m_position_menu_main_tpsl_panel.ColorBackground(position_menu_active_ColorBackground);
   m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);   
   // ポジションサブパネルを開く
   int x, y, x_bk;
   x = m_position_menu_main_tpsl_panel.Right();
   y = m_position_menu_main_tpsl_panel.Top();
   // パネル
   m_position_menu_sub_panel.Height(POSITION_MENU_SUB_HEIGHT_02);
   int height = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
   if(y + m_position_menu_sub_panel.Height() > height)
      y = height - m_position_menu_sub_panel.Height();
   m_position_menu_sub_panel.Move(x, y);
   m_position_menu_sub_panel.Show();
   // 部品
   x+=POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_tp_label.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_tp_label.Show();
   x_bk = x;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_tpsl_tp_input.Text(tp);
   m_position_menu_sub_tpsl_tp_input.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_tpsl_tp_input.Show();
   x = x_bk;
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_sub_sl_label.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_sl_label.Show();
   x_bk = x;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_tpsl_sl_input.Text(sl);
   m_position_menu_sub_tpsl_sl_input.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_tpsl_sl_input.Show();
   x = x_bk;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_sub_tpsl_set.Move(x, y);
   m_position_menu_sub_tpsl_set.Show();
}

void CAppWindowSelTradingTool::OnPositionMenuMATpSlMenu(bool forceExpand)
{
   Print("OnPositionMenuMATpSlMenu");
   // 既に開いていたら閉じる
   if(!forceExpand && m_position_menu_sub_ma_tp_period.IsVisible()){
      // tpsl設定をどかす
      m_position_menu_sub_ma_tp_chk.Hide();
      m_position_menu_sub_ma_tp_chk.Move(-2000, -2000);
      m_position_menu_sub_ma_tp_method.Hide();
      m_position_menu_sub_ma_tp_method.Move(-2000, -2000);
      m_position_menu_sub_ma_tp_period.Hide();
      m_position_menu_sub_ma_tp_period.Move(-2000, -2000);
      m_position_menu_sub_ma_sl_chk.Hide();
      m_position_menu_sub_ma_sl_chk.Move(-2000, -2000);
      m_position_menu_sub_ma_sl_method.Hide();
      m_position_menu_sub_ma_sl_method.Move(-2000, -2000);
      m_position_menu_sub_ma_tp_period.Hide();
      m_position_menu_sub_ma_sl_period.Hide();
      m_position_menu_sub_ma_sl_period.Move(-2000, -2000);
      m_position_menu_sub_ma_tpsl_set.Hide();
      m_position_menu_sub_ma_tpsl_set.Move(-2000, -2000);
      // サブパネルどかす
      m_position_menu_sub_panel.Hide();
      m_position_menu_sub_panel.Move(-2000, -2000);
      // 色を変える
      m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_ColorBackground);
      m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);
      return;
   }
   string tpMAPeriod = "10";
   string slMAPeriod = "10";
   // ts設定をどかす
   m_position_menu_sub_trailingstop_chk.Hide();
   m_position_menu_sub_trailingstop_chk.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_targetpips.Hide();
   m_position_menu_sub_trailingstop_targetpips.Move(-2000, -2000);
   m_position_menu_sub_trailingstop_set.Hide();
   m_position_menu_sub_trailingstop_set.Move(-2000, -2000);   
   // tpsl設定をどかす
   m_position_menu_sub_percent_label.Hide();
   m_position_menu_sub_percent_label.Move(-2000, -2000);
   m_position_menu_sub_percent_input.Hide();
   m_position_menu_sub_percent_input.Move(-2000, -2000);
   m_position_menu_sub_percent_exit.Hide();
   m_position_menu_sub_percent_exit.Move(-2000, -2000);
   // ma tpsl設定をどかす
   m_position_menu_sub_tp_label.Hide();
   m_position_menu_sub_tp_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_tp_input.Hide();
   m_position_menu_sub_tpsl_tp_input.Move(-2000, -2000);
   m_position_menu_sub_sl_label.Hide();
   m_position_menu_sub_sl_label.Move(-2000, -2000);
   m_position_menu_sub_tpsl_sl_input.Hide();
   m_position_menu_sub_tpsl_sl_input.Move(-2000, -2000);
   m_position_menu_sub_tpsl_set.Hide();
   m_position_menu_sub_tpsl_set.Move(-2000, -2000);
   // 色を変える
   m_position_menu_main_ma_tpsl_panel.ColorBackground(position_menu_active_ColorBackground);
   m_position_menu_main_ma_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_percent_exit_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_percent_exit_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_trailingstop_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_trailingstop_panel.ColorBorder(position_menu_ColorBorder);
   m_position_menu_main_tpsl_panel.ColorBackground(position_menu_ColorBackground);
   m_position_menu_main_tpsl_panel.ColorBorder(position_menu_ColorBorder);
   // ポジションサブパネルを開く
   int x, y, x_bk;
   x = m_position_menu_main_ma_tpsl_panel.Right();
   y = m_position_menu_main_ma_tpsl_panel.Top();
   // パネル
   m_position_menu_sub_panel.Height(POSITION_MENU_SUB_HEIGHT_02);
   int height = (int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
   if(y + m_position_menu_sub_panel.Height() > height)
      y = height - m_position_menu_sub_panel.Height();
   m_position_menu_sub_panel.Move(x, y);
   m_position_menu_sub_panel.Show();
   // 部品
   x+=POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_ma_tp_chk.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_tp_chk.Show();
   m_position_menu_sub_ma_tp_chk.Checked(false);
   x_bk = x;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT - 10;
   m_position_menu_sub_ma_tp_method.SelectByValue(MODE_SMA);
   m_position_menu_sub_ma_tp_method.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_tp_method.Show();
   x+=60 + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_ma_tp_period.Text(tpMAPeriod);
   m_position_menu_sub_ma_tp_period.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_tp_period.Show();
   x = x_bk;
   y+=POSITION_MENU_MAIN_HEIGHT;
   m_position_menu_sub_ma_sl_chk.Checked(false);
   m_position_menu_sub_ma_sl_chk.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_sl_chk.Show();   
   x_bk = x;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT - 10;
   m_position_menu_sub_ma_sl_method.SelectByValue(MODE_SMA);
   m_position_menu_sub_ma_sl_method.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_sl_method.Show();   
   
   x+=60 + POSITION_MENU_SUB_COL_INDENT;
   m_position_menu_sub_ma_sl_period.Text(slMAPeriod);
   m_position_menu_sub_ma_sl_period.Move(x, y + POSITION_MENU_MAIN_HEIGHT/4);
   m_position_menu_sub_ma_sl_period.Show();
   x = x_bk;
   x+=POSITION_MENU_SUB_LABEL_WIDTH + POSITION_MENU_SUB_COL_INDENT;
   y+=POSITION_MENU_MAIN_HEIGHT + POSITION_MENU_SUB_ROW_INDENT;
   m_position_menu_sub_ma_tpsl_set.Move(x, y);
   m_position_menu_sub_ma_tpsl_set.Show();
   
   //---
   for(int i=0;i<ArraySize(_positionMAStopSets);i++)
     {
      if(_positionMAStopSets[i].ticket==open_menu_position_ticket)
        {
         if(_positionMAStopSets[i].maTpFlg)
           {
            m_position_menu_sub_ma_tp_chk.Checked(true); 
           }
         if(_positionMAStopSets[i].maSlFlg)
           {
            m_position_menu_sub_ma_sl_chk.Checked(true);
           }
         m_position_menu_sub_ma_tp_method.SelectByValue(_positionMAStopSets[i].maTpMethod);
         m_position_menu_sub_ma_tp_period.Text(IntegerToString(_positionMAStopSets[i].maTpPeriod));  
         m_position_menu_sub_ma_sl_method.SelectByValue(_positionMAStopSets[i].maSlMethod);
         m_position_menu_sub_ma_sl_period.Text(IntegerToString(_positionMAStopSets[i].maSlPeriod));  
         break;
        }
     }
}

void CAppWindowSelTradingTool::OnPositionMenuPercentExitExec(void)
{
   Print("OnPositionMenuPercentExitExec");
   if(m_position.SelectByTicket(open_menu_position_ticket)){ // selects the position by index for further access to its properties
      double volume = m_position.Volume();
      double closeVolume = calcCloseLotToPercent(volume, StringToInteger(m_position_menu_sub_percent_input.Text()));
      if(volume <= closeVolume){
         m_trade.PositionClose(m_position.Ticket()); // close a position by the specified symbol
      }else{
         m_trade.PositionClosePartial(m_position.Ticket(), closeVolume); // close a position by the specified symbol
      }
   }
   CalcInfo();
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnPositionMenuTpSlSet(void)
{
   Print("OnPositionMenuTpSlSet");
   if(m_position.SelectByTicket(open_menu_position_ticket)){ // selects the position by index for further access to its properties
      MqlTradeRequest request;
      MqlTradeResult  result;
      MqlTradeCheckResult chkresult;
      ZeroMemory(request);
      ZeroMemory(result);
      ZeroMemory(chkresult);
      //--- 操作パラメータの設定
      request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
      request.position=m_position.Ticket();   // ポジションシンボル
      request.symbol=m_position.Symbol();     // シンボル
      request.sl      =StringToDouble(m_position_menu_sub_tpsl_sl_input.Text());               // ポジションのStop Loss
      request.tp      =StringToDouble(m_position_menu_sub_tpsl_tp_input.Text());               // ポジションのTake Profit
      //--- 変更情報の出力
      PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
      //--- 変更できるかチェック
      if(!OrderCheck(request, chkresult)){
         Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
      }
      //--- リクエストの送信
      if(!OrderSend(request,result))
         PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
      //--- 操作情報 
      PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
      
      if(result.retcode==TRADE_RETCODE_DONE)
        {
         //---
         for(int i=0;i<ArraySize(_positionMAStopSets);i++)
           {
            if(_positionMAStopSets[i].ticket==open_menu_position_ticket)
              {
               if(request.tp>0)
                  _positionMAStopSets[i].maTpFlg=false;
               if(request.sl>0)   
                  _positionMAStopSets[i].maSlFlg=false;
               break;
              }
           }
        }
   }
   CalcInfo();
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + open_menu_position_ticket, OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
}

void CAppWindowSelTradingTool::OnClickInfoSellExit(void)
{
   Print("OnClickInfoSellExit");
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
         if(
            m_position.Symbol()==Symbol()
            && m_position.PositionType()==POSITION_TYPE_SELL
         ){
            double volume = m_position.Volume();
            double closeVolume = calcCloseLot(volume);
            if(volume <= closeVolume){
               m_trade.PositionClose(m_position.Ticket()); // close a position by the specified symbol
            }else{
               m_trade.PositionClosePartial(m_position.Ticket(), closeVolume); // close a position by the specified symbol
            }
         }
   CalcInfo();
}

void CAppWindowSelTradingTool::OnPositionMenuTrailingStopSet(void)
  {
   Print("OnPositionMenuTrailingStopSet: ", IntegerToString(open_menu_position_ticket));
   if(m_position.SelectByTicket(open_menu_position_ticket))   // selects the position by index for further access to its properties
     { 
      int positionTickets_TsTotal=ArraySize(_positionTrailingStopSets);
   
      int idx=-1;   
      for(int i=0;i<positionTickets_TsTotal;i++)
        {
         if(_positionTrailingStopSets[i].ticket==open_menu_position_ticket)
           {
            idx=i;
            break;
           }
        }
        
      if(m_position_menu_sub_trailingstop_chk.Checked())
        {  
         if(idx==-1)
           {
            positionTickets_TsTotal++;
            ArrayResize(_positionTrailingStopSets,positionTickets_TsTotal,10);
            _positionTrailingStopSets[positionTickets_TsTotal-1].ticket=open_menu_position_ticket;
            
            idx=positionTickets_TsTotal-1;
           }
           
         _positionTrailingStopSets[idx].targetPips=StringToDouble(m_position_menu_sub_trailingstop_targetpips.Text());
        }
      else
        {
         if(!m_position_menu_sub_trailingstop_chk.Checked())
           {
            if(idx!=-1)
              {
               ArrayRemove(_positionTrailingStopSets,idx,1);
              }
           }
        }
     }
   
   ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + IntegerToString(open_menu_position_ticket), OBJPROP_BGCOLOR, position_line_button_color);
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
  }
   
void CAppWindowSelTradingTool::OnPositionMenuMATpSlSet(void)
  {
   bool ret_maTpSlSet=true;
   
   CPositionMAStopSet tmp;
   
   tmp.ticket=open_menu_position_ticket;
   tmp.timeframe=_Period;
   tmp.maTpFlg=m_position_menu_sub_ma_tp_chk.Checked();
   tmp.maTpPeriod=(int)StringToInteger(m_position_menu_sub_ma_tp_period.Text());
   tmp.maTpMethod=(ENUM_MA_METHOD)m_position_menu_sub_ma_tp_method.Value();
   
   tmp.maSlFlg=m_position_menu_sub_ma_sl_chk.Checked();
   tmp.maSlPeriod=(int)StringToInteger(m_position_menu_sub_ma_sl_period.Text());
   tmp.maSlMethod=(ENUM_MA_METHOD)m_position_menu_sub_ma_sl_method.Value();
   
   if(m_position.SelectByTicket(tmp.ticket))
     {
      if(tmp.maTpFlg)
        {
         int handle=FirstOrCreateMAIndicator(tmp.timeframe,tmp.maTpPeriod,tmp.maTpMethod);
         if(handle!=INVALID_HANDLE)
           {
            double ma[1];
                        
            ResetLastError();
            if(CopyBuffer(handle,0,0,1,ma)==1)
              {
               if((m_position.PositionType()==POSITION_TYPE_BUY && iClose(_Symbol,0,0)>=ma[0]) ||
                  (m_position.PositionType()==POSITION_TYPE_SELL && iClose(_Symbol,0,0)<=ma[0]))
                 {
                  tmp.maTpFlg=false;
                  ret_maTpSlSet=false;
                 }
              }
            else  
              {
               //--- if the copying fails, tell the error code
               PrintFormat("MA TP: Failed to copy data from the iMA indicator, error code %d",GetLastError());
               tmp.maTpFlg=false;
               ret_maTpSlSet=false;
              }
           }
         else  
           {
            Print("MA TP: Invalid indicator handle!");
            tmp.maTpFlg=false;
            ret_maTpSlSet=false;
           }
        }
      
      if(tmp.maSlFlg)
        {
         int handle=FirstOrCreateMAIndicator(tmp.timeframe,tmp.maSlPeriod,tmp.maSlMethod);
         if(handle!=INVALID_HANDLE)
           {
            double ma[1];
                        
            ResetLastError();
            if(CopyBuffer(handle,0,0,1,ma)==1)
              {
               if((m_position.PositionType()==POSITION_TYPE_BUY && iClose(_Symbol,0,0)<=ma[0]) ||
                  (m_position.PositionType()==POSITION_TYPE_SELL && iClose(_Symbol,0,0)>=ma[0]))
                 {
                  tmp.maSlFlg=false;
                  ret_maTpSlSet=false;
                 }
              }
            else  
              {
               //--- if the copying fails, tell the error code
               PrintFormat("MA SL: Failed to copy data from the iMA indicator, error code %d",GetLastError());
               tmp.maSlFlg=false;
               ret_maTpSlSet=false;
              }
           }
         else  
           {
            Print("MA SL: Invalid indicator handle!");
            tmp.maSlFlg=false;
            ret_maTpSlSet=false;
           }
        }
      
      int positionMAStopSetsTotal=ArraySize(_positionMAStopSets);
   
      int idx=-1;   
      for(int i=0;i<positionMAStopSetsTotal;i++)
        {
         if(_positionMAStopSets[i].ticket==tmp.ticket)
           {
            idx=i;
            break;
           }
        }
        
      if(idx==-1)
        {
         positionMAStopSetsTotal++;
         ArrayResize(_positionMAStopSets,positionMAStopSetsTotal,10);
         
         idx=positionMAStopSetsTotal-1;
        }
        
      _positionMAStopSets[idx]=tmp;
      
      if(ret_maTpSlSet)
        {
         if(m_position.SelectByTicket(open_menu_position_ticket))
           {
            if(m_position.TakeProfit()>0 || m_position.StopLoss()>0)
              {
               m_trade.PositionModify(open_menu_position_ticket,(_positionMAStopSets[idx].maSlFlg?0:m_position.StopLoss()),(_positionMAStopSets[idx].maTpFlg?0:m_position.TakeProfit()));
              }
           }        
         
         ObjectSetInteger(0, POSITION_NAME_PREFIX + "_button_" + IntegerToString(open_menu_position_ticket), OBJPROP_BGCOLOR, position_line_button_color);
         ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
         ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
         HideAll(POSITION_MENU_NAME_PREFIX);  
        }
      else
        {
         ShowPositionStopInfo(open_menu_position_ticket);
         OnPositionMenuMATpSlMenu(true);
        }
     }
  }  
  
void CAppWindowSelTradingTool::OnClickInfoSellSlTatene(void)
{
   Print("OnClickInfoSellSlTatene");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
            && m_position.PositionType()==POSITION_TYPE_SELL
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.PriceOpen();               // ポジションのStop Loss
            request.tp      =m_position.TakeProfit();               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoSellTpDelete(void)
{
   Print("OnClickInfoSellTpDelete");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
            && m_position.TakeProfit() > 0
            && m_position.PositionType()==POSITION_TYPE_SELL
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.StopLoss();               // ポジションのStop Loss
            request.tp      =0;               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoBuyExit(void)
{
   Print("OnClickInfoBuyExit");
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
         if(
            m_position.Symbol()==Symbol()
            && m_position.PositionType()==POSITION_TYPE_BUY
         ){
            double volume = m_position.Volume();
            double closeVolume = calcCloseLot(volume);
            if(volume <= closeVolume){
               m_trade.PositionClose(m_position.Ticket()); // close a position by the specified symbol
            }else{
               m_trade.PositionClosePartial(m_position.Ticket(), closeVolume); // close a position by the specified symbol
            }
         }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoBuySlTatene(void)
{
   Print("OnClickInfoBuySlTatene");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
            && m_position.PositionType()==POSITION_TYPE_BUY
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.PriceOpen();               // ポジションのStop Loss
            request.tp      =m_position.TakeProfit();               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoBuyTpDelete(void)
{
   Print("OnClickInfoBuyTpDelete");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
            && m_position.TakeProfit() > 0
            && m_position.PositionType()==POSITION_TYPE_BUY
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.StopLoss();               // ポジションのStop Loss
            request.tp      =0;               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoAllExit(void)
{
   Print("OnClickInfoAllExit");
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
         if(m_position.Symbol()==Symbol()){
            double volume = m_position.Volume();
            double closeVolume = calcCloseLot(volume);
            if(volume <= closeVolume){
               m_trade.PositionClose(m_position.Ticket()); // close a position by the specified symbol
            }else{
               m_trade.PositionClosePartial(m_position.Ticket(), closeVolume); // close a position by the specified symbol
            }
         }
   CalcInfo();
}
void CAppWindowSelTradingTool::OnClickInfoAllSlTatene(void)
{
   Print("OnClickInfoAllSlTatene");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.PriceOpen();               // ポジションのStop Loss
            request.tp      =m_position.TakeProfit();               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}

void CAppWindowSelTradingTool::OnClickInfoAllTpDelete(void)
{
   Print("OnClickInfoAllTpDelete");
   MqlTradeRequest request;
   MqlTradeResult  result;
   MqlTradeCheckResult chkresult;
   for(int i=PositionsTotal()-1;i>=0;i--) // returns the number of current positions
   {
      if(m_position.SelectByIndex(i)) // selects the position by index for further access to its properties
      {
         if(
            m_position.Symbol()==Symbol()
            && m_position.TakeProfit() > 0
         )
         {
            ZeroMemory(request);
            ZeroMemory(result);
            ZeroMemory(chkresult);
            //--- 操作パラメータの設定
            request.action  =TRADE_ACTION_SLTP; // 取引操作タイプ
            request.position=m_position.Ticket();   // ポジションシンボル
            request.symbol=m_position.Symbol();     // シンボル
            request.sl      =m_position.StopLoss();               // ポジションのStop Loss
            request.tp      =0;               // ポジションのTake Profit
            //--- 変更情報の出力
            PrintFormat("Modify #%I64d %s %s",m_position.Ticket(),m_position.Symbol(),EnumToString(m_position.PositionType()));
            //--- 変更できるかチェック
            if(!OrderCheck(request, chkresult)){
               Print("OrderCheck Error: ", chkresult.retcode, " ", chkresult.comment);
               continue ;
            }
            //--- リクエストの送信
            if(!OrderSend(request,result))
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
            //--- 操作情報 
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
        }
      }
   }
   CalcInfo();
}

void CAppWindowSelTradingTool::OnClickInfoAllCancel(void)
{
   Print("OnClickInfoAllCancel");
   int orderCnt=0;
   for(int i=OrdersTotal()-1;i>=0;i--)
   {
      if(m_order.SelectByIndex(i))
      {
         if(m_order.Symbol()==Symbol())
         {
            MqlTradeRequest request;
            MqlTradeResult   result;
            ZeroMemory(request);
            ZeroMemory(result);
            request.action=TRADE_ACTION_REMOVE;
            request.order = m_order.Ticket();
            if(!OrderSend(request,result)){
               PrintFormat("OrderSend error %d",GetLastError()); // リクエストの送信に失敗した場合、エラーコードを出力する
               orderCnt++;
            }
         }
      }
   }
   CalcInfo();
}

void CAppWindowSelTradingTool::OnClickGraphSymbol(void)
{
   Print("OnClickGraphSymbol");
   CreateGraphSymbolPopupMenu();
}

void CAppWindowSelTradingTool::OnClickGraphPeriodDay(void)
{
   Print("OnClickGraphPeriod: Day");
   
   if(graphSymbolMenuExpanded)
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
      graphSymbolMenuExpanded = false;
     }
   
   graphPeriod=DAY;
   CreateSubGraph();
}

void CAppWindowSelTradingTool::OnClickGraphPeriodMonth(void)
{
   Print("OnClickGraphPeriod: Month");
   
   if(graphSymbolMenuExpanded)
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
      graphSymbolMenuExpanded = false;
     }
     
   graphPeriod=MONTH;
   CreateSubGraph();
}

void CAppWindowSelTradingTool::OnClickGraphPeriodYear(void)
{
   Print("OnClickGraphPeriod: Year");
   
   if(graphSymbolMenuExpanded)
     {
      HideAll(GRAPH_SYMBOL_MENU_NAME_PREFIX);
      graphSymbolMenuExpanded = false;
     }
     
   graphPeriod=YEAR;
   CreateSubGraph();
}

void CAppWindowSelTradingTool::OnClickCamera(void)
{
   Print("OnClickCamera");
   datetime dt = TimeLocal();
   MqlDateTime mdt;
   TimeToStruct(dt, mdt);
   string filename = "SAT Screenshot\\ScreenShot_"+_Symbol+StringFormat("%4d%02d%02d_%02d%02d%02d", mdt.year, mdt.mon, mdt.day, mdt.hour, mdt.min, mdt.sec)+".png";
   // string filename = "ScreenShot_"+_Symbol+".png";
   int width = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS);
   int height = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS);
   bool b = ChartScreenShot(0, filename, width, height);
   if(b){
      Print("save screen shot file: "+filename);
      PlaySound("::camera.wav");
   }
   else
      Print("don't save screen shot file: "+filename);
}

//+------------------------------------------------------------------+
//| Event "New Tick                                                  |
//+------------------------------------------------------------------+
void CAppWindowSelTradingTool::OnTick(void)
{
   if(!SymbolInfoTick(_Symbol,latest_price))
   {
      Alert("Error getting the latest price quote - error:",GetLastError(),"!!");
      ResetLastError();
      return;
   }

   CalcInfo();
   
   //---
   m_symbolInfo.Refresh();
   m_symbolInfo.RefreshRates();
   
   OnCalculateMAStop();
   OnCalculateTrailingStop();
}

//+------------------------------------------------------------------+
//| Event "Line event                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Minimize dialog window                                           |
//+------------------------------------------------------------------+
void CAppWindowSelTradingTool::Minimize(void){   
   Print("Minimized: ", dialogMminimized);
   HideAll("m_");
   HideAll("sub_");
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
   HideAll(SYMBOL_MENU_NAME_PREFIX);
   HideAll(GRAPH_NAME_PREFIX);
   m_graph_profitGraph.Destroy();
   DIALOG_H = ExtDialog.Height();
   DIALOG_W = ExtDialog.Width();
   CAPTION_H = my_caption.Height();
   CAPTION_W = my_caption.Width();
   BORDER_H = my_border.Height();
   BORDER_W = my_border.Width();
   BACK_H = my_back.Height();
   BACK_W = my_back.Width();
   CLIENT_H = my_client.Height();
   CLIENT_W = my_client.Width();
   ExtDialog.Height(DIALOG_H - CLIENT_H);
   DIALOG_MIN_H = ExtDialog.Height();
   my_caption.Height(CAPTION_H);
   my_caption.Width(CAPTION_W);
   my_client.Hide();
   my_minmaxbtn.Pressed(true);
   dialogMminimized = true;
}
//+------------------------------------------------------------------+
//| Restore dialog window                                            |
//+------------------------------------------------------------------+
void CAppWindowSelTradingTool::Maximize(void){
   //CAppDialog::Maximize();
   Print("Maximized: ", dialogMminimized);
   my_client.Show();
   ExtDialog.Height(DIALOG_H);
   ExtDialog.Width(DIALOG_W);
   my_caption.Height(CAPTION_H);
   my_caption.Width(CAPTION_W);
   //my_caption.Top(CAPTION_TOP);
   //my_caption.Left(CAPTION_LEFT);
   my_border.Height(BORDER_H);
   my_border.Width(BORDER_W);
   my_back.Height(BACK_H);
   my_back.Width(BACK_W);
   my_client.Height(CLIENT_H);
   my_client.Width(CLIENT_W);
   my_minmaxbtn.Pressed(false);
   dialogMminimized = false;
   switch(trade_mode){
      case 1:
         CreateMarket();
         break;
      case 2:
         CreateLimit();
         break;
      case 3:
         CreateStopLimit();
         break;
      default:
         CreateMarket();
         break;
         
   }
   if(position_panel_set_flg==1){
      CreateSub();
   }else{
      HideAll("sub_");
   }   
   
   if(graph_panel_set_flg==1){
      CreateGraph();
   }else{
      HideAll(GRAPH_NAME_PREFIX);
      m_graph_profitGraph.Destroy();
   }
   
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
   HideAll(SYMBOL_MENU_NAME_PREFIX);
}
void CAppWindowSelTradingTool::OnClickButtonMinMax(void){
   //CAppDialog::OnClickButtonMinMax();
   Print("OnClickButtonMinMax, ", my_minmaxbtn.Pressed());
   if(ExtDialog.Height() > 100){
      Minimize();
   }else{
      Maximize();
   }
}
void CAppWindowSelTradingTool::OnTimer(void)
{
   // 再描画確認
   // double b_tp, b_ep, b_sl;
   // b_tp = tp;
   // b_ep = ep;
   // b_sl = sl;
   tp = NormalizeDouble(ObjectGetDouble(0, HLINE_TP_NAME, OBJPROP_PRICE), _Digits);
   sl = NormalizeDouble(ObjectGetDouble(0, HLINE_SL_NAME, OBJPROP_PRICE), _Digits);
   ep = NormalizeDouble(ObjectGetDouble(0, HLINE_ENTRY_NAME, OBJPROP_PRICE), _Digits);
   // if(
   //    b_tp != tp
   //    || b_ep != ep
   //    || b_sl != sl
   // ){
   //    Print("OnTimer", " ", tp, " ", ep, " ", sl);
      CalcInfo();
   // }
   // 過去ローソク100本取得できる
   int copied=CopyRates(Symbol(),0,0,100,rates);
   if(copied<=0)
   {
      Print("Error getting the CopyRates - error:",GetLastError(),"!!");
      ResetLastError();
      return ;
   }
   if(!ArraySetAsSeries(rates,true))
   {
      return ;
   }
   ChkAlerm();
   
   ExtDialog.OnCalculateMAStop();
   
   //--- Adjust display info's position
   ObjectSetString(0,LABEL_CANDLETIME_NAME,OBJPROP_TEXT,calcCandleTime());
   
   int candleTimeHeight=(int)ObjectGetInteger(0,LABEL_CANDLETIME_NAME,OBJPROP_YSIZE);
   if(candleTimeHeight>0)
     {
      ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_YDISTANCE,ObjectGetInteger(0,LABEL_CANDLETIME_NAME,OBJPROP_YDISTANCE)+candleTimeHeight+10);
     }     
   int maTpSlInfoHeight=(int)ObjectGetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_YSIZE);
   if(maTpSlInfoHeight>0)
     {
      ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_YDISTANCE,ObjectGetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_YDISTANCE)+maTpSlInfoHeight+10);
     }
}
// void CAppWindowSelTradingTool::OnLineDrag(string sparam)
// {
//    if(sparam == HLINE_TP_NAME)
//    {
//       tp = NormalizeDouble(ObjectGetDouble(0, HLINE_TP_NAME, OBJPROP_PRICE), _Digits);
//       CalcInfo();
//    }
//    if(sparam == HLINE_SL_NAME)
//    {
//       sl = NormalizeDouble(ObjectGetDouble(0, HLINE_SL_NAME, OBJPROP_PRICE), _Digits);
//       CalcInfo();
//    }
//    if(sparam == HLINE_ENTRY_NAME)
//    {
//       ep = NormalizeDouble(ObjectGetDouble(0, HLINE_ENTRY_NAME, OBJPROP_PRICE), _Digits);
//       CalcInfo();
//    }
   
// }

// void CAppWindowSelTradingTool::OnLineClick(string sparam)
// {
// }

bool CAppWindowSelTradingTool::Hide(void)
{
   return CAppDialog::Hide();
}

bool CAppWindowSelTradingTool::Show(void)
{
   CAppDialog::Show();
   
   switch(trade_mode){
      case 1:
         m_menu_button_market.Hide();
         break;
      case 2:
         m_menu_button_limit.Hide();
         break;
      case 3:
         m_menu_button_stoplimit.Hide();
         break;
      default:
         m_menu_button_market.Hide();
         break;
         
      }
   if(position_panel_set_flg==1){
      m_info_line1.Hide(); 
      m_info_line2.Hide();
      m_info_line1.Show();      
      m_info_line2.Show();
   } else {
      HideAll("sub_");
   }
   if(graph_panel_set_flg==1) {
      CreateGraph();
   } else {
      HideAll(GRAPH_NAME_PREFIX);
      m_graph_profitGraph.Destroy();
   }
   ObjectSetInteger(0,LABEL_MA_TPSL_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   ObjectSetInteger(0,LABEL_TRAILINGSTOP_INFO_NAME,OBJPROP_TIMEFRAMES,OBJ_NO_PERIODS);
   HideAll(POSITION_MENU_NAME_PREFIX);
   HideAll(SYMBOL_MENU_NAME_PREFIX);
   
   return true;
}

void CAppWindowSelTradingTool::ReDraw(void)
{
   // LINE関連の描画
   if(order_type == ORDER_TYPE_BUY){
      ObjectSetDouble(0, HLINE_TP_SHADOW_NAME,     OBJPROP_PRICE, tp+sp);
      ObjectSetDouble(0, HLINE_SL_SHADOW_NAME,     OBJPROP_PRICE, sl+sp);
      ObjectSetDouble(0, HLINE_ENTRY_SHADOW_NAME,  OBJPROP_PRICE, ep-sp);
      // ObjectSetInteger(0, HLINE_TP_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      // ObjectSetInteger(0, HLINE_SL_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
      // ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,  OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   }else{
      ObjectSetDouble(0, HLINE_TP_SHADOW_NAME,     OBJPROP_PRICE, tp-sp);
      ObjectSetDouble(0, HLINE_SL_SHADOW_NAME,     OBJPROP_PRICE, sl-sp);
      ObjectSetDouble(0, HLINE_ENTRY_SHADOW_NAME,  OBJPROP_PRICE, ep+sp);
      // ObjectSetInteger(0, HLINE_TP_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      // ObjectSetInteger(0, HLINE_SL_SHADOW_NAME,     OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
      // ObjectSetInteger(0, HLINE_ENTRY_SHADOW_NAME,  OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   }
   int x, y, x2, y2, x3, y3;
   datetime time = iTime(_Symbol,0,0);
   ChartTimePriceToXY(0, 0, time, ep, x, y);
   ChartTimePriceToXY(0, 0, time, tp, x2, y2);
   ChartTimePriceToXY(0, 0, time, sl, x3, y3);
   ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YSIZE,MathAbs(y-y2));
   ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YSIZE,MathAbs(y-y3));
   if(y>y2){
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YDISTANCE,y2);
   }else{
      ObjectSetInteger(0,RECTANGLE_TP_NAME,OBJPROP_YDISTANCE,y);
   }
   if(y>y3){
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YDISTANCE,y3);
   }else{
      ObjectSetInteger(0,RECTANGLE_SL_NAME,OBJPROP_YDISTANCE,y);
   }


   //--- ラベル座標を設定する
   ChartTimePriceToXY(0, 0, time, tp, x, y);
   // ObjectSetInteger(0,LABEL_TP2_NAME,     OBJPROP_XDISTANCE,LINE_LABEL2_X);
   // ObjectSetInteger(0,LABEL_TP2_NAME,     OBJPROP_YDISTANCE,y);
   // ObjectSetInteger(0,LABEL_TP3_NAME,     OBJPROP_XDISTANCE,LINE_LABEL2_X);
   // ObjectSetInteger(0,LABEL_TP3_NAME,     OBJPROP_YDISTANCE,y);
   y -= LINE_LABEL1_HEIGHT;
   ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_XDISTANCE,LINE_LABEL1_X);
   ObjectSetInteger(0,LABEL_TP1_NAME,     OBJPROP_YDISTANCE,y);
   ChartTimePriceToXY(0, 0, time, sl, x, y);
   // ObjectSetInteger(0,LABEL_SL2_NAME,     OBJPROP_XDISTANCE,LINE_LABEL2_X);
   // ObjectSetInteger(0,LABEL_SL2_NAME,     OBJPROP_YDISTANCE,y);
   // ObjectSetInteger(0,LABEL_SL3_NAME,     OBJPROP_XDISTANCE,LINE_LABEL2_X);
   // ObjectSetInteger(0,LABEL_SL3_NAME,     OBJPROP_YDISTANCE,y);
   y -= LINE_LABEL1_HEIGHT;
   ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_XDISTANCE,LINE_LABEL1_X);
   ObjectSetInteger(0,LABEL_SL1_NAME,     OBJPROP_YDISTANCE,y);
   ChartTimePriceToXY(0, 0, time, ep, x, y);
   // ObjectSetInteger(0,LABEL_ENTRY2_NAME,  OBJPROP_XDISTANCE,LINE_LABEL2_2_X);
   // ObjectSetInteger(0,LABEL_ENTRY2_NAME,  OBJPROP_YDISTANCE,y);
   // ObjectSetInteger(0,LABEL_ENTRY3_NAME,  OBJPROP_XDISTANCE,LINE_LABEL2_X);
   // ObjectSetInteger(0,LABEL_ENTRY3_NAME,  OBJPROP_YDISTANCE,y);
   y -= LINE_LABEL1_HEIGHT;
   ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_XDISTANCE,LINE_LABEL1_X);
   ObjectSetInteger(0,LABEL_ENTRY1_NAME,  OBJPROP_YDISTANCE,y);
   ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_XDISTANCE,LINE_LABEL1_X);
   ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,  OBJPROP_YDISTANCE,y);
   ObjectSetInteger(0,LABEL_REVERSE_ICON_NAME,OBJPROP_STATE,1);
   //--- テキストを設定する
   // Print("CalcInfo", " ", "SL (" + DoubleToString(sl_pips, 1) + ") " + DoubleToString(sl, _Digits));
   ObjectSetString(0,LABEL_TP1_NAME,      OBJPROP_TEXT,"TP " + DoubleToString(tp_pips, 1));
   ObjectSetString(0,LABEL_SL1_NAME,      OBJPROP_TEXT,"SL " + DoubleToString(sl_pips, 1));
   ObjectSetString(0,LABEL_ENTRY1_NAME,   OBJPROP_TEXT,"RR " + plslrate);
   ObjectSetString(0,LABEL_CANDLETIME_NAME,   OBJPROP_TEXT, calcCandleTime());
   // datetime now = iTime(_Symbol, 0, 0);
   // Print(now, " ", TimeCurrent(), " ", TimeTradeServer(), " ", TimeCurrent() - now, " ", TimeCurrent() - now > 70, " ", _Period);
   // ObjectSetString(0,LABEL_TP2_NAME,      OBJPROP_TEXT,"利確 " + DoubleToString(plplan, 2) + currency);
   // ObjectSetString(0,LABEL_SL2_NAME,      OBJPROP_TEXT,"損切 " + DoubleToString(slplan, 2) + currency);
   // ObjectSetString(0,LABEL_ENTRY2_NAME,   OBJPROP_TEXT,"必要勝率 " + winrate + "% " + DoubleToString(Lot, 2) + "Lot");
   // ObjectSetString(0,LABEL_TP3_NAME,      OBJPROP_TEXT,DoubleToString(tp, _Digits));
   // ObjectSetString(0,LABEL_SL3_NAME,      OBJPROP_TEXT,DoubleToString(sl, _Digits));
   // ObjectSetString(0,LABEL_ENTRY3_NAME,   OBJPROP_TEXT,DoubleToString(ep, _Digits));

   // Position関連のラベル制御
   ExtDialog.CreateAndUpdatePositionObjects();
   // ロット計算
   if(auto_manual_flg==1)
   {
      m_common_lot.Text(DoubleToString(Lot, 2));
   }
   // ep計算
   if(
      trade_mode==1     // 成行
      || trace_mode==2  // 追従モード
   ){
      ObjectSetDouble(0,HLINE_ENTRY_NAME,OBJPROP_PRICE,ep);
   }
   // スプレッド表示
   string caption_str = "SP:"+DoubleToString(PriceToPips(sp), 1);
   // 取引市場の表示
   string TimeCuntry="";
   datetime GMTdt = TimeGMT();
   MqlDateTime GMTmdt;
   TimeToStruct(GMTdt, GMTmdt);
   bool summer = IsSummerTime();
   if(
      GMTmdt.hour >= 23
      ||
      (
         GMTmdt.hour >= 0
         && GMTmdt.hour < 7
      )
   ){
      TimeCuntry = "TOKYO";
   }
   if(
      (
         summer
         && GMTmdt.hour >= 7
         && GMTmdt.hour < 15
      )
      ||
      (
         !summer
         && GMTmdt.hour >= 8
         && GMTmdt.hour < 16
      )
   ){
      TimeCuntry = "LONDON";
   }
   if(
      (
         summer
         && GMTmdt.hour >= 12
         && GMTmdt.hour < 20
      )
      ||
      (
         !summer
         && GMTmdt.hour >= 13
         && GMTmdt.hour < 21
      )
   ){
      TimeCuntry = "NEW YORK";
   }
   // my_caption.Text(TOOL_NAME+"("+_Symbol+")"+" SP:"+DoubleToString(PriceToPips(sp), 1));
   if(TimeCuntry!="")
      caption_str += " "+TimeCuntry;
   //my_caption.Text(caption_str);
   m_menu_status.Text(caption_str);

   // ティッカーの反映
   // 1=成行、2=指値、3=逆指、4=決済
   switch(trade_mode)
   {
      case 1:
         m_tick_label_ask.Text(DoubleToString(latest_price.ask, _Digits));
         m_tick_label_bid.Text(DoubleToString(latest_price.bid, _Digits));
         break;
      default:
         m_tick_label_ask.Text(DoubleToString(ep, _Digits));
         m_tick_label_bid.Text(DoubleToString(ep, _Digits));
         break;
   }
   // ObjectSetDouble(0, HLINE_ENTRY_ASK_NAME, OBJPROP_PRICE, ep_ask);
   m_common_label_pl_price.Text(DoubleToString(tp, _Digits));
   m_common_label_pl_pips_str.Text(DoubleToString(tp_pips,1) + " pips");
   m_common_label_sl_price.Text(DoubleToString(sl, _Digits));
   m_common_label_sl_pips_str.Text(DoubleToString(sl_pips,1) + " pips");
   m_common_label_plslrate.Text(plslrate);
   m_common_label_winrate_percent_str.Text(winrate + " %");
   m_common_label_plplan_currency.Text(DoubleToString(plplan,1) + " " + currency);
   m_common_label_slplan_currency.Text(DoubleToString(slplan,1) + " " + currency);

   // ﾎﾞﾀﾝ制御
   if(auto_manual_flg==1){
      m_common_button_auto.Color(lot_active_Color);
      m_common_button_auto.ColorBackground(lot_active_ColorBackground);
      m_common_button_manual.Color(lot_nonactive_Color);
      m_common_button_manual.ColorBackground(lot_nonactive_ColorBackground);
      m_common_lot.ReadOnly(true);
   }else{
      m_common_button_manual.Color(lot_active_Color);
      m_common_button_manual.ColorBackground(lot_active_ColorBackground);
      m_common_button_auto.Color(lot_nonactive_Color);
      m_common_button_auto.ColorBackground(lot_nonactive_ColorBackground);
      m_common_lot.ReadOnly(false);
   }
   if(tp_set_flg==1){
      m_common_button_tp.Color(tp_active_Color);
      m_common_button_tp.ColorBackground(tp_active_ColorBackground);
   }else{
      m_common_button_tp.Color(tp_nonactive_Color);
      m_common_button_tp.ColorBackground(tp_nonactive_ColorBackground);
   }
   if(sl_set_flg==1){
      m_common_button_sl.Color(sl_active_Color);
      m_common_button_sl.ColorBackground(sl_active_ColorBackground);
   }else{
      m_common_button_sl.Color(sl_nonactive_Color);
      m_common_button_sl.ColorBackground(sl_nonactive_ColorBackground);
   }
   if(alerm_set_flg==1){
      m_common_button_alerm.Color(alerm_active_Color);
      m_common_button_alerm.ColorBackground(alerm_active_ColorBackground);
   }else{
      m_common_button_alerm.Color(alerm_nonactive_Color);
      m_common_button_alerm.ColorBackground(alerm_nonactive_ColorBackground);
   }
   if(horizon_set_flg==1){
      m_common_button_horizon.Color(horizon_active_Color);
      m_common_button_horizon.ColorBackground(horizon_active_ColorBackground);
   }else{
      m_common_button_horizon.Color(horizon_nonactive_Color);
      m_common_button_horizon.ColorBackground(horizon_nonactive_ColorBackground);
   }
   if(bg_set_flg==1){
      m_common_button_bg.Color(bg_active_Color);
      m_common_button_bg.ColorBackground(bg_active_ColorBackground);
   }else{
      m_common_button_bg.Color(bg_nonactive_Color);
      m_common_button_bg.ColorBackground(bg_nonactive_ColorBackground);
   }
   if(position_panel_set_flg==1){
      m_menu_button_info.Color(menu_info_Color);
      m_menu_button_info.ColorBackground(menu_info_ColorBackground);
      m_menu_button_info.Text(info_active_text);
   }else{
      m_menu_button_info.Color(menu_info_nonactive_Color);
      m_menu_button_info.ColorBackground(menu_info_nonactive_ColorBackground);
      m_menu_button_info.Text(info_nonactive_text);
   }
   if(graph_panel_set_flg==1){
      m_common_button_graph.Color(menu_info_Color);
      m_common_button_graph.ColorBackground(menu_info_ColorBackground);
   }else{
      m_common_button_graph.Color(menu_info_nonactive_Color);
      m_common_button_graph.ColorBackground(menu_info_nonactive_ColorBackground);
   }
   if(graphPeriod==0){
      m_graph_pday_button.Color(menu_info_Color);
      m_graph_pday_button.ColorBackground(menu_info_ColorBackground);
      
      m_graph_pmonth_button.Color(menu_info_nonactive_Color);
      m_graph_pmonth_button.ColorBackground(menu_info_nonactive_ColorBackground);
      m_graph_pyear_button.Color(menu_info_nonactive_Color);
      m_graph_pyear_button.ColorBackground(menu_info_nonactive_ColorBackground);
   } else if(graphPeriod==1){
      m_graph_pmonth_button.Color(menu_info_Color);
      m_graph_pmonth_button.ColorBackground(menu_info_ColorBackground);
      
      m_graph_pday_button.Color(menu_info_nonactive_Color);
      m_graph_pday_button.ColorBackground(menu_info_nonactive_ColorBackground);
      m_graph_pyear_button.Color(menu_info_nonactive_Color);
      m_graph_pyear_button.ColorBackground(menu_info_nonactive_ColorBackground);
   } else if(graphPeriod==2){
      m_graph_pyear_button.Color(menu_info_Color);
      m_graph_pyear_button.ColorBackground(menu_info_ColorBackground);
      
      m_graph_pday_button.Color(menu_info_nonactive_Color);
      m_graph_pday_button.ColorBackground(menu_info_nonactive_ColorBackground);
      m_graph_pmonth_button.Color(menu_info_nonactive_Color);
      m_graph_pmonth_button.ColorBackground(menu_info_nonactive_ColorBackground);
   } 
   
   MqlTradeRequest request;
   MqlTradeCheckResult result;
   ZeroMemory(request);     // Initialization of request structure
   ZeroMemory(result);     // Initialization of request structure
   request = CreateBuyRequest();
   if(!OrderCheck(request, result)){
      m_trade_button_ask.Color(trade_ask_nonactive_Color);
      m_trade_button_ask.ColorBackground(trade_ask_nonactive_ColorBackground);
      m_trade_label_ask.Color(trade_ask_nonactive_Color);
      m_trade_label_ask.ColorBackground(trade_ask_nonactive_ColorBackground);
      m_tick_label_ask.Color(trade_ask_nonactive_Color);
      m_tick_label_ask.ColorBackground(trade_ask_nonactive_ColorBackground);
   }else{
      m_trade_button_ask.Color(trade_ask_Color);
      m_trade_button_ask.ColorBackground(trade_ask_ColorBackground);
      m_trade_label_ask.Color(trade_ask_Color);
      m_trade_label_ask.ColorBackground(trade_ask_ColorBackground);
      m_tick_label_ask.Color(trade_ask_Color);
      m_tick_label_ask.ColorBackground(trade_ask_ColorBackground);
   }
   ZeroMemory(request);     // Initialization of request structure
   ZeroMemory(result);     // Initialization of request structure
   request = CreateSellRequest();
   if(!OrderCheck(request, result)){
      m_trade_button_bid.Color(trade_bid_nonactive_Color);
      m_trade_button_bid.ColorBackground(trade_bid_nonactive_ColorBackground);
      m_trade_label_bid.Color(trade_bid_nonactive_Color);
      m_trade_label_bid.ColorBackground(trade_bid_nonactive_ColorBackground);
      m_tick_label_bid.Color(trade_bid_nonactive_Color);
      m_tick_label_bid.ColorBackground(trade_bid_nonactive_ColorBackground);
   }else{
      m_trade_button_bid.Color(trade_bid_Color);
      m_trade_button_bid.ColorBackground(trade_bid_ColorBackground);
      m_trade_label_bid.Color(trade_bid_Color);
      m_trade_label_bid.ColorBackground(trade_bid_ColorBackground);
      m_tick_label_bid.Color(trade_bid_Color);
      m_tick_label_bid.ColorBackground(trade_bid_ColorBackground);
   }

   // 決済情報、ﾎﾞﾀﾝ制御
   int sellCnt=0, buyCnt=0, allCnt=0, orderCnt=0;
   double sellpl=0, buypl=0, allpl=0;
   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      if(m_position.SelectByIndex(i))
      {
         if(m_position.Symbol()==Symbol())
         {
            allCnt++;
            allpl+=m_position.Profit();
            if(m_position.PositionType()==POSITION_TYPE_BUY)
            {
               buyCnt++;
               buypl+=m_position.Profit();
            }
            else
            {
               sellCnt++;
               sellpl+=m_position.Profit();
            }
         }
      }
   }
   m_info_label_position_sell.Text("Sell("+IntegerToString(sellCnt)+")");
   m_info_label_position_buy.Text("Buy("+IntegerToString(buyCnt)+")");
   m_info_label_position_all.Text("All("+IntegerToString(allCnt)+")");
   m_info_label_position_sell_price.Text(DoubleToString(sellpl,2)+" "+currency);
   m_info_label_position_buy_price.Text(DoubleToString(buypl,2)+" "+currency);
   m_info_label_position_all_price.Text(DoubleToString(allpl,2)+" "+currency);

   m_info_label_account_info01_price.Text(DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),0)+" "+currency);
   m_info_label_account_info02_price.Text(DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),0)+" "+currency);
   m_info_label_account_info03_price.Text(DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN),0)+" "+currency);
   m_info_label_account_info04_price.Text(DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2)+" "+"%");

   for(int i=OrdersTotal()-1;i>=0;i--)
   {
      if(m_order.SelectByIndex(i))
      {
         if(m_order.Symbol()==Symbol())
         {
            orderCnt++;
         }
      }
   }
   m_info_label_order_all.Text("待機注文一括("+IntegerToString(orderCnt)+")");
   
   //---
   double pnls[];
   int posCnts[];
   ArrayResize(pnls,_mkt_symbols_total,100);
   ArrayResize(posCnts,_mkt_symbols_total,100);
   ArrayInitialize(pnls, 0);
   ArrayInitialize(posCnts, 0);
   
   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      if(m_position.SelectByIndex(i))
      {
         int index = GetSymbolItemIndex(m_position.Symbol());
         if(index != -1)
         {            
            pnls[index]+=m_position.Profit();
            posCnts[index]++;
         }
      }
   }
   
   for (int i = 0; i < ArraySize(m_menu_popup_items); i++)
   {
      if (!m_menu_popup_panel.IsVisible())
         break;
         
      if (posCnts[i] == 0)
      {
         m_menu_popup_items[i].Color(clrBlack);
         continue;
      }
         
      m_menu_popup_items[i].Text(_mkt_symbols[i] + "   " + (pnls[i] > 0 ? "+" : "") + DoubleToString(pnls[i], 2));
      if (pnls[i] > 0)
         m_menu_popup_items[i].Color(clrGreen);
      else
         m_menu_popup_items[i].Color(clrRed);
   }
   
   PROFIT_STATISTICS pfStatistics;
   CalcProfitStatistics(pfStatistics);
   
   m_graph_totalProfit_label.Text((pfStatistics.totalProfit>0.f ? "+" : "") + DoubleToString(pfStatistics.totalProfit,2) + " " + AccountInfoString(ACCOUNT_CURRENCY));
   m_graph_totalProfit_label.Color(pfStatistics.totalProfit>=0.f ? C'123,183,59' : clrRed);
   m_graph_totalTrades_label.Text(GRAPH_LABEL_TRADES_PREFIX + "          " + pfStatistics.totalTrades + "回");
   m_graph_longTrades_label.Text(GRAPH_LABEL_LONG_TRADES_PREFIX + "          " + pfStatistics.longTrades + "回 (" + DoubleToString(pfStatistics.longTradesWinPercent,0) + " % (勝率) )");
   m_graph_shortTrades_label.Text(GRAPH_LABEL_SHORT_TRADES_PREFIX + "          " + pfStatistics.shortTrades + "回 (" + DoubleToString(pfStatistics.shortTradesWinPercent,0) + " % (勝率) )");
   m_graph_profitFactor_label.Text(GRAPH_LABEL_PROFITFACTOR_PREFIX + "          " + DoubleToString(pfStatistics.profitFactor,1));
   m_graph_maxDrawdown_label.Text(GRAPH_LABEL_MDD_PREFIX + "          " + DoubleToString(pfStatistics.maxDrawdown,2) + " (" + DoubleToString(pfStatistics.maxDrawdownPercent,2) + "%)");
      
   ChartRedraw(0);
}

int GetSymbolItemIndex(string symbol)
  {
   for (int i = 0; i < _mkt_symbols_total; i++)
     {
      if (_mkt_symbols[i] == symbol)
         return (i);
     }
   return (-1);
  }
//+------------------------------------------------------------------+
//| Calc                                                             |
//+------------------------------------------------------------------+
MqlTradeRequest CAppWindowSelTradingTool::CreateBuyRequest(void)
{
   MqlTradeRequest request;
   ZeroMemory(request);     // Initialization of request structure
   request.symbol = _Symbol;                                         // currency pair
   request.volume = Lot;                                            // number of lots to trade
   request.price = 0;
   request.sl = 0;
   request.tp = 0;
   request.type_filling = order_filling_type;                          // Order execution type
   if(mktorder_check_tpsl_flg==OFF || (trade_mode!= 1 || horizon_set_flg==1)){ //tp_set_flg
      request.tp = NormalizeDouble(tp,_Digits);
   }
   if(mktorder_check_tpsl_flg==OFF || (trade_mode!= 1 || horizon_set_flg==1)){ //sl_set_flg
      request.sl = NormalizeDouble(sl,_Digits);
   }   
   // 1=成行、2=指値、3=逆指、4=決済
   switch(trade_mode)
   {
      case 1:
         request.action = TRADE_ACTION_DEAL;
         request.price = NormalizeDouble(latest_price.ask,_Digits);
         request.type = ORDER_TYPE_BUY;                                     // Buy Order
         break;
      case 2:
         request.action = TRADE_ACTION_PENDING;
         request.price = NormalizeDouble(ep,_Digits);
         request.type = ORDER_TYPE_BUY_LIMIT;                                     // Buy Order
         break;
      case 3:
         request.action = TRADE_ACTION_PENDING;
         request.price = NormalizeDouble(ep,_Digits);
         request.type = ORDER_TYPE_BUY_STOP;                                     // Buy Order
         break;
   }

   return request;
}

MqlTradeRequest CAppWindowSelTradingTool::CreateSellRequest(void)
{
   MqlTradeRequest request;
   ZeroMemory(request);     // Initialization of request structure
   request.symbol = _Symbol;                                         // currency pair
   request.volume = Lot;                                            // number of lots to trade
   request.price = 0;
   request.sl = 0;
   request.tp = 0;
   request.type_filling = order_filling_type;                          // Order execution type
   if(mktorder_check_tpsl_flg==OFF || (trade_mode!= 1 || horizon_set_flg==1)){ //tp_set_flg
      request.tp = NormalizeDouble(tp,_Digits);
   }
   if(mktorder_check_tpsl_flg==OFF || (trade_mode!= 1 || horizon_set_flg==1)){ //sl_set_flg
      request.sl = NormalizeDouble(sl,_Digits);
   }
   // 1=成行、2=指値、3=逆指、4=決済
   switch(trade_mode)
   {
      case 1:
         request.action = TRADE_ACTION_DEAL;
         request.price = NormalizeDouble(latest_price.bid,_Digits);
         request.type = ORDER_TYPE_SELL;                                     // Buy Order
         break;
      case 2:
         request.action = TRADE_ACTION_PENDING;
         request.price = NormalizeDouble(ep,_Digits);
         request.type = ORDER_TYPE_SELL_LIMIT;                                     // Buy Order
         break;
      case 3:
         request.action = TRADE_ACTION_PENDING;
         request.price = NormalizeDouble(ep,_Digits);
         request.type = ORDER_TYPE_SELL_STOP;                                     // Buy Order
         break;
   }

   return request;
}

void CalcDp()
{
   oringin_ratio=1*getZoomRate(zoom_rate_select);
   oringin_ratio_not_zoom=1;

    BASE_LEFT = ORG_BASE_LEFT * oringin_ratio;
    BASE_TOP = ORG_BASE_TOP * oringin_ratio;
    BASE_WIDTH = ORG_BASE_WIDTH * oringin_ratio;
    BASE_HEIGHT = ORG_BASE_HEIGHT * oringin_ratio;
//--- indents and gaps
    MENU_INDENT_LEFT = ORG_MENU_INDENT_LEFT * oringin_ratio;
    MENU_INDENT_TOP = ORG_MENU_INDENT_TOP * oringin_ratio;
    BODY_INDENT_LEFT = ORG_BODY_INDENT_LEFT * oringin_ratio;
    BODY_INDENT_CENTER = ORG_BODY_INDENT_CENTER * oringin_ratio;
    BODY_INDENT_TOP = ORG_BODY_INDENT_TOP * oringin_ratio;
    BODY_INDENT_ROW = ORG_BODY_INDENT_ROW * oringin_ratio;
    GRAPH_INDENT_LEFT = ORG_GRAPH_INDENT_LEFT * oringin_ratio;
    GRAPH_INDENT_TOP = ORG_GRAPH_INDENT_TOP * oringin_ratio;
//--- menu buttons    
    MENU_EDIT_WIDTH = ORG_MENU_EDIT_WIDTH * oringin_ratio;
    MENU_EDIT_WIDE_WIDTH = ORG_MENU_EDIT_WIDE_WIDTH * oringin_ratio;
    MENU_PANEL_EDIT_WIDTH = ORG_MENU_EDIT_WIDE_WIDTH * 1.5 * oringin_ratio;
    MENU_EDIT_HEIGHT = ORG_MENU_EDIT_HEIGHT * oringin_ratio;
    MENU_BUTTON_WIDTH = ORG_MENU_BUTTON_WIDTH * oringin_ratio;
    MENU_BUTTON_HEIGHT = ORG_MENU_BUTTON_HEIGHT * oringin_ratio;
    MENU_LABEL_WIDTH = ORG_MENU_LABEL_WIDTH * oringin_ratio;
    MENU_LABEL_HEIGHT = ORG_MENU_LABEL_HEIGHT * oringin_ratio;
    MENU_BUTTON_INFO_INDENT_LEFT = ORG_MENU_BUTTON_INFO_INDENT_LEFT * oringin_ratio;
    MENU_BUTTON_INFO_WIDTH = ORG_MENU_BUTTON_INFO_WIDTH * oringin_ratio;
    MENU_BUTTON_INFO_HEIGHT = ORG_MENU_BUTTON_INFO_HEIGHT * oringin_ratio;
//--- trade buttons
    TRADE_BUTTON_WIDTH = ORG_TRADE_BUTTON_WIDTH * oringin_ratio;
    TRADE_BUTTON_HEIGHT = ORG_TRADE_BUTTON_HEIGHT * oringin_ratio;
//--- trade labels
    TRADE_LABEL_WIDTH = ORG_TRADE_LABEL_WIDTH * oringin_ratio;
    TRADE_LABEL_HEIGHT = ORG_TRADE_LABEL_HEIGHT * oringin_ratio;
//--- tick labels
    TICK_LABEL_WIDTH = ORG_TICK_LABEL_WIDTH * oringin_ratio;
    TICK_LABEL_HEIGHT = ORG_TICK_LABEL_HEIGHT * oringin_ratio;
//--- common labels
    COMMON_LABEL_COL1_WIDTH = ORG_COMMON_LABEL_COL1_WIDTH * oringin_ratio;
    COMMON_LABEL_COL2_WIDTH = ORG_COMMON_LABEL_COL2_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_WIDTH = ORG_COMMON_LABEL_COL3_WIDTH * oringin_ratio;
    COMMON_LABEL_COL4_WIDTH = ORG_COMMON_LABEL_COL4_WIDTH * oringin_ratio;
    COMMON_LABEL_COL5_WIDTH = ORG_COMMON_LABEL_COL5_WIDTH * oringin_ratio;
    COMMON_LABEL_COL6_WIDTH = ORG_COMMON_LABEL_COL6_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_1_1_WIDTH = ORG_COMMON_LABEL_COL3_1_1_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_1_2_WIDTH = ORG_COMMON_LABEL_COL3_1_2_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_2_1_WIDTH = ORG_COMMON_LABEL_COL3_2_1_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_2_2_WIDTH = ORG_COMMON_LABEL_COL3_2_2_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_3_1_WIDTH = ORG_COMMON_LABEL_COL3_3_1_WIDTH * oringin_ratio;
    COMMON_LABEL_COL3_3_2_WIDTH = ORG_COMMON_LABEL_COL3_3_2_WIDTH * oringin_ratio;
    COMMON_BUTTON_HEIGHT = ORG_COMMON_BUTTON_HEIGHT * oringin_ratio;
    COMMON_LABEL_HEIGHT = ORG_COMMON_LABEL_HEIGHT * oringin_ratio;
    COMMON_LABEL_FOOTER_WIDTH = ORG_COMMON_LABEL_FOOTER_WIDTH * oringin_ratio;
    COMMON_LABEL_FOOTER_INDENT = ORG_COMMON_LABEL_FOOTER_INDENT * oringin_ratio;
    COMMON_LABEL_FOOTER_INFO_INDENT = ORG_COMMON_LABEL_FOOTER_INFO_INDENT * oringin_ratio;
    COMMON_LABEL_FOOTER_INFO_WIDTH = ORG_COMMON_LABEL_FOOTER_INFO_WIDTH * oringin_ratio;
//--- 決済
    INFO_LABEL_COL1_WIDTH = ORG_INFO_LABEL_COL1_WIDTH * oringin_ratio;
    INFO_LABEL_COL2_WIDTH = ORG_INFO_LABEL_COL2_WIDTH * oringin_ratio;
//     INFO_LABEL_COL3_WIDTH = ORG_INFO_LABEL_COL3_WIDTH * oringin_ratio;
    INFO_LABEL_HEIGHT = ORG_INFO_LABEL_HEIGHT * oringin_ratio;
    INFO_FOOTER_INDENT_ROW = ORG_INFO_FOOTER_INDENT_ROW * oringin_ratio;
    INFO_BUTTON1_WIDTH = ORG_INFO_BUTTON1_WIDTH * oringin_ratio;
    INFO_BUTTON1_HEIGHT = ORG_INFO_BUTTON1_HEIGHT * oringin_ratio;
    INFO_BUTTON2_WIDTH = ORG_INFO_BUTTON2_WIDTH * oringin_ratio;
    INFO_BUTTON2_HEIGHT = ORG_INFO_BUTTON2_HEIGHT * oringin_ratio;
   //--- ポジション一覧
   POSITION_LABEL_COL1_WIDTH = ORG_POSITION_LABEL_COL1_WIDTH * oringin_ratio;
   POSITION_LABEL_HEIGHT = ORG_POSITION_LABEL_HEIGHT * oringin_ratio;
   POSITION_BUTTON1_WIDTH = ORG_POSITION_BUTTON1_WIDTH * oringin_ratio;
   POSITION_BUTTON1_HEIGHT = ORG_POSITION_BUTTON1_HEIGHT * oringin_ratio;
   POSITION_BUTTON2_WIDTH = ORG_POSITION_BUTTON2_WIDTH * oringin_ratio;
   POSITION_BUTTON2_HEIGHT = ORG_POSITION_BUTTON2_HEIGHT * oringin_ratio;
   POSITION_BUTTON3_WIDTH = ORG_POSITION_BUTTON3_WIDTH * oringin_ratio;
   POSITION_BUTTON3_HEIGHT = ORG_POSITION_BUTTON3_HEIGHT * oringin_ratio;
   POSITION_BUTTON4_WIDTH = ORG_POSITION_BUTTON4_WIDTH * oringin_ratio;
   POSITION_BUTTON4_HEIGHT = ORG_POSITION_BUTTON4_HEIGHT * oringin_ratio;
   POSITION_EDIT1_WIDTH = ORG_POSITION_EDIT1_WIDTH * oringin_ratio;
   POSITION_EDIT1_HEIGHT = ORG_POSITION_EDIT1_HEIGHT * oringin_ratio;
//---
//--- line labels
    LINE_LABEL1_X = ORG_LINE_LABEL1_X * oringin_ratio;
   //  LINE_LABEL2_X = ORG_LINE_LABEL2_X * oringin_ratio_not_zoom;
//     LINE_LABEL2_2_X = ORG_LINE_LABEL2_2_X * oringin_ratio_not_zoom;
//     LINE_LABEL3_X = ORG_LINE_LABEL3_X * oringin_ratio_not_zoom;
    LINE_LABEL1_WIDTH = ORG_LINE_LABEL1_WIDTH * oringin_ratio;
    LINE_LABEL1_HEIGHT = ORG_LINE_LABEL1_HEIGHT * oringin_ratio;
   //  LINE_LABEL2_WIDTH = ORG_LINE_LABEL2_WIDTH * oringin_ratio_not_zoom;
   //  LINE_LABEL2_HEIGHT = ORG_LINE_LABEL2_HEIGHT * oringin_ratio_not_zoom;
   //  LINE_LABEL3_WIDTH = ORG_LINE_LABEL3_WIDTH * oringin_ratio_not_zoom;
   //  LINE_LABEL3_HEIGHT = ORG_LINE_LABEL3_HEIGHT * oringin_ratio_not_zoom;

//--- position labels
    POSITION_LABEL1_WIDTH = ORG_POSITION_LABEL1_WIDTH * oringin_ratio;
    POSITION_LABEL1_HEIGHT = ORG_POSITION_LABEL1_HEIGHT * oringin_ratio;
    POSITION_LABEL2_WIDTH = ORG_POSITION_LABEL2_WIDTH * oringin_ratio;
    POSITION_LABEL2_HEIGHT = ORG_POSITION_LABEL2_HEIGHT * oringin_ratio;

   POSITION_MENU_CLOSE_WIDTH = ORG_POSITION_MENU_CLOSE_WIDTH * oringin_ratio;
   POSITION_MENU_CLOSE_HEIGHT = ORG_POSITION_MENU_CLOSE_HEIGHT * oringin_ratio;

//--- position menu
   POSITION_MENU_MAIN_WIDTH = ORG_POSITION_MENU_MAIN_WIDTH * oringin_ratio;
   POSITION_MENU_MAIN_HEIGHT = ORG_POSITION_MENU_MAIN_HEIGHT * oringin_ratio;
   POSITION_MENU_SUB_WIDTH = ORG_POSITION_MENU_SUB_WIDTH * oringin_ratio;
   POSITION_MENU_SUB_HEIGHT_01 = ORG_POSITION_MENU_SUB_HEIGHT_01 * oringin_ratio;
   POSITION_MENU_SUB_HEIGHT_02 = ORG_POSITION_MENU_SUB_HEIGHT_02 * oringin_ratio;
   POSITION_MENU_SUB_ROW_INDENT = ORG_POSITION_MENU_SUB_ROW_INDENT * oringin_ratio;
   POSITION_MENU_SUB_COL_INDENT = ORG_POSITION_MENU_SUB_COL_INDENT * oringin_ratio;
   POSITION_MENU_SUB_LABEL_WIDTH = ORG_POSITION_MENU_SUB_LABEL_WIDTH * oringin_ratio;
   POSITION_MENU_SUB_LABEL_HEIGHT = ORG_POSITION_MENU_SUB_LABEL_HEIGHT * oringin_ratio;
   POSITION_MENU_SUB_EDIT_WIDTH = ORG_POSITION_MENU_SUB_EDIT_WIDTH * oringin_ratio;
   POSITION_MENU_SUB_EDIT_HEIGHT = ORG_POSITION_MENU_SUB_EDIT_HEIGHT * oringin_ratio;
   POSITION_MENU_SUB_BUTTON_WIDTH = ORG_POSITION_MENU_SUB_BUTTON_WIDTH * oringin_ratio;
   POSITION_MENU_SUB_BUTTON_HEIGHT = ORG_POSITION_MENU_SUB_BUTTON_HEIGHT * oringin_ratio;

   LINE_CANDLETIME_WIDTH = ORG_LINE_CANDLETIME_WIDTH * oringin_ratio;
   LINE_CANDLETIME_HEIGHT = ORG_LINE_CANDLETIME_HEIGHT * oringin_ratio;

//-- graph
   GRAPH_PANEL_MAIN_WIDTH = ORG_GRAPH_PANEL_MAIN_WIDTH * oringin_ratio;
   GRAPH_PANEL_MAIN_HEIGHT = ORG_GRAPH_PANEL_MAIN_HEIGHT * oringin_ratio;
   GRAPH_PANEL_CANVAS_HEIGTH = ORG_GRAPH_PANEL_CANVAS_HEIGHT * oringin_ratio;
   GRAPH_PANEL_LABEL_WIDTH = ORG_GRAPH_PANEL_LABEL_WIDTH * oringin_ratio;   
   
//--- 画面に1.5インチの幅のボタンを作成します
   double screen_dpi = TerminalInfoInteger(TERMINAL_SCREEN_DPI); // ユーザーのモニターのDPIを取得します
   double base_width = 144;                                     // DPI=96の標準モニターの画面のドットの基本の幅
   oringin_ratio      = 96 / screen_dpi*getZoomRate(zoom_rate_select);         // ユーザーモニター（DPIを含む）のボタンの幅を計算します
   oringin_ratio_not_zoom= 96 / screen_dpi;

   my_caption_FontSize   = ORG_my_caption_FontSize   * oringin_ratio;
   menu_FontSize         = ORG_menu_FontSize         * oringin_ratio;
   trade_main_FontSize   = ORG_trade_main_FontSize   * oringin_ratio;
   trade_price_FontSize  = ORG_trade_price_FontSize  * oringin_ratio;
   common_FontSize       = ORG_common_FontSize       * oringin_ratio;
   line_FontSize         = ORG_line_FontSize         * oringin_ratio;

   // 損失率をパラメーターからコピー
   if(!MaxLossMarginPercent)
      MaxLossMarginPercent = ORG_MaxLossMarginPercent;

}

bool CAppWindowSelTradingTool::OnDialogDragStart(void)
  {
   bool ret = CAppDialog::OnDialogDragStart();

//--- succeed
   return(true);
  }

bool CAppWindowSelTradingTool::OnDialogDragProcess(void)
{
   CAppDialog::OnDialogDragProcess();
   
   if(graph_panel_set_flg==1)
     {
      int x = m_graph_main_panel.Left() + BODY_INDENT_LEFT;
      int y = m_graph_main_panel.Top() + GRAPH_INDENT_TOP + POSITION_MENU_SUB_BUTTON_HEIGHT + BODY_INDENT_ROW/2;
      ObjectSetInteger(ChartID(),"m_graph_pfGraphic",OBJPROP_XDISTANCE,x);
      ObjectSetInteger(ChartID(),"m_graph_pfGraphic",OBJPROP_YDISTANCE,y);
     }   
   
   my_caption.Move(Left()+CAPTION_LEFT,Top()+CAPTION_TOP);
   
   return(true);
}
//+------------------------------------------------------------------+
//| End dragging the dialog box                                      |
//+------------------------------------------------------------------+
bool CAppWindowSelTradingTool::OnDialogDragEnd(void)
  {
   CAppDialog::OnDialogDragEnd();
   
   if(graph_panel_set_flg==1)
     {
      CreateSubGraph();  
     }     
   //my_caption.Height(CAPTION_H);
   //my_caption.Width(CAPTION_W);
   //my_caption.Top(CAPTION_TOP);
   //my_caption.Left(CAPTION_LEFT);
   my_caption.Move(Left()+CAPTION_LEFT,Top()+CAPTION_TOP);

//--- succeed
   return(true);
  }
  
void CAppWindowSelTradingTool::OnCalculateMAStop()
  {   
   for(int i=ArraySize(_positionMAStopSets)-1;i>=0;i--)
     {
      if(!m_position.SelectByTicket(_positionMAStopSets[i].ticket))
        {
         ArrayRemove(_positionMAStopSets,i,1);
         continue; 
        }
      
      if(m_position.TakeProfit()>0)
        {
         _positionMAStopSets[i].maTpFlg=false;
        }
      if(m_position.StopLoss()>0)
        {
         _positionMAStopSets[i].maSlFlg=false;
        }
          
      if(_positionMAStopSets[i].maTpFlg)
        {
         int handle=FirstOrCreateMAIndicator(_positionMAStopSets[i].timeframe,_positionMAStopSets[i].maTpPeriod,_positionMAStopSets[i].maTpMethod);
         if(handle!=INVALID_HANDLE)
           {
            double ma[2];
            double close[2];
            
            close[0]=InpMAStopOnBarClose?iClose(_Symbol,_positionMAStopSets[i].timeframe,1):iClose(_Symbol,_positionMAStopSets[i].timeframe,0);
            close[1]=InpMAStopOnBarClose?iClose(_Symbol,_positionMAStopSets[i].timeframe,2):iClose(_Symbol,_positionMAStopSets[i].timeframe,1);
            
            ResetLastError();
            if(CopyBuffer(handle,0,InpMAStopOnBarClose?1:0,2,ma)==2)
              {
               if((m_position.PositionType()==POSITION_TYPE_BUY && close[1]<ma[1] && close[0]>=ma[0]) ||
                  (m_position.PositionType()==POSITION_TYPE_SELL && close[1]>ma[1] && close[0]<=ma[0]))
                 {
                  m_trade.PositionClose(_positionMAStopSets[i].ticket);
                 }
              }
            else  
              {
               //--- if the copying fails, tell the error code
               PrintFormat("MA TP: Failed to copy data from the iMA indicator, error code %d",GetLastError());
              }
           }
         else  
           {
            Print("MA TP: Invalid indicator handle!");
           }            
        }
      
      if(_positionMAStopSets[i].maSlFlg)
        {
         int handle=FirstOrCreateMAIndicator(_positionMAStopSets[i].timeframe,_positionMAStopSets[i].maSlPeriod,_positionMAStopSets[i].maSlMethod);
         if(handle!=INVALID_HANDLE)
           {
            double ma[2];
            double close[2];
            
            close[0]=InpMAStopOnBarClose?iClose(_Symbol,_positionMAStopSets[i].timeframe,1):iClose(_Symbol,_positionMAStopSets[i].timeframe,0);
            close[1]=InpMAStopOnBarClose?iClose(_Symbol,_positionMAStopSets[i].timeframe,2):iClose(_Symbol,_positionMAStopSets[i].timeframe,1);
            
            ResetLastError();
            if(CopyBuffer(handle,0,InpMAStopOnBarClose?1:0,2,ma)==2)
              {
               if((m_position.PositionType()==POSITION_TYPE_BUY && close[1]>ma[1] && close[0]<=ma[0]) ||
                  (m_position.PositionType()==POSITION_TYPE_SELL && close[1]<ma[1] && close[0]>=ma[0]))
                 {
                  m_trade.PositionClose(_positionMAStopSets[i].ticket);
                 }
              }
            else  
              {
               //--- if the copying fails, tell the error code
               PrintFormat("MA SL: Failed to copy data from the iMA indicator, error code %d",GetLastError());
              }
           }
         else  
           {
            Print("MA SL: Invalid indicator handle!");
           }   
        }
     }
  }  

  
void CAppWindowSelTradingTool::OnCalculateTrailingStop(void)
  {
   m_symbolInfo.RefreshRates();
   
   for(int i=ArraySize(_positionTrailingStopSets)-1;i>=0;i--)
     {
      if(!m_position.SelectByTicket(_positionTrailingStopSets[i].ticket))
        {
         ArrayRemove(_positionTrailingStopSets,i,1);
         continue; 
        }
       
      double stopPriceLevel=m_symbolInfo.StopsLevel()*_Point;
      double newStopPriceLevel=0;
      
      if(m_position.PositionType()==POSITION_TYPE_BUY)
        {
         newStopPriceLevel=m_symbolInfo.Bid()-stopPriceLevel;
         if(newStopPriceLevel>m_position.PriceOpen()+PipsToPrice(_positionTrailingStopSets[i].targetPips) && (m_position.StopLoss()==0 || newStopPriceLevel>m_position.StopLoss()))
           {
            m_trade.PositionModify(_positionTrailingStopSets[i].ticket,newStopPriceLevel,m_position.TakeProfit());
           }
        }
      else if(m_position.PositionType()==POSITION_TYPE_SELL)
        {
         newStopPriceLevel=m_symbolInfo.Ask()+stopPriceLevel;
         if(newStopPriceLevel<m_position.PriceOpen()-PipsToPrice(_positionTrailingStopSets[i].targetPips) && (m_position.StopLoss()==0 || newStopPriceLevel<m_position.StopLoss()))
           {
            m_trade.PositionModify(_positionTrailingStopSets[i].ticket,newStopPriceLevel,m_position.TakeProfit());
           }   
        }
     }
  }  

bool CAppWindowSelTradingTool::LoadPositionMAStopSets(void)
  {
   string fileName=_fileName_positionMAStopSets+"_"+IntegerToString(ChartID())+".csv";
   
   int fh = FileOpen(fileName, FILE_READ|FILE_ANSI|FILE_CSV, ',');
   if (fh == INVALID_HANDLE)
     {
      PrintFormat("Failed to open %s file, Error code = %d",fileName,GetLastError()); 
      return(false);
     }
     
   int total=0;
   
   while(!FileIsEnding(fh))
     {
      if(IsStopped())   break;
      
      string symbol=FileReadString(fh);
      ulong ticket=StringToInteger(FileReadString(fh));
      ENUM_TIMEFRAMES timeframe=(ENUM_TIMEFRAMES)StringToInteger(FileReadString(fh));
      bool maTpFlg=FileReadBool(fh);
      int maTpPeriod=(int)StringToInteger(FileReadString(fh));
      ENUM_MA_METHOD maTpMethod=(ENUM_MA_METHOD)StringToInteger(FileReadString(fh));
      bool maSlFlg=FileReadBool(fh);
      int maSlPeriod=(int)StringToInteger(FileReadString(fh));
      ENUM_MA_METHOD maSlMethod=(ENUM_MA_METHOD)StringToInteger(FileReadString(fh));
      
      if(symbol!=_Symbol)
         continue;

      total++;

      if(ArraySize(_positionMAStopSets)<total)
         ArrayResize(_positionMAStopSets,total,10);
                     
      _positionMAStopSets[total-1].ticket=ticket;
      _positionMAStopSets[total-1].timeframe=timeframe;
      _positionMAStopSets[total-1].maTpFlg=maTpFlg;
      _positionMAStopSets[total-1].maTpPeriod=maTpPeriod;
      _positionMAStopSets[total-1].maTpMethod=maTpMethod;
      _positionMAStopSets[total-1].maSlFlg=maSlFlg;
      _positionMAStopSets[total-1].maSlPeriod=maSlPeriod;
      _positionMAStopSets[total-1].maSlMethod=maSlMethod;
     }
     
   ArrayResize(_positionMAStopSets,total,10);
   
   FileClose(fh);   
   FileDelete(fileName);
   //---
   return(true);
  }
  
bool CAppWindowSelTradingTool::SavePositionMAStopSets(void)
  {
   string fileName=_fileName_positionMAStopSets+"_"+IntegerToString(ChartID())+".csv";
   
   int fh = FileOpen(fileName, FILE_WRITE|FILE_ANSI|FILE_CSV, ',');
   if (fh == INVALID_HANDLE)
     {
      PrintFormat("Failed to open %s file, Error code = %d",fileName,GetLastError()); 
      return(false);
     }
     
   for(int i=0;i<ArraySize(_positionMAStopSets);i++)
     {
      ulong ticket=_positionMAStopSets[i].ticket;
      int timeframe=_positionMAStopSets[i].timeframe;
      bool maTpFlg=_positionMAStopSets[i].maTpFlg;
      int maTpPeriod=_positionMAStopSets[i].maTpPeriod;
      int maTpMethod=_positionMAStopSets[i].maTpMethod;
      bool maSlFlg=_positionMAStopSets[i].maSlFlg;
      int maSlPeriod=_positionMAStopSets[i].maSlPeriod;
      int maSlMethod=_positionMAStopSets[i].maSlMethod;
      
      FileWrite(fh,_Symbol,ticket,timeframe,maTpFlg,maTpPeriod,maTpMethod,maSlFlg,maSlPeriod,maSlMethod);
     }
     
   FileClose(fh);
   //---
   return(true);
  }
  
bool CAppWindowSelTradingTool::LoadPositionTrailingStopSets(void)
  {
   string fileName=_fileName_positionTrailingStopSets+"_"+IntegerToString(ChartID())+".csv";
   
   int fh = FileOpen(fileName, FILE_READ|FILE_ANSI|FILE_CSV, ',');
   if (fh == INVALID_HANDLE)
     {
      PrintFormat("Failed to open %s file, Error code = %d",fileName,GetLastError()); 
      return(false);
     }
     
   int total=0;
   
   while(!FileIsEnding(fh))
     {
      if(IsStopped())   break;
      
      string symbol=FileReadString(fh);
      ulong ticket=StringToInteger(FileReadString(fh));
      double targetPips=StringToDouble(FileReadString(fh));
      
      if(symbol!=_Symbol)
         continue;
      
      total++;

      if(ArraySize(_positionTrailingStopSets)<total)
         ArrayResize(_positionTrailingStopSets,total,10);
               
      _positionTrailingStopSets[total-1].ticket=ticket;
      _positionTrailingStopSets[total-1].targetPips=targetPips;
     }
     
   ArrayResize(_positionTrailingStopSets,total,10);
   
   FileClose(fh);   
   FileDelete(fileName);
   //---
   return(true);
  }
  
bool CAppWindowSelTradingTool::SavePositionTrailingStopSets(void)
  {
   string fileName=_fileName_positionTrailingStopSets+"_"+IntegerToString(ChartID())+".csv";
   
   int fh = FileOpen(fileName, FILE_WRITE|FILE_ANSI|FILE_CSV, ',');
   if (fh == INVALID_HANDLE)
     {
      PrintFormat("Failed to open %s file, Error code = %d",fileName,GetLastError()); 
      return(false);
     }
     
   for(int i=0;i<ArraySize(_positionTrailingStopSets);i++)
     {
      ulong ticket=_positionTrailingStopSets[i].ticket;
      double targetPips=_positionTrailingStopSets[i].targetPips;
      
      FileWrite(fh,_Symbol,ticket,DoubleToString(targetPips,1));
     }
     
   FileClose(fh);
   //---
   return(true);
  }     
  
struct IndicatorMA
  {
   IndicatorMA()
      : handle(INVALID_HANDLE)
      , timeframe(0)
      , period(20)
      , method(MODE_SMA)
     {}
     
   int               handle;   
   ENUM_TIMEFRAMES   timeframe;
   int               period;
   ENUM_MA_METHOD    method;
  };
  
IndicatorMA _IndMAs[];

bool  _eaFirstTimeAttached=true;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   CalcDp();

   // ストラテジーテスターかどうか
   is_tester = MQLInfoInteger(MQL_TESTER);
   if(is_tester)
   {
      printf("is_tester : true");
   }
   else
   {
      printf("is_tester : false");
   }

   // 口座通貨
   currency=AccountInfoString(ACCOUNT_CURRENCY);

   // 許可している口座か
   if(!chkTradeAccount())
   {
      printf("Error Account Error");
      return(INIT_FAILED);
   }
   // EAが使用できる口座か
   /*if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
   {
      printf("Error Account TRADE Not Allow");
      return(INIT_FAILED);
   }*/
   // Tickの取得ができる事
   if(!SymbolInfoTick(_Symbol,latest_price))
   {
      printf("Error getting the latest price quote");
      return(INIT_FAILED);
   }

   // シンボル情報取得
   symbolInfo_filling_type = SymbolInfoInteger(_Symbol, SYMBOL_FILLING_MODE);
   if(symbolInfo_filling_type==2)
   {
      order_filling_type = ORDER_FILLING_IOC;
   }
   else
   {
      order_filling_type = ORDER_FILLING_FOK;
   }

   // 過去ローソク100本取得できる
   int copied=CopyRates(Symbol(),0,0,100,rates);
   if(copied<=0)
   {
      Alert("Error getting the CopyRates - error:",GetLastError(),"!!");
      ResetLastError();
      return false;
   }
   if(!ArraySetAsSeries(rates,true))
   {
      return false;
   }
   // 分足を変更しても実行されて数値がリセットされてしまう問題を回避
   // シンボルが変わった場合はクリアする
   bool reCalc=false;
   if(lastSymbol != _Symbol){
      ep = NULL;
      lastSymbol = _Symbol;
      reCalc=true;
   }
   if(!ep){
      last_alerm_tp = rates[0].time - 1;
      last_alerm_sl = rates[0].time - 1;

      // 計算初期値を設定する
      ep = latest_price.ask;
      // double maxp = ChartGetDouble(0, CHART_PRICE_MAX);
      // double minp = ChartGetDouble(0, CHART_PRICE_MIN);
      // double diff = MathMin((maxp-ep)/2, (ep-minp)/2);
      // tp = NormalizeDouble(ep + PipsToPrice(diff), _Digits);
      // sl = NormalizeDouble(ep - PipsToPrice(diff), _Digits);

      long stoplevel;
      if(!SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL, stoplevel))
      {
         Alert("Error getting the stoplevel - error:",GetLastError(),"!!");
         ResetLastError();
         return false;
      }
      tp = NormalizeDouble(ep + (stoplevel * _Point), _Digits);
      sl = NormalizeDouble(ep - (stoplevel * _Point), _Digits);
   }


   if(auto_manual_flg==1 && reCalc)
      Lot = calcLot(ep, sl, 0);
   
   //---
   graphSymbol=_Symbol;
   graphPeriod=MONTH;
   
   //--- create application line
   // 水平線
   if(!ExtDialog.CreateLine())
      return(INIT_FAILED);
   //--- create application dialog
   // if(!ExtDialog.Create(0,TOOL_NAME+"("+_Symbol+")"+" SP:-",0,BASE_LEFT,BASE_TOP,BASE_WIDTH,BASE_HEIGHT))
   if(dialogMminimized){
      if(!ExtDialog.Create(0,"SEMI AUTOMATIC TRADE",0,BASE_LEFT,BASE_TOP,BASE_WIDTH,BASE_TOP+DIALOG_MIN_H))
         return(INIT_FAILED);
   }else{
      if(!ExtDialog.Create(0,"SEMI AUTOMATIC TRADE",0,BASE_LEFT,BASE_TOP,BASE_WIDTH,BASE_HEIGHT))
         return(INIT_FAILED);
   }
   //--- run application
   ExtDialog.Run();
   //--- timer開始
   if(!EventSetMillisecondTimer(
      calc_timer_ms      // ミリ秒数
   ))
      return(INIT_FAILED);
   //---
   //ChartSetInteger(ChartID(),CHART_EVENT_MOUSE_MOVE,true);

   //--- succeed
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
//---
   Comment("");
//--- destroy dialog
   ExtDialog.Destroy(reason);
   // line削除
   ObjectsDeleteAll(
      0,  // チャート識別子
      LINE_NAME_PREFIX,  // オブジェクト名のプレフィックス
      -1,  // ウィンドウ番号
      -1   // オブジェクトの型
   );
   // sat削除
   ObjectsDeleteAll(
      0,  // チャート識別子
      SAT_NAME_PREFIX,  // オブジェクト名のプレフィックス
      -1,  // ウィンドウ番号
      -1   // オブジェクトの型
   );
   // ポジションごとのボタン削除  
   ObjectsDeleteAll(
      0,  // チャート識別子
      POSITION_NAME_PREFIX,  // オブジェクト名のプレフィックス
      -1,  // ウィンドウ番号
      -1   // オブジェクトの型
   );   
   //---
   EventKillTimer();   
   //---
   for(int i=0;i<ArraySize(_IndMAs);i++)
     {
      if(_IndMAs[i].handle!=INVALID_HANDLE)
        {
         IndicatorRelease(_IndMAs[i].handle);
         _IndMAs[i].handle=INVALID_HANDLE;
        }
     }
}
//+------------------------------------------------------------------+
//| Expert chart event function                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID  
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {
      // Print("OnChartEvent ", id, " ", lparam, " ", dparam, " ", sparam, " ", CHARTEVENT_OBJECT_CLICK);
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, SYMBOL_MENU_NAME_PREFIX) != -1){
         string strItemText = ObjectGetString(0, sparam, OBJPROP_TEXT);
         string strSymbolArr[];
         StringSplit(strItemText,' ',strSymbolArr);
         
         if(ArraySize(strSymbolArr)>0 && strSymbolArr[0]!="")
           {
            Print("ClickPopupMenuItem, Symbol = " + strSymbolArr[0]); 
            ChartSetSymbolPeriod(ChartID(), strSymbolArr[0], PERIOD_CURRENT);
           }
           
         return;
      }
      
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, GRAPH_SYMBOL_MENU_NAME_PREFIX) != -1){
         string strSymbol = ObjectGetString(0, sparam, OBJPROP_TEXT);
         
         if(strSymbol!="")
           {
            Print("ClickGraphPopupMenuItem, Symbol = " + strSymbol);
            graphSymbol=strSymbol; 
            ExtDialog.UpdateGraph();
           }
         
         return;
      }
      
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, LABEL_REVERSE_ICON_NAME) != -1){
         double tp=ObjectGetDouble(0,HLINE_TP_NAME,OBJPROP_PRICE);
         double sl=ObjectGetDouble(0,HLINE_SL_NAME,OBJPROP_PRICE);
         ObjectSetDouble(0,HLINE_TP_NAME,OBJPROP_PRICE,sl);
         ObjectSetDouble(0,HLINE_SL_NAME,OBJPROP_PRICE,tp);
         return;
      }
      
      /*
      if ((id == CHARTEVENT_CUSTOM + ON_DRAG_END) && (lparam == -1))
      {
         ExtDialog.remember_top = ExtDialog.Top();
         ExtDialog.remember_left = ExtDialog.Left();
         
         Print("-------- ", ExtDialog.remember_left," , ", ExtDialog.remember_top);
      }
      if(id == CHARTEVENT_OBJECT_CLICK || id== CHARTEVENT_CUSTOM)// test code by kihm0426
       {
         Print(sparam, ", ", id); 
       }*/
      
      if (!ExtDialog.ChkAxesOnPopupPanel(lparam, dparam))
        {         
         ExtDialog.ChartEvent(id,lparam,dparam,sparam);
        }
          
      // ポジションメニュー表示
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, POSITION_NAME_PREFIX + "_button_") == 0){
         ExtDialog.CreatePositionMenu(lparam, dparam, sparam);
      }
      // tp削除
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, POSITION_TP_NAME_PREFIX) == 0){
         ExtDialog.RemovePositionTp(lparam, dparam, sparam);
      }
      // sl削除
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, POSITION_SL_NAME_PREFIX) == 0){
         ExtDialog.RemovePositionSl(lparam, dparam, sparam);
      }
      // order削除
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, POSITION_ORDER_NAME_PREFIX) == 0){
         ExtDialog.RemoveOrder(lparam, dparam, sparam);
      }
      // ダイアログ再描き
      if(id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, "Caption") != -1){
         if (!dialogMminimized) {
            ExtDialog.Hide();         
            ExtDialog.Show();
         }
      }
      // オンマウスで色変換の検知用
      if(id == CHARTEVENT_MOUSE_MOVE){
         ExtDialog.ChkOnMouse(lparam, dparam, sparam);
      }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      ExtDialog.OnTick();

  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert trade function                                             |
//+------------------------------------------------------------------+
// void OnTrade()
// {
//    Print("OnTrade----------------------------------------------------");
//    HistorySelect(0,TimeCurrent());
//    uint     total=HistoryDealsTotal();
//    ulong    ticket=0;
//    double   price;
//    double   profit;
//    datetime time;
//    string   symbol;
//    long     type;
//    long     entry;
//    for(uint i=0;i<total;i++)
//    {
//       //--- 約定チケットの取得を試みる
//       if((ticket=HistoryDealGetTicket(i))>0)
//       {
//          //--- 約定プロパティを取得する
//          price =HistoryDealGetDouble(ticket,DEAL_PRICE);
//          time  =(datetime)HistoryDealGetInteger(ticket,DEAL_TIME);
//          symbol=HistoryDealGetString(ticket,DEAL_SYMBOL);
//          type  =HistoryDealGetInteger(ticket,DEAL_TYPE);
//          entry =HistoryDealGetInteger(ticket,DEAL_ENTRY);
//          profit=HistoryDealGetDouble(ticket,DEAL_PROFIT);
//          //--- 現在のシンボルのみ
//          if(price && time && symbol==Symbol())
//          {
//             Print(ticket, " ", time, " ", type, " ", entry);
//          }
//       }
//    }
// }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTimer()
  {
      ExtDialog.OnTimer();
  }

//+------------------------------------------------------------------+

bool chkTradeAccount()
{
   if(!accountControlEnable)
   {
      return true;
   }

   if(is_tester)
   {
      return true;
   }

   int account_no = AccountInfoInteger(ACCOUNT_LOGIN);

   int Size=ArraySize(accountList);
   for(int i=0;i<Size;i++){
      if(accountList[i]==account_no)
         return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| 勝率など計算する関数
//+------------------------------------------------------------------+
void CalcInfo()
{
   // 基本情報の設定
   sp = latest_price.ask - latest_price.bid;
   // トレード方向の確認
   if(tp >= sl)
      order_type = ORDER_TYPE_BUY;
   else
      order_type = ORDER_TYPE_SELL;
   // ロット計算
   if(auto_manual_flg==1)
   {
      Lot = calcLot(ep, sl, 0);
   }
   // ep計算
   if(
      trade_mode==1     // 成行
      || trace_mode==2  // 追従モード
   ){
      if(order_type == ORDER_TYPE_BUY){
         ep = latest_price.ask;
      }else{
         ep = latest_price.bid;
      }
   }

   // 利益など計算
   if(order_type == ORDER_TYPE_BUY){
      tp_pips = PriceToPips(tp - ep);
      sl_pips = PriceToPips(ep - sl);
   }else{
      tp_pips = PriceToPips(ep - tp);
      sl_pips = PriceToPips(sl - ep);
   }
   if(sl_pips==0){
      plslrate=0;
      winrate=0;
   }else{
      plslrate = DoubleToString(tp_pips/sl_pips, 2);
      if((tp_pips/sl_pips+1)==0){
         winrate=0;
      }else{
         winrate = DoubleToString(1/(tp_pips/sl_pips+1)*100, 1);
      }
   }
   if(!OrderCalcProfit(
      order_type,          // 注文の種類 （ORDER_TYPE_BUY または ORDER_TYPE_SELL）
      _Symbol,          // 銘柄名
      Lot,              // ボリューム
      ep,      // 始値
      tp,      // 終値
      plplan            // 利益値の取得に使用される変数
   ))
      plplan = 0;
   if(!OrderCalcProfit(
      order_type,          // 注文の種類 （ORDER_TYPE_BUY または ORDER_TYPE_SELL）
      _Symbol,          // 銘柄名
      Lot,              // ボリューム
      ep,      // 始値
      sl,      // 終値
      slplan            // 利益値の取得に使用される変数
   ))
      slplan = 0;
   
   // 再描画（数値変更反映）
   ExtDialog.ReDraw();
}

void CalcProfitPoints(double& x[], double& y[])
{  
   datetime initTime=0;
   MqlDateTime mqlDatetime;
   TimeToStruct(TimeCurrent(),mqlDatetime);         
   
   if(graphPeriod==DAY) {
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
   else if(graphPeriod==MONTH) {
      mqlDatetime.day=1;
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
   else if(graphPeriod==YEAR) {
      mqlDatetime.mon=1;
      mqlDatetime.day=1;
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
     
   initTime=StructToTime(mqlDatetime);
   
   int total = 1;
   ArrayResize(x,1,100);
   ArrayResize(y,1,100);
   x[0]=initTime;
   y[0]=0;
     
   if (HistorySelect(initTime, TimeCurrent()))
   {
      for (int i = 0; i <HistoryDealsTotal(); i++)
      {
        const ulong ticket = HistoryDealGetTicket(i);
        
        if((graphSymbol=="全銘柄" || HistoryDealGetString(ticket, DEAL_SYMBOL) == graphSymbol) && HistoryDealGetInteger(ticket,DEAL_ENTRY)==DEAL_ENTRY_OUT)
         {              
            total++;            
            
            if(ArraySize(x)<total)
               ArrayResize(x,total,100);
            if(ArraySize(y)<total)
               ArrayResize(y,total,100);
  
            x[total-1] = (double)HistoryDealGetInteger(ticket, DEAL_TIME);   
            y[total-1] = HistoryDealGetDouble(ticket, DEAL_PROFIT) + (total > 1 ? y[total-2] : 0);
            
            if(total>1 && y[total-2] * y[total-1] < 0)
              {
               total++;            
            
               if(ArraySize(x)<total)
                  ArrayResize(x,total,100);
               if(ArraySize(y)<total)
                  ArrayResize(y,total,100);
                  
               x[total-1] = x[total-2];
               y[total-1] = y[total-2];
               y[total-2] = 0;
              }
         }
      }
   }   
}

void CalcProfitStatistics(PROFIT_STATISTICS& pfStatistics)
{
   datetime initTime=0;
   MqlDateTime mqlDatetime;
   TimeToStruct(TimeCurrent(),mqlDatetime);         
   
   if(graphPeriod==DAY) {
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
   else if(graphPeriod==MONTH) {
      mqlDatetime.day=1;
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
   else if(graphPeriod==YEAR) {
      mqlDatetime.mon=1;
      mqlDatetime.day=1;
      mqlDatetime.hour=0;
      mqlDatetime.min=0;
      mqlDatetime.sec=0;
   }
   
   initTime=StructToTime(mqlDatetime);
   
   if (HistorySelect(initTime, TimeCurrent()))
   {
      double totalProfitAmt = 0;
      double totalLossAmt = 0;
      int longWinTrades = 0;
      int shortWinTrades = 0;
      
      for (int i = 0; i <HistoryDealsTotal(); i++)
      {
        const ulong ticket = HistoryDealGetTicket(i);
        
        if((graphSymbol=="全銘柄" || HistoryDealGetString(ticket, DEAL_SYMBOL) == graphSymbol) && HistoryDealGetInteger(ticket,DEAL_ENTRY)==DEAL_ENTRY_OUT)
         {
            pfStatistics.totalTrades++;
            
            double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
            if(profit >= 0.f)
               totalProfitAmt += profit;
            else
               totalLossAmt += profit;                  
            pfStatistics.totalProfit += profit;
            
            pfStatistics.maxDrawdown = MathMin(pfStatistics.maxDrawdown, pfStatistics.totalProfit);
            
            if(HistoryDealGetInteger(ticket,DEAL_TYPE)==DEAL_TYPE_SELL)
              {
               pfStatistics.longTrades++;
               if (profit >= 0.f)
                  longWinTrades++;   
              }
            else if(HistoryDealGetInteger(ticket,DEAL_TYPE)==DEAL_TYPE_BUY)
              {
               pfStatistics.shortTrades++;
               if (profit >= 0.f)
                  shortWinTrades++;
              }
         }
      }
      
      pfStatistics.longTradesWinPercent = pfStatistics.longTrades == 0 ? 0 : ((double)longWinTrades / pfStatistics.longTrades) * 100;
      pfStatistics.shortTradesWinPercent = pfStatistics.shortTrades == 0 ? 0 : ((double)shortWinTrades / pfStatistics.shortTrades) * 100;
      pfStatistics.profitFactor = totalLossAmt == 0 ? 0 : (MathAbs((double)totalProfitAmt / totalLossAmt));
      pfStatistics.maxDrawdownPercent = AccountInfoDouble(ACCOUNT_BALANCE) == 0 ? 0 : pfStatistics.maxDrawdown / AccountInfoDouble(ACCOUNT_BALANCE) * 100;
   }   
}
//+------------------------------------------------------------------+
//| 水平線ブレイクで音を鳴らす関数
//+------------------------------------------------------------------+
void ChkAlerm(){
   if(
      alerm_set_flg==1
   ){
      // 水平線が移動しているか確認する
      if(
         last_tp != tp
         || last_sl != sl
      ){
         last_tp = tp;
         last_sl = sl;
         last_line_fix_time = GetTickCount();
         return ;
      }
      // 水平線が移動しなくなってから1秒経過しているか確認する
      if(GetTickCount() - last_line_fix_time <= 1000){
         return ;
      }

      bool playTpFlg = false, playSlFlg = false;
      if(order_type == ORDER_TYPE_BUY){
         if(
            last_alerm_tp < rates[0].time
            && rates[0].open < tp
            && rates[0].high > tp
         ){
            playTpFlg = true;
         }
         if(
            last_alerm_sl < rates[0].time
            && rates[0].open > sl
            && rates[0].low < sl
         ){
            playSlFlg = true;
         }
      }else{
         if(
            last_alerm_sl < rates[0].time
            && rates[0].open < sl
            && rates[0].high > sl
         ){
            playSlFlg = true;
         }
         if(
            last_alerm_tp < rates[0].time
            && rates[0].open > tp
            && rates[0].low < tp
         ){
            playTpFlg = true;
         }
      }
      if(playTpFlg){
         Print("TP Alertm");
         last_alerm_tp = rates[0].time;
         PlaySound("::tp.wav");
      }
      if(playSlFlg){
         Print("SL Alertm");
         last_alerm_sl = rates[0].time;
         PlaySound("::sl.wav");
      }
   }
}


//+------------------------------------------------------------------+
//| 価格をpipsに換算する関数
//+------------------------------------------------------------------+
double PriceToPips(double price)
{
   double pips = 0;

   // 現在の通貨ペアの小数点以下の桁数を取得
   int digits = SymbolInfoInteger(Symbol(), SYMBOL_DIGITS);

   // 3桁・5桁のFXブローカーの場合
   if(digits == 3 || digits == 5){
     pips = price * MathPow(10, digits) / 10;
   }
   // 2桁・4桁のFXブローカーの場合
   if(digits == 2 || digits == 4){
     pips = price * MathPow(10, digits);
   }
   // 少数点以下を１桁に丸める（目的によって桁数は変更する）
   pips = NormalizeDouble(pips, 1);

   return(pips);
}

//+------------------------------------------------------------------+
//| pipsを価格に換算する関数
//+------------------------------------------------------------------+
double PipsToPrice(double pips)
{
   double price = 0;

   // 現在の通貨ペアの小数点以下の桁数を取得
   int digits = SymbolInfoInteger(Symbol(), SYMBOL_DIGITS);

   // 3桁・5桁のFXブローカー
   if(digits == 3 || digits == 5){
     price = pips / MathPow(10, digits) * 10;
   }
   // 2桁・4桁のFXブローカー
   if(digits == 2 || digits == 4){
     price = pips / MathPow(10, digits);
   }
   // 価格を有効桁数で丸める
   price = NormalizeDouble(price, digits);
   return(price);
}

double calcLot(double ep, double sl, double margin){
   // 証拠金の%損失で計算する
   double margin_unit;
   double lose = MathAbs(ep - sl);
   double balance = AccountInfoDouble(ACCOUNT_EQUITY);
   double min_lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double max_lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   if(!OrderCalcProfit(ORDER_TYPE_BUY, _Symbol, 1, ep, ep-lose, margin_unit))
   {
      Print("calcLot Error OrderCalcProfit error =",GetLastError());
      ResetLastError();
      return 0;
   }
   if(margin_unit==0)
   {
      return min_lot;
   }
   if(margin == 0)
   {
      margin = (balance * MaxLossMarginPercent / 100);
   }
   Lot = margin / MathAbs(margin_unit);
   Lot = MathFloor(Lot / min_lot) * min_lot;
   if(Lot < min_lot)
   {
      Lot = min_lot;
   }
   if(Lot > max_lot)
   {
      Lot = max_lot;
   }

   return Lot;
}

double calcCloseLot(double volume){
   if(ExitPercent>=100)
      return volume;
   // 証拠金の%損失で計算する
   double min_lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   volume = volume * ExitPercent / 100;
   volume = MathFloor(volume / min_lot) * min_lot;
   if(volume < min_lot)
   {
      volume = min_lot;
   }

   return volume;
}

double calcCloseLotToPercent(double volume, int percent){
   if(percent>=100)
      return volume;
   // 証拠金の%損失で計算する
   double min_lot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   volume = volume * percent / 100;
   volume = MathFloor(volume / min_lot) * min_lot;
   if(volume < min_lot)
   {
      volume = min_lot;
   }

   return volume;
}

string calcCandleTime(){
   MqlDateTime beforeDt;
   MqlDateTime nextDt;
   datetime lastTime = iTime(_Symbol, 0, 0);
   datetime now = TimeCurrent();
   datetime nextTime;
   int h, d;
   switch(_Period){
      case PERIOD_M1:
      case PERIOD_M2:
      case PERIOD_M3:
      case PERIOD_M4:
      case PERIOD_M5:
      case PERIOD_M6:
      case PERIOD_M10:
      case PERIOD_M12:
      case PERIOD_M15:
      case PERIOD_M20:
      case PERIOD_M30:
         // 直近のローソクに分を加算する
         nextTime = lastTime + _Period * 60;
         break;
      case PERIOD_H1:
         h = 1;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H2:
         h = 2;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H3:
         h = 3;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H4:
         h = 4;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H6:
         h = 6;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H8:
         h = 8;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_H12:
         h = 12;
         // 直近のローソクに時を加算する
         nextTime = lastTime + h * 60 * 60;
         break;
      case PERIOD_D1:
         d = 1;
         // 直近のローソクに日を加算する
         nextTime = lastTime + 24 * 60 * 60;
         break;
      case PERIOD_W1:
         d = 7;
         // 直近のローソクに日を加算する
         nextTime = lastTime + 7 * 24 * 60 * 60;
         break;
      case PERIOD_MN1:
         // 直近のローソクに日を加算する
         TimeToStruct(lastTime, beforeDt);
         if(beforeDt.mon < 12){
            beforeDt.mon=beforeDt.mon+1;
         }else{
            beforeDt.year=beforeDt.year+1;
            beforeDt.mon=1;
         }
         nextTime = StructToTime(beforeDt);
         break;
   }

   if(nextTime-now <= 0){
      return "00:00:00";
   }

   MqlDateTime returnDt;
   TimeToStruct(nextTime-now, returnDt);
   // printf("%4d-%02d-%02d %02d:%02d:%02d",returnDt.year,returnDt.mon,returnDt.day,returnDt.hour,returnDt.min,returnDt.sec);

   if(returnDt.day>1){
      // 1日以上
      return StringFormat("%dd %dh",returnDt.day-1,returnDt.hour);
   }else{
      return StringFormat("%02d:%02d:%02d",returnDt.hour,returnDt.min,returnDt.sec);
   }
   
}

double getZoomRate(tool_zoom_rate lv){
   double rate = 1;
   switch(lv){
      case lv2:
         rate = 1.1;
         break;
      case lv3:
         rate = 1.2;
         break;
      case lv4:
         rate = 1.3;
         break;
      case lv5:
         rate = 1.4;
         break;
      case lv6:
         rate = 1.5;
         break;
      case lv7:
         rate = 1.6;
         break;
      case lv8:
         rate = 1.7;
         break;
      case lv9:
         rate = 1.8;
         break;
      case lv10:
         rate = 1.9;
         break;
      case lv11:
         rate = 2.0;
         break;
   }

   return rate;
}

string getZoomCamera(tool_zoom_rate lv){
   string bmp = "camera1.bmp";
   switch(lv){
      case lv2:
         bmp = "camera11.bmp";
         break;
      case lv3:
         bmp = "camera12.bmp";
         break;
      case lv4:
         bmp = "camera13.bmp";
         break;
      case lv5:
         bmp = "camera14.bmp";
         break;
      case lv6:
         bmp = "camera15.bmp";
         break;
      case lv7:
         bmp = "camera16.bmp";
         break;
      case lv8:
         bmp = "camera17.bmp";
         break;
      case lv9:
         bmp = "camera18.bmp";
         break;
      case lv10:
         bmp = "camera19.bmp";
         break;
      case lv11:
         bmp = "camera20.bmp";
         break;
   }

   return bmp;
}

int getNonDuplicateY(int y, int h){
   y -= h;
   y = chkDuplicateY(y, h);

   ArrayResize(position_label_ys, ArraySize(position_label_ys)+1);
   position_label_ys[ArraySize(position_label_ys)-1] = y;

   return y;
}

int chkDuplicateY(int y, int h){
   for(int i=0;i<ArraySize(position_label_ys);i++){
      if(
         y+h > position_label_ys[i] &&
         position_label_ys[i]+h > y
      ){
         y = position_label_ys[i]+h;
         return chkDuplicateY(y, h);
      }
   }

   return y;
}

bool IsSummerTime() {
   bool _ret;
   datetime NowDt = TimeGMT();
   datetime StartDt = TimeGMT();
   datetime EndDt = TimeGMT();
   MqlDateTime StartTime;
   MqlDateTime EndTime;
   TimeToStruct(StartDt, StartTime);
   TimeToStruct(EndDt, EndTime);
   // 3-1
   StartTime.mon = 3;
   StartTime.day = 1;
   // 11-1
   EndTime.mon = 11;
   EndTime.day = 1;
   // 曜日を得るために構造体を再構築
   StartDt = StructToTime(StartTime);
   EndDt = StructToTime(EndTime);
   TimeToStruct(StartDt, StartTime);
   TimeToStruct(EndDt, EndTime);

   // 3月第2日曜日を探す
   switch(StartTime.day_of_week) {
      case 0:
         StartTime.day = 8;
         break;
      case 1:
         StartTime.day = 14;
         break;
      case 2:
         StartTime.day = 13;
         break;
      case 3:
         StartTime.day = 12;
         break;
      case 4:
         StartTime.day = 11;
         break;
      case 5:
         StartTime.day = 10;
         break;
      case 6:
         StartTime.day = 9;
         break;
   }

   // 11月第1日曜日を探す
   switch(EndTime.day_of_week) {
      case 0:
         EndTime.day = 1;
         break;
      case 1:
         EndTime.day = 7;
         break;
      case 2:
         EndTime.day = 6;
         break;
      case 3:
         EndTime.day = 5;
         break;
      case 4:
         EndTime.day = 4;
         break;
      case 5:
         EndTime.day = 3;
         break;
      case 6:
         EndTime.day = 2;
         break;
   }
   StartDt = StructToTime(StartTime);
   EndDt = StructToTime(EndTime);

   if(
      NowDt >= EndDt
      || NowDt < StartDt
   ) {
      // 冬時間
      _ret = false;
   }else {
      // 夏時間
      _ret = true;
   }
   // if(_ret) {
   //    Print("SUMMER TIME");
   // }
   // else {
   //    Print("WINTER TIME");
   // }
   return(_ret);
}

int FirstOrCreateMAIndicator(ENUM_TIMEFRAMES timeframe, int period, ENUM_MA_METHOD method)
  {
   int idx=-1;
   
   int indMAsTotal=ArraySize(_IndMAs);
   for(int i=0;i<indMAsTotal;i++)
     {
      if(_IndMAs[i].timeframe==timeframe &&
         _IndMAs[i].period==period &&
         _IndMAs[i].method==method)
        {
         idx=i;
         break;
        }
     }
     
   if(idx==-1)
     {
      ArrayResize(_IndMAs,++indMAsTotal,10);
      _IndMAs[indMAsTotal-1].timeframe=timeframe;
      _IndMAs[indMAsTotal-1].period=period;
      _IndMAs[indMAsTotal-1].method=method;      
      
      idx=indMAsTotal-1;
     }
     
   if(_IndMAs[idx].handle==INVALID_HANDLE)
     {
      int handle=iMA(NULL,0,_IndMAs[idx].period,0,_IndMAs[idx].method,PRICE_CLOSE);
      if(handle==INVALID_HANDLE) 
        { 
         //--- tell about the failure and output the error code 
         PrintFormat("Failed to create handle of the iMA indicator for the symbol %s/%s, error code %d", 
                     _Symbol, 
                     EnumToString(PERIOD_CURRENT), 
                     GetLastError());   
        }
        
      _IndMAs[idx].handle=handle;
     }
   
   return _IndMAs[idx].handle;  
  }
  
string sTfTable[] = {"M1","M5","M15","M30","H1","H4","D1","W1","MN"};
int    iTfTable[] = {1,5,15,30,16385,16388,16408,32769,49153};

int str2tf(string tfs)
{
   StringToUpper(tfs);
   for (int i=ArraySize(iTfTable)-1; i>=0; i--)
   {
      if (tfs==sTfTable[i] || tfs==""+IntegerToString(iTfTable[i])) 
      {
//         return(MathMax(iTfTable[i],Period()));
         return(iTfTable[i]);
      }
   }
   return(Period());
   
}

string tf2str(int tf)
{
   if(tf==0) tf=Period();
   for (int i=ArraySize(iTfTable)-1; i>=0; i--) 
         if (tf==iTfTable[i]) return(sTfTable[i]);
   return("");
}  