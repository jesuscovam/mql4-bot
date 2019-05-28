//+------------------------------------------------------------------+
#property copyright "Jesus Cova"
#property link      "https://www.github.com/jesuscovam"
#property version   "1.6.2"
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
   double miPunto = Point;
   if(Digits == 3 || Digits == 5) miPunto =Point*10;

   double theStopLoss = 0;
   double theTakeProfit = 0;
   if (Hour() == 4 && Minute() == 0 || Hour() == 8 && Minute() == 0  || Hour() == 12 && Minute() == 0  || Hour() == 16 && Minute() == 0  || Hour() == 20 && Minute() == 0  || Hour() == 0 && Minute() == 0 ) // total de compras
   {
      
      // Compra 
      int compra = OrderSend(Symbol(), OP_BUY, lotaje, Ask, slippage, 0, 0, "Compra", magicNumber, 0, clrRed);
      Print("------Compran Sin Modificar!");
      theTakeProfit=Ask+takeProfit*miPunto;
      theStopLoss=Ask-stopLoss*miPunto;
      OrderSelect(compra, SELECT_BY_TICKET);
      OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(theStopLoss,Digits),NormalizeDouble(theTakeProfit,Digits),0,clrRed);
      Print("**********Compra modificada!");
      
      // Venta
      theStopLoss = 0;
      theTakeProfit = 0; 
      Print("-------Venta sin modificar!");
      int venta = OrderSend(Symbol(), OP_SELL, lotaje, Bid, slippage, 0, 0, "Venta", magicNumber, 0, clrGreen);
      theTakeProfit=Bid-takeProfit*miPunto;
      theStopLoss=Bid+stopLoss*miPunto;
      OrderSelect(venta, SELECT_BY_TICKET);
      OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble(theStopLoss,Digits),NormalizeDouble(theTakeProfit,Digits),0,clrGreen);
      Print("********Venta modificada!");
      Print("Hora del Servidor: ", Hour());
      Print("Orden hecha recientemente vamos a esperar 2 minutos para reiniciar el codigo");
      Sleep(120000);
   }
   

   Print("Hora Local: ", TimeLocal());
   Print("(Tiempo del servidor: ", Hour(), "hrs con ", Minute(),  " minutos) Horas Deseadas: 0, 4, 8, 12, 16, y 20");
   return;
   
   
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
