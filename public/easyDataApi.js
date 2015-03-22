var _easy_data = (function (){

  var _ed_url = "http://localhost:3000/events.json";

  return function (_event_name){
    var _ed_event = {
      name: _event_name
    };
    var _ed_request = new XMLHttpRequest();
    _ed_request.open("POST", _ed_url, true);
    _ed_request.setRequestHeader('Content-Type', 'application/json');
    _ed_request.onreadystatechange = function() {
      // this function runs when the Ajax request changes state.
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
    }; 
    _ed_request.send(JSON.stringify(_ed_event));
  };
}());