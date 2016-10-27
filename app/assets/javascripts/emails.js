function getEmails(){
  var requestStart = new Date();
  var processAndDisplayEmails = function(res){
    var operationResults = returnUnique(res);
    var requestTime = "Request took " + String(new Date - requestStart) + "ms.";
    var results = { requestTime: requestTime, operation: operationResults };
    displayResults(results);
  };
  var emailEndpoint = 'https://chefsteps-email.herokuapp.com/api/emails';
  $.get(emailEndpoint).then(processAndDisplayEmails);
}

function returnUnique(array){
  var operationStart = new Date();
  var unique = {};

  var pushToUnique = function(email){ unique[email] = true; };
  array.forEach(pushToUnique);
  
  uniqueArray = Object.keys(unique);
  elapsedTime = (new Date() - operationStart);
  
  return {
    array: uniqueArray,
    time: "Operation took " + String(elapsedTime) + "ms, not bad."
  };
}

function appendElement(parentId){
  var $parent = document.getElementById(parentId);
  return function(element) {
    var $element = document.createElement(element.type);
    var $content = document.createTextNode(element.text);
    $element.appendChild($content); 
    $parent.appendChild($element);
    if(element.listener) $element.addEventListener("click", element.listener);
  }
}

function displayResults(results) {
  var showEmails = function(){
    var emails = results.operation.array.join('\n');
    var element = { type: 'PRE', text: emails };
    appendElement('results')(element);
  };
  
  var elementsToAppend = [
    { type: 'P', text: '===' },
    { type: 'P', text: results.requestTime },
    { type: 'P', text: results.operation.time },
    { type: 'BUTTON', text: 'Show me the emails', listener: showEmails },
    { type: 'P', text: '===' }
  ];
  
  elementsToAppend.forEach( appendElement('results') );
}


$('document').ready(function(){
  document.getElementById('do-it-with-js').addEventListener("click", getEmails);
});