CLASS zcl_nk05_demo_10 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_nk05_demo_10 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT FROM ZNK05_Demo10( p_carrierid = 'LH', p_connectionid = '0400' )
    FIELDS *
    INTO TABLE @data(connections).

    out->write( connections ).
  ENDMETHOD.
ENDCLASS.
