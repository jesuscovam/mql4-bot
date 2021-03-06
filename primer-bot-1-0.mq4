﻿#property copyright "Jesus Cova"
#property link "www.twitter.com/jesusacova"
#property version "1.0"
#property strict



// Información Inicial Necesaria
// Aquí podran editar sus valores

string nombre = "primer-bot";
int numero_magico = 1234;  // que determina cuando el bot hace compra o venta

double lotaje = 0.03;
double stop_loss = 20;
double take_profit = 40;

// Velocidad de Velas medidas en iMA  ------ACTUALMENTE SIN UTILIZAR
//int ima_lento = 250;
//int ima_rapido = 140;


// Tiempo
bool primera_compra = True;
int tiempo = 10000; // Tiempo en milisegundos de cada cuanto se repite el codigo


int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

  }
void OnTick() {

   // Actualmente no se está utilizando
   //double lento_movimientoAverage = iMA(NULL, 0, ima_lento, 0, MODE_SMA, PRICE_CLOSE, 0);
   //double rapid_movimientoAverage = iMA(NULL, 0, ima_rapido, 0, MODE_SMA, PRICE_CLOSE, 0);
   

   double n_digitos = calcular_digitos_normalizados();
         
   // PRIMERA COMPRA
   if(primera_compra) {
      int compra_orden = OrderSend(Symbol(), OP_BUY, lotaje, Ask, 2, Ask-(stop_loss*n_digitos), Ask+(take_profit*n_digitos), "Compra", numero_magico, 0,clrRed);
      int compra_venta = OrderSend(Symbol(), OP_SELL, lotaje, Ask, 2, Ask+(stop_loss*n_digitos), Ask-(take_profit*n_digitos), "Venta", numero_magico, 0, clrGreen); 
      //Print("Abre compra cada 10 segundos", TimeCurrent());
      //Print("Hay ordenes abiertas?: ", revisar_ordenes_abiertas());   
   }
   primera_compra = false;  // Se determina Falso para que no se repita
         
   // BUCLE DE CADA 4 HORAS
   if (True) {
      Sleep(tiempo);
      int compra_orden = OrderSend(Symbol(), OP_BUY, lotaje, Ask, 2, Ask-(stop_loss*n_digitos), Ask+(take_profit*n_digitos), "Compra", numero_magico, 0,clrGreen);
      int compra_venta = OrderSend(Symbol(), OP_SELL, lotaje, Ask, 2, Ask+(stop_loss*n_digitos),Ask-(take_profit*n_digitos), "Venta", numero_magico, 0, clrGreen);
      Print("Abre compra cada 10 segundos", TimeCurrent());
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
