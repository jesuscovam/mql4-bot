
//+------------------------------------------------------------------+
#property copyright "Jesus Cova"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


extern double lotaje = 0.03;
extern int magicNumber = 10001;
extern int slippage = 3;
extern double stopLoss = 20;
extern double takeProfit = 40;

int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {
   Print("Hola Mundo! 1");
   double miPunto = Point;
   if(Digits == 3 || Digits == 5) miPunto =Point*10;
   Print("TP:",takeProfit * miPunto);
   Print("SL:", stopLoss * miPunto);
   
   double theStopLoss = 0;
   double theTakeProfit = 0;
   if(true) // total de compras
     {
      // Compra 
      Print("Hola Mundo 2");
      int compra = OrderSend(Symbol(), OP_BUY, lotaje, Ask, slippage, stopLoss, takeProfit, "Compra", magicNumber, 0, clrRed);
      if (compra < 0) // COMPRA > 0;
      {
         theStopLoss= 0;
         Print("SL 1: ", theStopLoss);
         theTakeProfit= 0;
         if(takeProfit > 0) theTakeProfit = Ask+ (takeProfit * miPunto);
  
         if(stopLoss > 0) theStopLoss = Ask - (stopLoss * miPunto);
         Print("SL 2: ", theStopLoss);
         OrderSelect(compra, SELECT_BY_TICKET);
         OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(theStopLoss, Digits), NormalizeDouble(theTakeProfit, Digits), 0, clrRed);
      } 
      
      
     }
  
   //OrderSend(Symbol(), OP_BUY, lotaje, Ask, 0,
   
  }

int totalDeCompras()
  {
      int result= 0;
      for(int i= 0; i < OrdersTotal(); i++)
      {
         OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
         if (OrderMagicNumber() == magicNumber) result++;
      }
      return(result); 
  }
