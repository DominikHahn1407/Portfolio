#property copyright "Copyright 2024, Dominik Hahn"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <trade/trade.mqh>

input ENUM_TIMEFRAMES Timeframe = PERIOD_H1;
input int AtrPeriods = 14;
input double TriggerFactor = 2.5;

int handleAtr;

int OnInit() {
   Print("this is OnInit function");
   handleAtr = iATR(NULL, Timeframe, AtrPeriods);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
   Print("Test",reason);
   IndicatorRelease(handleAtr);
}

void OnTick() {
   double atr[];
   CopyBuffer(handleAtr, 0, 1, 1, atr);
   
   double open = iOpen(NULL, Timeframe, 1);
   double close = iClose(NULL, Timeframe, 1);
   
   if (open < close && (close - open) > (atr[0] *  TriggerFactor)) {
      Print("buy signal");
   } else if (open > close && (open - close) > (atr[0] * TriggerFactor)) {
      Print("sell signal");
   }   
}
