// function that fetches the expense data from the server and renders json through the users controller; this is test function to then do the same thing for the whole feed. it will be messy.
function fetchSumData(){
  $.get('/users/'+user+'/feed_sum', function(json){
    var num_expenses = json.num_expenses;
    var expenses_sum = json.expenses_sum;
    $('#sum').html("<h3>Total Expenses:</h3><p>"+num_expenses+"</p><h3>Total Expenses sum:</h3><p>"+expenses_sum+"</p>");
  })
}

$(document).ready(fetchSumData);

window.setInterval(fetchSumData, 7000);

function 
