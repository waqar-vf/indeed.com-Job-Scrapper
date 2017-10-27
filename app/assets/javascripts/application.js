// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs

//=# require_tree .

console.log("WORKING")

function show_waiting_bar(){
    $("#waiting_bar").modal("show")
}
function get_batch (obj){
    id = $(obj).val()
    window.top.location.href = "/"+id
}
function something_went_wrong(stack_trace) {
    if (stack_trace == 'undefined')
    {
        stack_trace = ". "
    }
    alert('Something went wrong. Please try again later \r\n Stack Trace:' + stack_trace);
    $("#waiting_bar").modal("hide")
}
function get_all_emails_success() {
    alert("Emails are saved successfully in system for currently active batch. \r\n You can download csv now.")
    $("#waiting_bar").modal("hide")
}