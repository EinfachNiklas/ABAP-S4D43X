CLASS zcl_nk05_demo_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_nk05_demo_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT FROM ZNK05_Demo09( p_carrierid = 'LH' )
    FIELDS *
*    WHERE CarrierId = 'LH'
    INTO TABLE @data(connections).

    out->write( connections ).
  ENDMETHOD.
ENDCLASS.
