define( [], function() {

  return Uuid = ( function() {

    var uuidTemplate = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';

    return {

      generate : function() {
        var date = new Date().getTime();
        return uuidTemplate.replace( /[xy]/g, function( component ) {
          var rand = ( date + Math.random()*16 ) % 16 | 0;
          date = Math.floor( date/16 );
          return ( component=='x' ? rand : ( rand & 0x7 | 0x8 ) ).toString( 16 );
        } );
      }

    }

  } () );

} );
