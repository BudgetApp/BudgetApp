//js function that gets the sum data from the server and renders it into the sum div
//ruby route/path that returns the data needed

//periodically have the browser check and reload again

function fetchSumData(){
  //users confirmed friends expenses and their sum total
  // 1. Fetch the data that we need from a route, "/feed_sum".  The data is a json object that looks like this:
  //   {"num_expenses": 14, "expenses_sum": 132.40}
  // 2. With that json object, render HTML into the "sum" div.
  // For now, we hard-code the user.
  // TODO: Do not hard-code the user.
  var user = "ahimmelstoss";
  $.get('/users/'+user+'/feed_sum', function(json){
    var num_expenses = json.num_expenses;
    var expenses_sum = json.expenses_sum;
    $('#sum').html("<h3>Total Expenses:</h3><p>"+num_expenses+"</p><h3>Total Expenses sum:</h3><p>"+expenses_sum+"</p>");
  })
}

$(document).ready(fetchSumData);

window.setInterval(fetchSumData, 7000);
