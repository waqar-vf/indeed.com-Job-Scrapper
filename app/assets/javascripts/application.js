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
function something_went_wrong() {
    alert('Something went wrong. Please try again later');
    $("#waiting_bar").modal("hide")
}
function get_all_emails_success() {
    alert("All emails for the current active batch are in the system. You can download csv now.")
    $("#waiting_bar").modal("hide")
}