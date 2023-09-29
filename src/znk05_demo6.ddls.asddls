@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 6: Aggregat Functions'

define view entity ZNK05_DEMO6
  as select from /dmo/flight
{
  carrier_id,
  count(*)                                                    as Count1,
  count (distinct plane_type_id)                              as NumberOfDifferentPlaneTypeIds,
  sum(seats_max)                                              as TotalSeatsMax,
  sum(seats_occupied)                                         as TotalOccupied,
  min(seats_occupied)                                         as MinSeatsOccupied,
  max(seats_occupied)                                         as MaxSeatsoccupied,
  sum(case when seats_max = seats_occupied then 1 else 0 end) as NumberOfBookedUpFlights,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  avg(price as abap.curr(16,2))                               as AvgPrice,
  currency_code                                               as CurrencyCode
}

group by
  currency_code,
  carrier_id

having
  avg(price as abap.curr(16,2)) > 5000
