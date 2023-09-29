@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 5: Built-in-functions'

define view entity ZNK05_DEMO05
  as select from /dmo/booking
{
  /* Numerische Funktionen */
  5.0 / 3.0                             as Fltp1,
  division( 5, 3, 2 )                   as Dec1,
  div(5,3)                              as Div1, //Ganzzahlige Division
  mod(5,3)                              as Mod1, //Modulo
  /* Zeichenkettenfunktionen */
  concat_with_space('Hallo','Welt',1)   as Conc1,
  length('X  ')                         as LengthXSS,
  length('  X')                         as LengthSSX,
  /* Einheiten- und Währungsumrechnung */
  flight_price                          as OriginalFlightPrice,
  currency_code                         as CurrencyCode,
  @Semantics.amount.currencyCode: 'ConvertedCurrencyCode'
  currency_conversion(
    amount => flight_price,
    source_currency => currency_code,
    target_currency => cast('EUR' as abap.cuky),
    exchange_rate_date => booking_date,
    error_handling => 'SET_TO_NULL' )   as ConvertedFlightPrice,
  cast('EUR' as abap.cuky)              as ConvertedCurrencyCode,
  /* Datums- und Zeitfunktionen */
  dats_add_days(booking_date,14,'FAIL') as Deadline

}
