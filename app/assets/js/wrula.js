define( [ 'jquery-ajax-only', 'uuid', 'jquery.cookie' ], function( $, Uuid ) {

  var visitorCookie = 'wrula_visitor',
      sessionCookie = 'wrula_session';

  // True if cookie is present, if cookie is not present, cookie is created.
  function hasCookie( cookieName, opts ) {
    if ( $.cookie( cookieName ) ) {
      return true;
    } else {
      $.cookie( cookieName, Uuid.generate(), opts );
      return false;
    }
  }

  function isNewVisitor() {
    return !hasCookie( visitorCookie, { expires : 3653, path : '/' } );
  }

  function isNewSession() {
    return !hasCookie( sessionCookie, { path : '/' } );
  }

  function getVisitorId() {
    return $.cookie( visitorCookie );
  }

  function getSessionId() {
    return $.cookie( sessionCookie );
  }

  function getAccountId() {
    var scripts = document.getElementsByTagName( 'script' ),
        accountId;
    for ( var i = 0, l = scripts.length; i < l; i++ ) {
      accountId = scripts[i].getAttribute( 'data-wrula-account-id' );
      if ( accountId ) break;
    }
    return accountId;
  }

  var pageData = {
    account_id  : getAccountId(),
    page_domain : window.location.host,
    path        : window.location.pathname,
    params      : window.location.hash,
    new_visitor : isNewVisitor(),
    new_session : isNewSession(),
    visitor_id  : getVisitorId(),
    session_id  : getSessionId()
  };

  $.post( 'http://wrulametrics.com', pageData );

} );