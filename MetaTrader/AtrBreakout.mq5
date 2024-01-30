#property copyright "Copyright 2024, Dominik Hahn"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <trade/trade.mqh>

input double Lotsize = 0.1;
input int TpPoints = 1000;
input int SlPoints = 1000;
input ENUM_TIMEFRAMES Timeframe = PERIOD_H1;
input int AtrPeriods = 14;
input double TriggerFactor = 2.5;
input int TslTriggerPoints = 200;
input int TslPoints = 100;
input string Commentary = "atr breakout";
input int Magic = 1;

int handleAtr;
int barsTotal;
CTrade trade;

int OnInit() {
   Print("this is OnInit function");
   trade.SetExpertMagicNumber(Magic);
   handleAtr = iATR(NULL, Timeframe, AtrPeriods);
     barsTotal = iBars(NULL, Timeframe);
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
   Print("Test",reason);
   IndicatorRelease(handleAtr);
}

void OnTick() {

   for(int i = 0; i < PositionsTotal(); i++){
      ulong posTicket = PositionGetTicket(i);
      
      if(PositionGetSymbol(POSITION_SYMBOL) != _Symbol) continue;
      if(PositionGetInteger(POSITION_MAGIC) != Magic) continue;
      
      double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      
      double posPriceOpen = PositionGetDouble(POSITION_PRICE_OPEN);
      double posSl = PositionGetDouble(POSITION_SL);
      double posTp = PositionGetDouble(POSITION_TP);
      
      if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
         if(bid > posPriceOpen + TslTriggerPoints * _Point){
            double sl = bid - TslPoints * _Point;
            sl = NormalizeDouble(sl,_Digits);
            
            if(sl > posSl){
               trade.PositionModify(posTicket,sl,posTp);
            }
         }
      } else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
         if(ask < posPriceOpen - TslTriggerPoints * _Point){
            double sl = ask + TslPoints * _Point;
            sl = NormalizeDouble(sl,_Digits);
            
            if(sl < posSl || posSl == 0){
               trade.PositionModify(posTicket,sl,posTp);
            }
         }
      }
   }

   int bars = iBars(NULL, Timeframe);
   
   if (barsTotal != bars) {
      barsTotal = bars;      
      double atr[];
      CopyBuffer(handleAtr, 0, 1, 1, atr);
      
      double open = iOpen(NULL, Timeframe, 1);
      double close = iClose(NULL, Timeframe, 1);
            
      if (open < close && (close - open) > (atr[0] *  TriggerFactor)) {
         Print("buy signal");
         executeBuy();
        
      } else if (open > close && (open - close) > (atr[0] * TriggerFactor)) {
         executeSell();      
       }   
   }
}

void executeBuy(){
   double entry = NormalizeDouble(SymbolInfoDouble(NULL,SYMBOL_ASK), _Digits);
   double tp = entry + TpPoints * _Point;
   tp = NormalizeDouble(tp, _Digits);
   
   double sl = entry - SlPoints * _Point;
   sl = NormalizeDouble(sl, _Digits);
   
   trade.Buy(Lotsize, NULL, entry, sl, tp, Commentary);
}

void executeSell(){
   double entry = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double tp = entry - TpPoints * _Point;
   tp = NormalizeDouble(tp, _Digits);
   double sl = entry + SlPoints * _Point;
   sl = NormalizeDouble(sl, _Digits);
   trade.Sell(Lotsize, NULL, entry, sl, tp, Commentary);
}