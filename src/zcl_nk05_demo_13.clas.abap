CLASS zcl_nk05_demo_13 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_nk05_demo_13 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT FROM ZNK05_Demo13
    FIELDS CarrierId, ConnectionId, FlightDate, CarrierName, AirportFromId, AirportToId, \_Bookings-booking_id, \_Bookings-booking_date
    INTO TABLE @data(flights)
    UP TO 100 ROWS.

    out->write( flights ).
  ENDMETHOD.
ENDCLASS.
