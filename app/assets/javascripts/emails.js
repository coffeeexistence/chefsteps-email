var alreadyGotEmails = false;

function getEmails(){
  if(alreadyGotEmails) return false;
  var requestStart = new Date();
  
  var loading = { type: 'p', text: "Requesting data from api..." };
  var $loading = appendElement('results')(loading);
  
  var processAndDisplayEmails = function(res){
    var operationResults = returnUnique(res);
    var requestTime = "Request took " + String(new Date - requestStart) + "ms.";
    var results = { requestTime: requestTime, operation: operationResults, apiLength: res.length };
    removeElement('results', $loading);
    displayResults(results);
  };
  var emailEndpoint = 'https://chefsteps-email.herokuapp.com/api/emails';
  $.get(emailEndpoint).then(processAndDisplayEmails);
}

function returnUnique(array){
  var operationStart = new Date();
  var emailLog = {};
  var uniqueArray = [];

  var pushToUnique = function(email){ 
    if(!emailLog[email]) {
      emailLog[email] = true;
      uniqueArray.push(email);
    }
  };
  array.forEach(pushToUnique);

  elapsedTime = (new Date() - operationStart);
  console.log(uniqueArray);
  
  return {
    array: uniqueArray,
    time: "Operation took " + String(elapsedTime) + "ms, not bad."
  };
}

function appendElement(parentId){
  var $parent = document.getElementById(parentId);
  return function(element) { // Mmm currying
    var $element = document.createElement(element.type);
    var $content = document.createTextNode(element.text);
    $element.appendChild($content); 
    $parent.appendChild($element);
    if(element.listener) $element.addEventListener("click", element.listener);
    return $element;
  }
}

function removeElement(parentId, $child){
  var $parent = document.getElementById(parentId);
  $parent.removeChild($child);
};

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
    { type: 'P', text: "API delivered: " + results.apiLength + " emails" },
    { type: 'P', text: "Unique emails: " + results.operation.array.length },
    { type: 'BUTTON', text: 'Show me the emails', listener: showEmails },
    { type: 'P', text: '===' }
  ];
  
  elementsToAppend.forEach( appendElement('results') );
}


$('document').ready(function(){
  document.getElementById('do-it-with-js').addEventListener("click", getEmails);
});