
#property copyright "Jesus Cova "
#property link      "https://www.twitter.com/jesusacova"
#property version   "1.00"
#property strict


// Datos para trabajar
double stop_loss = 20;
double take_profit = 40;
double lotaje = 0.03;
double slippage = 5;
int numero_magico = 1234;
bool primera_compra = true;
int tiempo = 10000;


int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {
   // NormalizeDouble funcion nativa de MQL4 para estabilizar valores
   // decimales
   double n_digitos= calcular_digitos_normalizados();
   double open_precio = NormalizeDouble(Ask,Digits);
   // Compra
   double stop_loss_compra = NormalizeDouble(Ask-stop_loss*n_digitos, Digits);
   double take_profit_compra = NormalizeDouble(Ask+take_profit*n_digitos, Digits);
   // Venta
   double stop_loss_venta = NormalizeDouble(Ask+stop_loss*n_digitos, Digits);
   double take_profit_venta = NormalizeDouble(Ask-take_profit*n_digitos, Digits);
   
   
   if(Digits ==3 || Digits==5) {
      slippage=slippage*10;
      
   }
   
   if(primera_compra) {
      int compra_orden = OrderSend(Symbol(), OP_BUY, lotaje, Ask, slippage, stop_loss_compra, take_profit_compra, "COMPRA", numero_magico, 0, clrRed);
      int venta_orden = OrderSend(Symbol(), OP_SELL, lotaje, Ask, slippage, stop_loss_venta, take_profit_venta, "VENTA", numero_magico, 0, clrGreen);
   
   }
   
   primera_compra = false;
   
    // bucle de tiempo
   if (True) {
      Sleep(tiempo);
      int compra_orden = OrderSend(Symbol(), OP_BUY, lotaje, Ask, slippage, stop_loss_compra, take_profit_compra, "COMPRA", numero_magico, 0, clrRed);
      int venta_orden = OrderSend(Symbol(), OP_SELL, lotaje, Ask, slippage, stop_loss_venta, take_profit_venta, "VENTA", numero_magico, 0, clrGreen);
      return;
   }  
   
   
   
  }

double calcular_digitos_normalizados() {

   // Digitos de 3 o menos (JPY)
   if(Digits<= 3) {
      return(0.01);
   }
   
   // Digitos de 4 o más
   if(Digits>= 4){
      return(0.0001);
   }
   
   // No debería suceder 
   else return(0);
}