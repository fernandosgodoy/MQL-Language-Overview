
void OnStart() 
{
    //Declaração de variáveis
    datetime inicio, fim;
    double lucro, perda;
    int trades;
    double resultado;
    ulong ticket;

    //Obtenção do Histórico
    MqlDateTime inicioStruct;
    int trades = 0;
    double perda, lucro = 0;
    fim = TimeCurrent(inicioStruct);        //retorna o horário atual.
    inicioStruct.hour = 0;
    inicioStruct.min = 0;
    inicioStruct.sec = 0;
    inicio = StructToTime(inicioStruct);

    HistorySelect(inicio, fim);     //Obtem o Histórico

    //Cálculos
    
    //HistoryDealsTotal-> Histórico dos trades.
    for(int i=0; i<HistoryDealsTotal(); i++) {
        ticket = HistoryDealGetTicket(i);      //Se retornar 0, significa que tevo algum erro.

        if (ticket > 0)
        {
            if (HistoryDealGetString(ticket, DEAL_SYMBOL) == _Symbol) {
                trades ++;
                resultado = HistoryDealGetDouble(ticket, DEAL_PROFIT);

                if (resultado < 0) {
                    perda += -resultado;
                }
                else
                {
                    lucro += resultado;
                }
            }
        }
    }

    double fatorLucro;
    if (perda > 0) {
        fatorLucro = lucro / perda;
    } 
    else
        fatorLucro = -1;

    double resultadoLiquido = lucro - perda;

    //Exibição
    Comment("Trades: ", trades, " Lucro:", DoubleToString(lucro, 2), 
        " Perda: ", DoubleToString(perda, 2), 
        "Resultado: ", DoubleToString(resultadoLiquido,2 ), 
        "FL:", DoubleToString(fatorLucro, 2));

}