#property strict
string nombre = "primer-bot";
int numero_magico = 1234;
int maximo_precio_interes = 1;

double por_comerciar = 0.03;
//double parar_perdida = -3700;
//double ganancia_objetiva = 280.00;

int maximo_de_comercios = 1;

// Velocidad de Velas medidas en iMA
int ima_lento = 250;
int ima_rapido = 140;


// Tiempo
bool si = True;
string imprime = "Imprime cada 10 segundos el tiempo actual: ";

int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

  }
void OnTick()
  {
      double lento_movimientoAverage = iMA(NULL, 0, ima_lento, 0, MODE_SMA, PRICE_CLOSE, 0);
      double rapid_movimientoAverage = iMA(NULL, 0, ima_rapido, 0, MODE_SMA, PRICE_CLOSE, 0);
      
      
      
      if(si)
      {
         int resultado_orden = OrderSend(Symbol(), OP_BUY, por_comerciar, Ask, 10, 0, 0, "Compra", numero_magico, 0,clrGreen);
         Print("Abre compra cada 10 segundos", TimeCurrent());
         //Print("Hay ordenes abiertas?: ", revisar_ordenes_abiertas());
         
      }
      si = false;
      
      if (True) {
         Sleep(14400000);
         int resultado_orden = OrderSend(Symbol(), OP_BUY, por_comerciar, Ask, 10, 0, 0, "Compra", numero_magico, 0,clrGreen);
         Print("Abre compra cada 10 segundos", TimeCurrent());
         
         return;
      
      }
      
      
      
//      if (total_de_comercios() < maximo_de_comercios)
//      {
//         
//      } 
   
  }
  
// Devolver el numero de comercios abiertos
int total_de_comercios()
{
   int comercios_totales = 0;
   
   for(int t=0;t<OrdersTotal();t++)
      {
         if(OrderSelect(t, SELECT_BY_POS, MODE_TRADES))
           {
            if(OrderSymbol() != Symbol()) continue;
            if(OrderMagicNumber() != numero_magico) continue;
            if(OrderCloseTime() != 0) continue;
            
            comercios_totales = (comercios_totales + 1);
           }
      }
     
     return comercios_totales;
}


// Cerrar los comercios
void cerrar_orden()
{

   int resultado_cerrado = 0;
   for(int t=0;t<OrdersTotal();t++)
     {
       if (OrderMagicNumber() != numero_magico) continue;
       if (OrderSymbol() != Symbol()) continue;
       if (OrderType() == OP_BUY) resultado_cerrado = OrderClose(OrderTicket(), OrderLots(), Bid, maximo_precio_interes, clrRed);
       // if (OrderType() == OP_SELL) resultado_cerrado = OrderClose(OrderTicket(), OrderLots(), Ask, maximo_precio_interes, clrGreen);
       t--;
     }
  
   return;
}


bool revisar_ordenes_abiertas()
{
   for(int i=0;i<OrdersTotal();i++) {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES); {
         if (OrderSymbol() == Symbol()) return(true);
         
       }
   }
   
   return(false);
}




// Obtener el total de las ganancias
//double total_de_ganancias()
//{
//   double ganancias_totales = 0.0;
//   for(int t=0;t<OrdersTotal();t++)
//     {
//      if(OrderSelect(t, SELECT_BY_POS, MODE_TRADES))
//      {
//         if (OrderMagicNumber() != numero_magico) continue;
//         if (OrderSymbol() != Symbol()) continue;
//         if (OrderCloseTime() != 0) continue;
//         ganancias_totales = (ganancias_totales + OrderProfit());
//      }
//     }
//   return ganancias_totales;
//}